# NNCategoryPro
组件化核心模块,通过类别方式极大的扩展基础类功能，目的是提高工作效率。

## 安装

### CocoaPods

```ruby
pod 'NNCategoryPro'
```

CocoaPods 依赖：`NNGloble`、`SDWebImage`、`IQKeyboardManager`。

### Swift Package Manager

Xcode：`File` → `Add Package Dependencies...`，输入：

```
https://github.com/shang1219178163/NNCategoryPro.git
```

或在 `Package.swift` 中：

```swift
dependencies: [
    .package(url: "https://github.com/shang1219178163/NNCategoryPro.git", from: "7.10.3")
]
```

SPM 依赖：`NNGloble`（需 ≥ 2.2.1，已支持 SPM）、`SDWebImage`。  
`IQKeyboardManager` 仅在 CocoaPods 集成时启用；SPM 下如需键盘管理，请自行添加对应依赖。

## 一. Runtime 方法封装
```
@implementation NSObject (Helper)

- (void)enumerateIvars:(void(^)(Ivar v, NSString *name, _Nullable id value))block{
    unsigned int count;
    Ivar *ivars = class_copyIvarList(self.class, &count);

    for(NSInteger i = 0; i < count; i++){
        Ivar ivar = ivars[i];
        NSString *ivarName = [NSString stringWithUTF8String:ivar_getName(ivar)];
        id value = [self valueForKey:ivarName];//kvc读值
        if (block) {
            block(ivar, ivarName, value);
        }
    }
    free(ivars);
}

- (void)enumeratePropertys:(void(^)(objc_property_t property, NSString *name, _Nullable id value))block{
    unsigned int count = 0;
    objc_property_t *properties = class_copyPropertyList(self.class, &count);
    for (int i = 0; i < count; i++) {
        objc_property_t property_t = properties[i];
        const char *name = property_getName(property_t);
        NSString *propertyName = [NSString stringWithUTF8String:name];
        id value = [self valueForKey:propertyName];
        if (block) {
            block(property_t, propertyName, value);
        }
    }
    free(properties);
}

- (void)enumerateMethods:(void(^)(Method method, NSString *name))block{
    unsigned int count = 0;
    Method *methodList = class_copyMethodList(self.class, &count);
    for (unsigned int i = 0; i < count; i++) {
        Method method = methodList[i];
        SEL mthodName = method_getName(method);
//        NSLog(@"MethodName(%d): %@", i, NSStringFromSelector(mthodName));
        if (block) {
            block(method, NSStringFromSelector(mthodName));
        }
    }
    free(methodList);
}

- (void)enumerateProtocols:(void(^)(Protocol *proto, NSString *name))block{
    unsigned int count = 0;
    __unsafe_unretained Protocol **protocolList = class_copyProtocolList(self.class, &count);
    for (int i = 0; i < count; i++) {
        Protocol *protocal = protocolList[i];
        const char *protocolName = protocol_getName(protocal);
//        NSLog(@"protocol(%d): %@", i, [NSString stringWithUTF8String:protocolName]);
        if (block) {
            block(protocal, [NSString stringWithUTF8String:protocolName]);
        }
    }
    free(protocolList);
}

//为 NSObject 扩展 NSCoding 协议里的两个方法, 用来便捷实现复杂对象的归档与反归档
- (void)encodeWithCoder:(NSCoder *)aCoder {
    // 一个临时数据, 用来记录一个类成员变量的个数
    unsigned int ivarCount = 0;
    // 获取一个类所有的成员变量
    Ivar *ivars = class_copyIvarList(self.class, &ivarCount);
    
    // 变量成员变量列表
    for (int i = 0; i < ivarCount; i ++) {
        // 获取单个成员变量
        Ivar ivar = ivars[i];
        // 获取成员变量的名字并将其转换为 OC 字符串
        NSString *ivarName = [NSString stringWithUTF8String:ivar_getName(ivar)];
        // 获取该成员变量对应的值
        id value = [self valueForKey:ivarName];
        // 归档, 就是把对象 key-value 对 encode
        [aCoder encodeObject:value forKey:ivarName];
    }
    // 释放 ivars
    free(ivars);
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    // 因为没有 superClass 了
    self = [self init];
    if (self != nil) {
        unsigned int ivarCount = 0;
        Ivar *ivars = class_copyIvarList(self.class, &ivarCount);
        for (int i = 0; i < ivarCount; i ++) {
            
            Ivar ivar = ivars[i];
            NSString *ivarName = [NSString stringWithUTF8String:ivar_getName(ivar)];
            // 解档, 就是把 key-value 对 decode
            id value = [aDecoder decodeObjectForKey:ivarName];
            // 赋值
            [self setValue:value forKey:ivarName];
        }
        free(ivars);
    }
    return self;
}

- (NSDictionary *)toDictionary{
    NSMutableDictionary *mdic = [NSMutableDictionary dictionary];
    [self enumeratePropertys:^(objc_property_t _Nonnull property, NSString * _Nonnull name, id  _Nullable value) {
        mdic[name] = value ? : @"";
    }];
    return mdic;
}
```
## 二. Objective-C 高阶函数自定义

### NSArray 高阶函数：
```
NS_ASSUME_NONNULL_BEGIN
@interface NSArray<ObjectType> (Helper)

/**
 map 高阶函数(使用时需要将obj强转为数组元素类型)
 */
- (NSArray *)map:(id (NS_NOESCAPE ^)(ObjectType obj, NSUInteger idx))block;

/**
 filter 高阶函数(使用时需要将obj强转为数组元素类型)
 */
- (NSArray *)filter:(BOOL(NS_NOESCAPE ^)(ObjectType obj, NSUInteger idx))block;

/**
 reduce 高阶函数(求和,累加等)
 */
- (NSNumber *)reduce:(NSNumber *)initial block:(NSNumber *(NS_NOESCAPE ^)(NSNumber *result, NSNumber *obj))block;

@implementation NSArray (Helper)

- (NSArray *)map:(id (NS_NOESCAPE ^)(id obj, NSUInteger idx))block{
    if (!block) {
        NSParameterAssert(block != nil);
        return self;
    }
    
    __block NSMutableArray *marr = [NSMutableArray array];
    [self enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        id value = block(obj, idx);
        if (value) {
            [marr addObject:value];
        }
    }];
//    DDLog(@"%@->%@", self, marr.copy);
    return marr.copy;
}

- (NSArray *)compactMap:(id (NS_NOESCAPE ^)(id obj, NSUInteger idx))block{
    if (!block) {
        NSParameterAssert(block != nil);
        return self;
    }

    __block NSMutableArray *marr = [NSMutableArray array];
    [self enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        id value = block(obj, idx);
        if ([value isKindOfClass:NSArray.class]) {
            [marr addObjectsFromArray:value];
        } else {
            [marr addObject:value];
        }
    }];
//    DDLog(@"%@->%@", self, marr.copy);
    return marr.copy;
}

- (NSArray *)filter:(BOOL(NS_NOESCAPE ^)(id obj, NSUInteger idx))block{
    if (!block) {
        NSParameterAssert(block != nil);
        return self;
    }

    __block NSMutableArray *marr = [NSMutableArray array];
    [self enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (block(obj, idx) == true) {
            [marr addObject:obj];
        }
    }];
    return marr.copy;
}

- (NSNumber *)reduce:(NSNumber *)initial block:(NSNumber *(NS_NOESCAPE ^)(NSNumber *result, NSNumber *obj))block{
    if (!block) {
        NSParameterAssert(block != nil);
        return initial;
    }

    __block NSNumber *value = initial;
    [self enumerateObjectsUsingBlock:^(NSNumber *_Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        value = block(value, obj);
    }];
    return value;
}

🌰🌰🌰：
    1. 截取子字符串
    NSArray<NSString *> *list = @[@"1111", @"2222", @"3333", @"4444"];
    NSArray *listOne = [list map:^id * _Nonnull(NSString * _Nonnull obj, NSUInteger idx) {
        return [obj substringToIndex:idx];
    }];
    // listOne_(, 2, 33, 444,)
    
    2. 抽取模型数组对应属性（值为nil则返回对应模型）
    NSMutableArray * marr = [NSMutableArray array];
    for (NSInteger i = 0; i < 5; i++) {
        WHKNetInfoFeedModel * model = [[WHKNetInfoFeedModel alloc]init];
        model.category = [NSString stringWithFormat:@"name_%@", @(i)];
        model.vendor = [NSDateFormatter stringFromDate:NSDate.date format:kFormatDate];
        [marr addObject:model];
    }
    
    NSArray *listTwo = [marr map:^id * _Nonnull(id _Nonnull obj, NSUInteger idx) {
        return [obj valueForKey:@"category"] ? : @"";
    }];
    //  listTwo_( name_0, name_1, name_2, name_3, name_4, )

    3.修改数组模型属性值
     NSArray *listThree = [marr map:^id * _Nonnull(NSObject * _Nonnull obj, NSUInteger idx) {
        [obj setValue:@(idx) forKey:@"category"];
        return obj;
    }];
    //  listThree_(model.category = @(0), model.category = @(1), model.category = @(2), model.category = @(3), model.category = @(4));

    4. 过滤大约@“222”的元素
    NSArray *listTwo = [list filter:^BOOL(id * _Nonnull obj, NSUInteger idx) {
        return [(NSString *)obj compare:@"222" options:NSNumericSearch] == NSOrderedDescending;
    }];
    // listTwo_( 333, 444, )

    5. 过滤不等于@“222”的元素
    NSArray *list2 = [list filter:^BOOL(id * _Nonnull obj, NSUInteger idx) {
        return (![(NSString *)obj isEqualToString:@"222"]);
    }];
    //  list2_(111,333,444,)

    6. array = @[@1, @3, @5, @7, @9];
    NSNumber *result = [array reduce:@(0) block:^NSNumber * _Nonnull(NSNumber * _Nonnull result, NSNumber * _Nonnull obj) {
        return @(num1.floatValue * 10 + num2.floatValue);
    }];
   // result_13579
    
    NSNumber *result1 = [array reduce:@(0) block:^NSNumber * _Nonnull(NSNumber * _Nonnull result, NSNumber * _Nonnull obj) {
        return @(num1.floatValue + num2.floatValue);
    }];
    // result1_25
```
### NSDictionary 高阶函数：
```
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary<KeyType, ObjectType> (Helper)

/**
map 高阶函数
*/
- (NSDictionary *)map:(NSDictionary *(NS_NOESCAPE ^)(KeyType key, ObjectType obj))block;
/**
filter 高阶函数
*/
- (NSDictionary *)filter:(BOOL (NS_NOESCAPE ^)(KeyType key, ObjectType obj))block;
/**
compactMapValues 高阶函数
*/
- (NSDictionary *)compactMapValues:(id (NS_NOESCAPE ^)(ObjectType obj))block;
@end

@implementation NSDictionary(Tmp)

- (NSDictionary *)map:(NSDictionary *(NS_NOESCAPE ^)(id key, id obj))block{
    if (!block) {
        NSParameterAssert(block != nil);
        return self;
    }
    
    __block NSMutableDictionary *mdic = [NSMutableDictionary dictionary];
    [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        NSDictionary *value = block(key, obj);
        if (value) {
            [mdic addEntriesFromDictionary:value];
        }
    }];
    return mdic.copy;
}

- (NSDictionary *)filter:(BOOL (NS_NOESCAPE ^)(id key, id obj))block{
    if (!block) {
        NSParameterAssert(block != nil);
        return self;
    }
    
    __block NSMutableDictionary *mdic = [NSMutableDictionary dictionary];
     [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
         if (block(key, obj) == true) {
             mdic[key] = obj;
         }
     }];
    return mdic.copy;
}

- (NSDictionary *)compactMapValues:(id (NS_NOESCAPE ^)(id obj))block{
    if (!block) {
        NSParameterAssert(block != nil);
        return self;
    }
    
    __block NSMutableDictionary *mdic = [NSMutableDictionary dictionary];
    [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        id value = block(obj);
        if (value) {
            mdic[key] = value;
        }
    }];
    return mdic.copy;
}

🌰🌰🌰：
- (void)funtionMoreDic{
    NSDictionary<NSString *, NSString *> *dic = @{
        @"1": @"111",
        @"2": @"222",
        @"3": @"222",
        @"4": @"444",
    };
    
    NSDictionary *dic1 = [dic map:^NSDictionary * _Nonnull(NSString * _Nonnull key, NSString * _Nonnull obj) {
        return @{[key stringByAppendingFormat:@"%@", @"_"] : [obj stringByAppendingFormat:@"%@", @"_"],
        };
    }];
    DDLog(@"dic1_%@",dic1);
//    2020-07-03 06:20:05.248000+0000【line -305】-[TestViewController funtionMoreDic] dic1_{
//        2_ = 222_;
//        4_ = 444_;
//        1_ = 111_;
//        3_ = 222_;
//    }

    NSDictionary *dic2 = [dic compactMapValues:^id _Nonnull(NSString * _Nonnull obj) {
        return [NSString stringWithFormat:@"%@_", obj];
    }];

    DDLog(@"dic2_%@",dic2);
//    2019-08-26 18:54:36.503000+0800【line -303】-[TestViewController funtionMoreDic] dic1_{
//        3 = 222_;
//        1 = 111_;
//        4 = 444_;
//        2 = 222_;
//    }
    NSDictionary *dic3 = [dic filter:^BOOL(NSString * _Nonnull key, NSString * _Nonnull obj) {
        return [key isEqualToString:@"2"];
    }];
    DDLog(@"dic3_%@",dic3);
//    2019-08-26 18:54:36.504000+0800【line -304】-[TestViewController funtionMoreDic] dic2_{
//        2 = 222;
//    }
    NSDictionary *dic4 = [dic filter:^BOOL(NSString * _Nonnull key, NSString * _Nonnull obj) {
        return [obj isEqualToString:@"222"];
    }];
    DDLog(@"dic4_%@",dic4);
//    2019-08-26 18:54:36.504000+0800【line -305】-[TestViewController funtionMoreDic] dic3_{
//        3 = 222;
//        2 = 222;
//    }
}
```
## 三. 界面
### 手势回调封装
```
#pragma mak - -Recognizer
#pragma mak - -Recognizer
/**
 手势 - 单指点击
 */
- (UITapGestureRecognizer *)addGestureTap:(void(^)(UITapGestureRecognizer *reco))block{
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:nil action:nil];
    recognizer.numberOfTapsRequired = 1;
    recognizer.numberOfTouchesRequired = 1;
//        recognizer.cancelsTouchesInView = false;
//        recognizer.delaysTouchesEnded = false;
    self.userInteractionEnabled = true;
    self.multipleTouchEnabled = true;
    [self addGestureRecognizer:recognizer];

    [recognizer addActionBlock:block];
    return recognizer;
}

/**
 手势 - 长按
 */
- (UILongPressGestureRecognizer *)addGestureLongPress:(void(^)(UILongPressGestureRecognizer *reco))block forDuration:(NSTimeInterval)minimumPressDuration{
    UILongPressGestureRecognizer *recognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:nil action:nil];
    recognizer.minimumPressDuration = minimumPressDuration;
    self.userInteractionEnabled = true;
    self.multipleTouchEnabled = true;
    [self addGestureRecognizer:recognizer];
    
    [recognizer addActionBlock:block];
    return recognizer;
}

/**
 手势 - 拖动
 */
- (UIPanGestureRecognizer *)addGesturePan:(void(^)(UIPanGestureRecognizer *reco))block{
    UIPanGestureRecognizer *recognizer = [[UIPanGestureRecognizer alloc] initWithTarget:nil action:nil];
    recognizer.minimumNumberOfTouches = 1;
    recognizer.maximumNumberOfTouches = 3;
    self.userInteractionEnabled = true;
    self.multipleTouchEnabled = true;
    [self addGestureRecognizer:recognizer];

    [recognizer addActionBlock:block];
    return recognizer;
}

/**
 手势 - 边缘拖动
 */
- (UIScreenEdgePanGestureRecognizer *)addGestureEdgPan:(void(^)(UIScreenEdgePanGestureRecognizer *reco))block forEdges:(UIRectEdge)edges{
    UIScreenEdgePanGestureRecognizer *recognizer = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:nil action:nil];
    recognizer.edges = edges;
    self.userInteractionEnabled = true;
    self.multipleTouchEnabled = true;
    [self addGestureRecognizer:recognizer];
    
    [recognizer addActionBlock:block];
    return recognizer;
}

/**
 手势 - 轻扫
 */
- (UISwipeGestureRecognizer *)addGestureSwipe:(void(^)(UISwipeGestureRecognizer *reco))block forDirection:(UISwipeGestureRecognizerDirection)direction{
    UISwipeGestureRecognizer *recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:nil action:nil];
    recognizer.direction = direction;
    self.userInteractionEnabled = true;
    self.multipleTouchEnabled = true;
    [self addGestureRecognizer:recognizer];

    [recognizer addActionBlock:block];
    return recognizer;
}

/**
 手势 - 捏合
 */
- (UIPinchGestureRecognizer *)addGesturePinch:(void(^)(UIPinchGestureRecognizer *reco))block{
    UIPinchGestureRecognizer *recognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:nil action:nil];
//        recognizer.scale = 1.0;
    self.userInteractionEnabled = true;
    self.multipleTouchEnabled = true;
    [self addGestureRecognizer:recognizer];

    [recognizer addActionBlock:block];
    return recognizer;
}

/**
 手势 - 旋转
 */
- (UIRotationGestureRecognizer *)addGestureRotation:(void(^)(UIRotationGestureRecognizer *reco))block{
    UIRotationGestureRecognizer *recognizer = [[UIRotationGestureRecognizer alloc] initWithTarget:nil action:nil];
    self.userInteractionEnabled = true;
    self.multipleTouchEnabled = true;
    [self addGestureRecognizer:recognizer];

    [recognizer addActionBlock:block];
    return recognizer;
}

```
## 四. 现金金额处理

NSNumber类型处理, 支持四舍五入
```
//
//  NSNumberFormatter+Helper.m
//  Location
//
//  Created by BIN on 2017/12/21.
//  Copyright © 2017年 Shang. All rights reserved.
//

#import "NSNumberFormatter+Helper.h"
#import <NNGloble/NNGloble.h>

NSString * const kNumIdentify = @"四舍五入";// 默认
NSString * const kNumIdentifyDecimal = @"分隔符,保留3位小数";
NSString * const kNumIdentifyPercent = @"百分比";
NSString * const kNumIdentifyCurrency = @"货币$";
NSString * const kNumIdentifyScientific = @"科学计数法 1.234E8";
NSString * const kNumIdentifyPlusSign = @"加号符号";
NSString * const kNumIdentifyMinusSign = @"减号符号";
NSString * const kNumIdentifyExponentSymbol = @"指数符号";

NSString * const kNumFormat = @"#,##0.00";

@implementation NSNumberFormatter (Helper)

static NSDictionary *_styleDic = nil;

+ (NSDictionary *)styleDic{
    if (!_styleDic) {
        _styleDic = @{
                      kNumIdentify: @(NSNumberFormatterNoStyle),
                      kNumIdentifyDecimal: @(NSNumberFormatterDecimalStyle),
                      kNumIdentifyPercent: @(NSNumberFormatterPercentStyle),
                      kNumIdentifyCurrency: @(NSNumberFormatterCurrencyStyle),
                      kNumIdentifyScientific: @(NSNumberFormatterScientificStyle),
                      };
    }
    return _styleDic;
}

+ (NSNumberFormatter *)numberIdentify:(NSString *)identify{
    //使用当前线程字典来保存对象
    NSMutableDictionary *threadDic = NSThread.currentThread.threadDictionary;
    NSNumberFormatter *formatter = [threadDic objectForKey:identify];
    if (!formatter) {
        formatter = [[NSNumberFormatter alloc]init];
        formatter.locale = [NSLocale localeWithLocaleIdentifier:kLanguageCN];
        formatter.minimumIntegerDigits = 1;//最少小数点前的位数
        formatter.minimumFractionDigits = 2;//最少小数点后的位数
        formatter.maximumFractionDigits = 2;//最多小数点后的位数
        formatter.roundingMode = NSNumberFormatterRoundUp;
        //格式
        if ([NSNumberFormatter.styleDic.allKeys containsObject:identify]) {
            NSUInteger style = [NSNumberFormatter.styleDic[identify] unsignedIntegerValue];
            if (style > 10 || style == 7) {
                formatter.numberStyle = NSNumberFormatterNoStyle;
            }
        }
        [threadDic setObject:formatter forKey:identify];
    }
    return formatter;
}

// 小数位数
+ (NSString *)fractionDigits:(NSNumber *)obj
                         min:(NSUInteger)min
                         max:(NSUInteger)max
                roundingMode:(NSNumberFormatterRoundingMode)roundingMode{
    
    NSNumberFormatter *formatter = [NSNumberFormatter numberIdentify:kNumIdentify];
    formatter.minimumFractionDigits = min;//最少小数点后的位数
    formatter.maximumFractionDigits = max;//最多小数点后的位数
    formatter.roundingMode = roundingMode;
    return [formatter stringFromNumber:obj] ? : @"";
}

// 小数位数
+ (NSString *)fractionDigits:(NSNumber *)obj{
    NSString *result = [NSNumberFormatter fractionDigits:obj
                                                     min:2
                                                     max:2
                                            roundingMode:NSNumberFormatterRoundUp];
    return result;
}

+ (NSNumberFormatter *)positiveFormat:(NSString *)formatStr{
    NSNumberFormatter *formatter = [NSNumberFormatter numberIdentify:kNumIdentifyDecimal];
    formatter.positiveFormat = formatStr;
    return formatter;
}

+ (NSNumberFormatter *)positive:(NSString *)formatStr
                         prefix:(NSString *)prefix
                         suffix:(NSString *)suffix
                        defalut:(NSString *)defalut{
    NSNumberFormatter *formatter = [NSNumberFormatter numberIdentify:kNumIdentifyDecimal];
    formatter.positivePrefix = prefix;
    formatter.positiveSuffix = suffix;

    formatter.usesGroupingSeparator = true; //分隔设true
    formatter.groupingSeparator = @","; //分隔符
    formatter.groupingSize = 3;  //分隔位数
    return formatter;
}
/// number为NSNumber/String
+ (NSString *)localizedString:(NSNumberFormatterStyle)nstyle number:(NSString *)number{
    NSString *charSet = @"0123456789.";
    NSCharacterSet *set = [[NSCharacterSet characterSetWithCharactersInString:charSet] invertedSet];
    NSString *result = [[number componentsSeparatedByCharactersInSet:set] componentsJoinedByString:@""];
    NSNumber *value = @([result floatValue]);
    NSString *string = [NSNumberFormatter localizedStringFromNumber:value numberStyle:nstyle];
    return string;
}

@end
```
## 五. 数组、字典防崩溃
```
//
//  NSObject+Hook.m
//  Xcode11Project
//
//  Created by Bin Shang on 2020/7/4.
//  Copyright © 2020 Bin Shang. All rights reserved.
//

#import "NSObject+Hook.h"

@implementation NSObject (Hook)

BOOL swizzleInstanceMethod(Class clz, SEL origSelector, SEL replSelector){
    //    NSLog(@"%@,%@,%@",self,self.class,object_getClass(self));
    if (!clz || !origSelector || !replSelector) {
        NSLog(@"Nil Parameter(s) found when swizzling.");
        return NO;
    }
    
    //1. 通过class_getInstanceMethod()函数从当前对象中的method list获取method结构体，如果是类方法就使用class_getClassMethod()函数获取。
    Method original = class_getInstanceMethod(clz, origSelector);
    Method replace = class_getInstanceMethod(clz, replSelector);
    if (!original || !replace) {
        NSLog(@"Swizzling Method(s) not found while swizzling class %@.", NSStringFromClass(clz));
        return NO;
    }

    if (class_addMethod(clz, origSelector, method_getImplementation(replace), method_getTypeEncoding(replace))) {
        class_replaceMethod(clz, replSelector, method_getImplementation(original), method_getTypeEncoding(original));
    } else {
        method_exchangeImplementations(original, replace);
    }
    return YES;
}

BOOL SwizzleMethodClass(Class clz, SEL origSelector, SEL replSelector){
    //    NSLog(@"%@,%@,%@",self,self.class,object_getClass(self));
    if (!clz || !origSelector || !replSelector) {
        NSLog(@"Nil Parameter(s) found when swizzling.");
        return NO;
    }
    clz = object_getClass(clz);
//    Class metaClass = objc_getMetaClass(class_getName(clz));

    Method original = class_getClassMethod(clz, origSelector);
    Method replace = class_getClassMethod(clz, replSelector);
    if (!original || !replace) {
        NSLog(@"Swizzling Method(s) not found while swizzling class %@.", NSStringFromClass(clz));
        return NO;
    }
    
    if (class_addMethod(clz, origSelector, method_getImplementation(replace), method_getTypeEncoding(replace))) {
        class_replaceMethod(clz, replSelector, method_getImplementation(original), method_getTypeEncoding(original));
    } else {
        method_exchangeImplementations(original, replace);
    }
    return YES;
}

@end


@implementation NSArray (Hook)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{

        swizzleInstanceMethod(NSClassFromString(@"__NSArrayI"), @selector(objectAtIndex:), @selector(safe_objectAtIndex:));

        swizzleInstanceMethod(NSClassFromString(@"__NSArrayI"), @selector(objectAtIndex:), @selector(safe_objectAtIndex:));

        swizzleInstanceMethod(NSClassFromString(@"__NSArrayI"), @selector(objectAtIndexedSubscript:), @selector(safe_objectAtIndexedSubscript:));


        NSArray *array = @[NSStringFromSelector(@selector(objectAtIndex:)),
                           NSStringFromSelector(@selector(objectAtIndexedSubscript:)),
                           NSStringFromSelector(@selector(insertObject:atIndex:)),
                           NSStringFromSelector(@selector(setObject:atIndexedSubscript:)),
                           NSStringFromSelector(@selector(insertObjects:atIndexes:))
                                        ];
        for (NSString *str in array) {
            swizzleInstanceMethod(NSClassFromString(@"__NSArrayM"),
                                  NSSelectorFromString(str),
                                  NSSelectorFromString([@"safe_" stringByAppendingString:str]));
        }
    });
}

- (id)safe_objectAtIndex:(NSUInteger)index {
    NSUInteger count = self.count;
    if (count == 0 || index >= count) {
        return nil;
    }
    return [self safe_objectAtIndex:index];
}

- (id)safe_objectAtIndexedSubscript:(NSUInteger)index {
    NSUInteger count = [(NSArray*)self count];
    if (count == 0 || index >= count) {
        return nil;
    }
    return [self safe_objectAtIndexedSubscript:index];
}


@end


@implementation NSMutableArray (Hook)

- (id)safe_objectAtIndex:(NSUInteger)index {
    NSUInteger count = [(NSArray*)self count];
    if (count == 0 || index >= count) {
        return nil;
    }
    return [self safe_objectAtIndex:index];
}

- (id)safe_objectAtIndexedSubscript:(NSUInteger)index {
    NSUInteger count = [(NSArray*)self count];
    if (count == 0 || index >= count) {
        return nil;
    }
    return [self safe_objectAtIndexedSubscript:index];
}

- (void)safe_insertObject:(id)anObject atIndex:(NSUInteger)index {
    if (anObject == nil) return;
    [self safe_insertObject:anObject atIndex:index];
}

- (void)safe_setObject:(id)obj atIndexedSubscript:(NSUInteger)idx {
    if (obj == nil) return;
    [self safe_setObject:obj atIndexedSubscript:idx];
}

- (void)safe_insertObjects:(NSArray *)objects atIndexes:(NSIndexSet *)indexes {
    if (objects && objects.count == indexes.count) {
        [self safe_insertObjects:objects atIndexes:indexes];
    }
}

@end


@implementation NSDictionary (Hook)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        swizzleInstanceMethod(NSClassFromString(@"__NSDictionaryM"), @selector(setObject:forKeyedSubscript:), @selector(safe_setObject:forKeyedSubscript:));

        swizzleInstanceMethod(NSClassFromString(@"__NSDictionaryM"),
                              @selector(setObject:forKey:),
                              @selector(safe_setObject:forKey:));

        swizzleInstanceMethod(NSClassFromString(@"__NSDictionaryM"), @selector(removeObjectForKey:), @selector(safe_removeObjectForKey:));
    });
}

- (void)safe_setObject:(id)anObject forKey:(id<NSCopying>)aKey {
    if (anObject && aKey) {
        [self safe_setObject:anObject forKey:aKey];
    }
}

- (void)safe_setObject:(id)anObject forKeyedSubscript:(id<NSCopying>)aKey {
    if (anObject && aKey) {
        [self safe_setObject:anObject forKeyedSubscript:aKey];
    }
}

- (void)safe_removeObjectForKey:(id)aKey {
    if (aKey) {
        [self safe_removeObjectForKey:aKey];
    }
}

@end

```
#### UIViewConroller 避免多个呈现造成的 app 崩溃
```
///避免多个呈现造成的 app 崩溃
- (void)present:(BOOL)animated completion:(void (^ __nullable)(void))completion{
    UIWindow *keyWindow = UIApplication.sharedApplication.delegate.window;
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([self isKindOfClass:UIAlertController.class]) {
            UIAlertController *alertVC = self;
            if (alertVC.actions.count == 0) {
                [keyWindow.rootViewController presentViewController:alertVC animated:animated completion:^{
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(kDurationToast * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [alertVC dismissViewControllerAnimated:animated completion:completion];
                    });
                }];
            } else {
                [keyWindow.rootViewController presentViewController:self animated:animated completion:completion];
            }
        } else {
            [keyWindow.rootViewController presentViewController:self animated:animated completion:completion];
        }
    });
}

///判断是否从 cls 页面 push 过来
- (BOOL)pushFromVC:(Class)cls{    
    NSArray *viewControllers = self.navigationController.viewControllers;
    if (viewControllers.count <= 1) {
        return false;
    }
    
    NSInteger index = [viewControllers indexOfObject:self];
    BOOL result = [viewControllers[index - 1] isKindOfClass:cls];
    return result;
}
```
...

