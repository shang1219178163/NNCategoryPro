//
//  NSObject+Helper.m
//  
//
//  Created by BIN on 2017/8/10.
//  Copyright © 2017年 SHANG. All rights reserved.
//

#import "NSObject+Helper.h"

#import "NSString+Helper.h"
#import "NSDate+Helper.h"

#import "UIImage+Helper.h"
#import "NSBundle+Helper.h"
#import "UIColor+Helper.h"
#import "NSArray+Helper.h"
#import "NSAttributedString+Helper.h"

NSString *NNSwiftClassName(NSString *name){
    NSString *bundleName = NSBundle.mainBundle.infoDictionary[@"CFBundleExecutable"];
    return [bundleName stringByAppendingFormat:@".%@", name];
}

/**
 关联对象的唯一无符号常量值

 @param obj 对象本身
 @param funcAbount 方法名及实参生成的字符串
 @return 根据对象+方法+实参生成的唯一常量值(确保每个对象调用同一方法不同参数的时候,返回的值都是唯一的)
 */
NSString *RuntimeKeyFromParams(NSObject *obj, NSString *funcAbount){
    NSString * unique = [[@(obj.hash) stringValue] stringByAppendingFormat:@",%@",funcAbount];
    return unique;
}

BOOL iOSVer(CGFloat version){
    return (UIDevice.currentDevice.systemVersion.floatValue >= version) ? YES : NO;
}

CGFloat CGRadianFromDegrees(CGFloat x){
    return (M_PI * (x) / 180.0);
}

CGFloat CGDegreesFromRadian(CGFloat x){
    return (x * 180.0)/(M_PI);
}

CGFloat RoundFloat(CGFloat value, NSInteger num){
    NSInteger tem = pow(10, num);
    CGFloat x = value*tem + 0.5;
    CGFloat figure = (floorf(x))/tem;
    return figure;
}

NSString *SwiftClassName(NSString *className){
    NSDictionary *infoDict = NSBundle.mainBundle.infoDictionary;
    NSString * appName = infoDict[(NSString *)kCFBundleExecutableKey] ? : infoDict[(NSString *)kCFBundleNameKey];
    NSString * string = [NSString stringWithFormat:@"%@.%@",appName,className];
    return string;
}

NSString *UrlAddress(NSString *hostname, NSString *port){
    NSString *webUrl = [NSString stringWithFormat:@"%@", hostname];
    if (![hostname containsString:@"http://"]) {
        webUrl = [@"http://" stringByAppendingString: hostname];
    }
    if (![port isEqualToString:@""]) {
        webUrl = [webUrl stringByAppendingFormat:@":%@", port];
    }
    return webUrl;
}

@implementation NSObject (Helper)

#pragma mark -runtime

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

//KVC
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    NSLog(@"setValue: forUndefinedKey:, 动态创建Key: %@",key);
    objc_setAssociatedObject(self, CFBridgingRetain(key), value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(nullable id)valueForUndefinedKey:(NSString *)key{
    NSLog(@"valueForUndefinedKey:, 获取未知键 %@ 的值", key);
//    return nil;
    return objc_getAssociatedObject(self, CFBridgingRetain(key));
}

-(void)setNilValueForKey:(NSString *)key{
    NSLog(@"Invoke setNilValueForKey:, 不能给非指针对象(如NSInteger)赋值 nil");
    return;//给一个非指针对象(如NSInteger)赋值 nil, 直接忽略
}


#pragma mark - -dispatchAsync
void GCDBlock(void(^block)(void)){
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block);
}

void GCDMainBlock(void(^block)(void)){
    if (NSThread.isMainThread) {
        block();
    }
    else{
        dispatch_async(dispatch_get_main_queue(), block);
    }
}

void GCDAfterMain(double delay ,void(^block)(void)){
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), block);
}

void GCDApplyGlobal(id obj ,void(^block)(size_t index)){
    NSCAssert([obj isKindOfClass:[NSArray class]] || [obj isKindOfClass:[NSDictionary class]] || [obj isKindOfClass:[NSNumber class]] || [obj isKindOfClass:[NSSet class]], @"必须是集合或者NSNumber");
    if ([obj isKindOfClass:[NSNumber class]]) {
        dispatch_apply([obj unsignedIntegerValue], dispatch_get_global_queue(0, 0), block);

    }
    else{
        dispatch_apply([obj count], dispatch_get_global_queue(0, 0), block);

    }
}

#pragma mark - -validObject

-(BOOL)validObject{
    if ([self isKindOfClass:[NSNull class]]) return NO;
    
    if ([self isKindOfClass:[NSString class]] || [self isKindOfClass:[NSAttributedString class]]){
        NSString *str = @"";
        if ([self isKindOfClass:[NSAttributedString class]]){
            str = [(NSAttributedString *)self string];
            
        } else {
            str = (NSString *)self;
            
        }
        
        str = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        str = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
        
        NSArray * array = @[@"",@"nil",@"null"];
        if ([array containsObject:str] || [str containsString:@"null"]) {
//            NSLog(@"无效字符->(%@)",string);
           return NO;
        }
        
    }
    else if ([self isKindOfClass:[NSArray class]]){
        if ([(NSArray *)self count] == 0){
//            NSLog(@"空数组->(%@)",self);
            return NO;
        }
    }
    else if ([self isKindOfClass:[NSDictionary class]]){
        if ([(NSDictionary *)self count] == 0){
//            NSLog(@"空字典->(%@)",self);
           return NO;
        }
    }
    return YES;
}


-(void (^)(id, id, NSInteger))blockObject{
    return objc_getAssociatedObject(self, _cmd);
}

-(void)setBlockObject:(void (^)(id, id, NSInteger))blockObject{
    objc_setAssociatedObject(self, @selector(blockObject), blockObject, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void (^)(id))block{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setBlock:(void (^)(id))block{
    objc_setAssociatedObject(self, @selector(block), block, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(NSString *)runtimeKey{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setRuntimeKey:(NSString *)runtimeKey{
    objc_setAssociatedObject(self, @selector(runtimeKey), runtimeKey, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

/**
 富文本只有和一般文字同字体大小才能计算高度
 */
- (CGSize)sizeWithText:(id)text font:(id)font width:(CGFloat)width{
    if (![text validObject]) return CGSizeZero;

    NSAssert([text isKindOfClass:[NSString class]] || [text isKindOfClass:[NSAttributedString class]], @"请检查text格式!");
    NSAssert([font isKindOfClass:[UIFont class]] || [font isKindOfClass:[NSNumber class]], @"请检查font格式!");
    
    if ([font isKindOfClass:[NSNumber class]]) {
        font = [UIFont systemFontOfSize:[(NSNumber *)font floatValue]];
    }
    
    NSDictionary *attrDict = [NSAttributedString paraDictWithFont:((UIFont *)font).pointSize textColor:UIColor.blackColor alignment:NSTextAlignmentLeft];
    CGSize size = CGSizeZero;
    if ([text isKindOfClass:[NSString class]]) {
        size = [text boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:attrDict context:nil].size;
    } else {
        size = [text boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading context:nil].size;
    }
    size.width = ceil(size.width);
    size.height = ceil(size.height);
    return size;
}


- (CGSize)sizeItemsViewWidth:(CGFloat)width items:(NSArray *)items numberOfRow:(NSInteger)numberOfRow itemHeight:(CGFloat)itemHeight padding:(CGFloat)padding{

//    CGFloat padding = 10;
//    CGFloat viewHeight = 30;
//    NSInteger numberOfRow = 4;
    NSInteger rowCount = items.count % numberOfRow == 0 ? items.count/numberOfRow : items.count/numberOfRow + 1;
    CGFloat itemWidth = (width - (numberOfRow-1)*padding)/numberOfRow;
    itemHeight = itemHeight == 0.0 ? itemWidth : itemHeight;;
    //
    CGSize size = CGSizeMake(width, rowCount * itemHeight + (rowCount - 1) * padding);
    return size;
}

///布尔值转字符串
- (NSString *)stringFromBool:(NSNumber *)boolNum {
    NSParameterAssert([boolNum boolValue] || [boolNum boolValue] == NO);
    NSString *string = [boolNum boolValue] ? @"1" : @"0";
    return string;
}

///字符串转布尔值
- (BOOL)stringToBool:(NSString *)string{
    NSAssert(([@[@"1",@"0"] containsObject:string] ), @"string值只能为1或者0");
    BOOL boolValue = [string integerValue] >= 1 ? YES : NO;
    return boolValue;
}

#pragma mark - -获取随机数，范围在[from,to]，包括from，包括to
- (NSInteger)getRandomNum:(NSInteger)from to:(NSInteger)to{
    return (NSInteger)(from + (arc4random() % (to - from + 1)));
}

- (NSString *)getRandomStr:(NSInteger)from to:(NSInteger)to{
    NSInteger random = [self getRandomNum:from to:to];
    return [@(random) stringValue];
}

@end
