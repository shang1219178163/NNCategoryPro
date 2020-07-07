# NNCategoryPro
组件化核心模块,通过类别方式极大的扩展基础类功能

一. 崩溃保护NSObject+CashProtector.h

二. Objective-C 高阶函数实现/自定义

NSArray 高阶函数：
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
NSDictionary 高阶函数：
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
三. 界面调试

在 UIView 分类添加方法
```
/**
 给所有自视图加框
 */
- (void)getViewLayer{
    NSArray *subviews = self.subviews;
    if (subviews.count == 0) return;
    for (UIView *subview in subviews) {
        subview.layer.borderWidth = kW_LayerBorder;
        
        #if DEBUG
        subview.layer.borderColor = UIColor.redColor.CGColor;
        #else
        subview.layer.borderColor = UIColor.clearColor.CGColor;
        #endif
        [subview getViewLayer];
    }
}

//使用方法:
[self.view  getViewLayer];
```
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

......

