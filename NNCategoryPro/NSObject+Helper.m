//
//  NSObject+Helper.m
//  
//
//  Created by BIN on 2017/8/10.
//  Copyright © 2017年 SHANG. All rights reserved.
//

#import "NSObject+Helper.h"
#import <objc/runtime.h>

#import "NSString+Helper.h"
#import "NSDate+Helper.h"

#import "UIImage+Helper.h"
#import "NSBundle+Helper.h"
#import "UIColor+Helper.h"
#import "NSArray+Helper.h"
#import "NSAttributedString+Helper.h"

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

@implementation NSObject (Helper)

-(NSData *)jsonData{
    id obj = self;

    NSData *data = nil;
    if ([obj isKindOfClass: NSData.class]) {
        data = obj;
        
    } else if ([obj isKindOfClass: NSString.class]) {
        data = [obj dataUsingEncoding:NSUTF8StringEncoding];
        
    }
    else if ([obj isKindOfClass:[NSDictionary class]] || [obj isKindOfClass:[NSArray class]]){
        NSError * error = nil;
        data = [NSJSONSerialization dataWithJSONObject:obj options:kNilOptions error:&error];
        if (error) {
#ifdef DEBUG
            NSLog(@"fail to get NSData from obj: %@, error: %@", obj, error);
#endif
        }
    }
//    else if ([obj isKindOfClass: UIImage.class]){
//        data = UIImageJPEGRepresentation(obj, 1.0);
//        
//    }
    return data;
}

-(NSString *)jsonString{
    NSData *jsonData = self.jsonData;
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return jsonString;
}

- (id)objValue{
    assert([self isKindOfClass: NSString.class] || [self isKindOfClass:NSData.class] || [self isKindOfClass: NSDictionary.class] || [self isKindOfClass: NSArray.class]);
    if ([self isKindOfClass: NSDictionary.class] || [self isKindOfClass: NSArray.class]) {
        return self;
    }
    
    NSError *error = nil;
    if ([self isKindOfClass: NSString.class]) {
        NSData *data = [(NSString *)self dataUsingEncoding:NSUTF8StringEncoding];
        id obj = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        if (!error) {
            return obj;
        }
#ifdef DEBUG
        NSLog(@"fail to get dictioanry from JSON: %@, error: %@", data, error);
#endif
    } else if ([self isKindOfClass: NSData.class]) {
        id obj = [NSJSONSerialization JSONObjectWithData:(NSData *)self options:kNilOptions error:&error];
        if (!error) {
            return obj;
        }
#ifdef DEBUG
        NSLog(@"fail to get dictioanry from JSON: %@, error: %@", obj, error);
#endif
    }
    return nil;
}

- (NSDictionary *)dictValue{
    if ([self.objValue isKindOfClass: NSDictionary.class]) {
        return self.objValue;
    }
    return nil;
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
        // 归档, 就是把对象 key-value 对一对一对的 encode
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
            // 反归档, 就是把 key-value 对一对一对 decode
            id value = [aDecoder decodeObjectForKey:ivarName];
            // 赋值
            [self setValue:value forKey:ivarName];
        }
        free(ivars);
    }
    return self;
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

- (void)setNilValueForKey:(NSString *)key{
    NSLog(@"Invoke setNilValueForKey:, 不能给非指针对象(如NSInteger)赋值 nil");
    return;//给一个非指针对象(如NSInteger)赋值 nil, 直接忽略
}


#pragma mark - -runtime
///通过运行时获取当前对象的所有属性的名称，以数组的形式返回
- (NSArray *)allPropertyNames:(NSString *)clsName{
    ///存储所有的属性名称
    NSMutableArray *allNames = [NSMutableArray arrayWithCapacity:0];
    
    ///存储属性的个数
    unsigned int propertyCount = 0;
    ///通过运行时获取当前类的属性
    objc_property_t *propertys = class_copyPropertyList([NSClassFromString(clsName) class], &propertyCount);
    
    //把属性放到数组中
    for (int i = 0; i < propertyCount; i ++) {
        ///取出第一个属性
        objc_property_t property = propertys[i];
        
        const char * propertyName = property_getName(property);
        [allNames addObject:[NSString stringWithUTF8String:propertyName]];
    }
    ///释放
    free(propertys);
    return allNames;
}

/**
 模型转字典
 */
- (NSDictionary *)modelToDictionary{
    assert([self isKindOfClass:NSObject.class]);
    id obj = self;
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    unsigned int count;
    
    objc_property_t *props = class_copyPropertyList([obj class], &count);//获得属性列表
    for(NSInteger i = 0;i < count; i++){
        
        objc_property_t prop = props[i];
        NSString *propName = [NSString stringWithUTF8String:property_getName(prop)];//获得属性的名称
        
        id value = [obj valueForKey:propName];//kvc读值
        
//        value = value == nil ? [NSNull null] : [self handleObj:obj];
        value = !value ? [NSNull null] : [self handleObj:obj];
        [dic setObject:value forKey:propName];
    }
    free(props);
    return dic;
}

/**
 模型转JSON
 
 */
- (NSString *)modelToJSONWithError:(NSError **)error{
    id obj = self;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:[self handleObj:obj] options:NSJSONWritingPrettyPrinted error:error];
    NSString *jsonText = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    return jsonText;
}

/**
 自定义处理数组，字典，其他类
 
 */
- (id)handleObj:(id)obj{
    //类型
    if([obj isKindOfClass:[NSString class]] || [obj isKindOfClass:[NSNumber class]] || [obj isKindOfClass:[NSNull class]]){
        return obj;
    }
    
    if([obj isKindOfClass:[NSArray class]]) {
        
        NSArray *objArr = obj;
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:objArr.count];
        for(NSInteger i = 0;i < objArr.count; i++){
            //            [arr setObject:[self handleObj:objArr[i]] atIndexedSubscript:i];
            [arr addObject:[self handleObj:objArr[i]]];
        }
        return arr;
    }
    
    if([obj isKindOfClass:[NSDictionary class]]){
        
        NSDictionary *objDic = obj;
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:[objDic count]];
        for(NSString *key in objDic.allKeys){
            [dic setObject:[self handleObj:objDic[key]] forKey:key];
            
        }
        return dic;
    }
    return [self modelToDictionary];
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

-(NSString *)showNilText{
    NSParameterAssert([self isKindOfClass:[NSString class]]);
    return [self validObject]  ? (NSString *)self : @"--";
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

/**
 布尔值转字符串

 */
- (NSString *)stringFromBool:(NSNumber *)boolNum {
    NSParameterAssert([boolNum boolValue]  || [boolNum boolValue] == NO);
    
    NSString *string = [boolNum boolValue]  ? @"1"  :   @"0";
    return string;
}

/**
 字符串转布尔值

 */
- (BOOL)stringToBool:(NSString *)string{
    NSAssert(([@[@"1",@"0"] containsObject:string] ), @"string值只能为1或者0");

    BOOL boolValue = [string integerValue] == 1 ? YES : NO;
    return boolValue;
}

+ (NSString *)getMaxLengthStrFromArr:(NSArray *)arr{
    NSString *temp = [arr firstObject];
    for (NSString * obj in arr){
        if (obj.length > temp.length){
            temp = obj;
        }
    }
    return temp;
}


#pragma mark - -获取随机数，范围在[from,to]，包括from，包括to
- (NSInteger)getRandomNum:(NSInteger)from to:(NSInteger)to{
    return (NSInteger)(from + (arc4random() % (to - from + 1)));
}

- (NSString *)getRandomStr:(NSInteger)from to:(NSInteger)to{
    NSInteger random = [self getRandomNum:from to:to];
    return [@(random) stringValue];
}

- (NSInteger)rowCountWithItemList:(NSArray *)itemList rowOfNumber:(NSInteger)rowOfNumber{
    
    NSInteger rowCount = itemList.count % rowOfNumber == 0 ? itemList.count/rowOfNumber : (itemList.count/rowOfNumber + 1);
    return rowCount;
}


@end
