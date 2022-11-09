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
    NSDictionary *infoDict = NSBundle.mainBundle.infoDictionary;
//    NSString *bundleName = NSBundle.mainBundle.infoDictionary[@"CFBundleExecutable"];
    NSString *bundleName = infoDict[(NSString *)kCFBundleExecutableKey] ? : infoDict[(NSString *)kCFBundleNameKey];
    NSString *result = [bundleName stringByAppendingFormat:@".%@", name];
    return result;
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
/**
 关联对象的唯一无符号常量值

 @param obj 对象本身
 @param funcAbount 方法名及实参生成的字符串
 @return 根据对象+方法+实参生成的唯一常量值(确保每个对象调用同一方法不同参数的时候,返回的值都是唯一的)
 */
NSString *RuntimeKeyFromParams(NSObject *obj, NSString *funcAbount){
    NSString *unique = [[@(obj.hash) stringValue] stringByAppendingFormat:@",%@",funcAbount];
    return unique;
}


CGFloat CGRadianFromDegrees(CGFloat x){
    return (M_PI * (x) / 180.0);
}

CGFloat CGDegreesFromRadian(CGFloat x){
    return (x * 180.0)/(M_PI);
}

NSInteger RandomInteger(NSInteger from, NSInteger to){
    return (NSInteger)(from + (arc4random() % (to - from + 1)));
}

CGFloat RoundFloat(CGFloat value, NSInteger num){
    NSInteger tem = pow(10, num);
    CGFloat x = value*tem + 0.5;
    CGFloat figure = (floorf(x))/tem;
    return figure;
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


#pragma mark --dispatch

void asyncUI(id(^globle)(void), void(^main)(id)){
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        id value = globle();
        dispatch_async(dispatch_get_main_queue(), ^{
            main(value);
        });
    });
}

void dispatch_global_async(void(^block)(void)){
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block);
}

void dispatch_main_async(void(^block)(void)){
    if (NSThread.isMainThread) {
        block();
    }
    else{
        dispatch_async(dispatch_get_main_queue(), block);
    }
}

void dispatch_global_after(double second, void(^block)(void)){
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(second * NSEC_PER_SEC)), dispatch_get_global_queue(0, 0), block);
}

void dispatch_main_after(double second, void(^block)(void)){
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(second * NSEC_PER_SEC)), dispatch_get_main_queue(), block);
}

void dispatch_global_apply(NSUInteger count, void(^block)(size_t index)){
    dispatch_apply(count, dispatch_get_global_queue(0, 0), block);
}

void dispatch_main_apply(NSUInteger count, void(^block)(size_t index)){
    dispatch_apply(count, dispatch_get_main_queue(), block);
}

#pragma mark --funtions


/**
 富文本只有和一般文字同字体大小才能计算高度
 */
- (CGSize)sizeWithText:(id)text font:(UIFont *)font width:(CGFloat)width{
    if (!text) return CGSizeZero;

    NSAssert([text isKindOfClass:[NSString class]] || [text isKindOfClass:[NSAttributedString class]], @"请检查text格式!");
    
    CGSize size = CGSizeZero;
    if ([text isKindOfClass:[NSString class]]) {
        NSDictionary *attrDict = [NSAttributedString paraDictWithFont:font
                                                            textColor:UIColor.blackColor
                                                            alignment:NSTextAlignmentLeft];
        size = [text boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                                  options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
                               attributes:attrDict
                                  context:nil].size;
    } else {
        size = [text boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                                  options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
                                  context:nil].size;
    }
    size.width = ceil(size.width);
    size.height = ceil(size.height);
    return size;
}


/// iOS 类方法/实例方法映射(方法格式: * (void)*MethodName*:(id)params callback:(FlutterResult)callback;)
/// @param method //获取函数名
/// @param arguments //获取参数列表
/// @param block 回调参数(例如 result:(FlutterResult)result)
- (BOOL)reflectMethod:(NSString *)method arguments:(id)arguments block:(void (^)(id _Nullable result))block {
    
    NSAssert(method && method != @"", @"方法名不能为空!");
    SEL selector = NSSelectorFromString([NSString stringWithFormat:@"%@:callback:", method]);
    
    if ([self.class respondsToSelector:selector]) {
        NSMethodSignature *methodSignature = [self.class methodSignatureForSelector:selector]; // Signature

        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSignature];
        invocation.target = self.class;// target
        
        invocation.selector = selector;
        //注意：设置参数的索引时不能从0开始，因为0已经被self占用，1已经被_cmd占用
        [invocation setArgument:&arguments atIndex:2];
        [invocation setArgument:&block atIndex:3];
        [invocation invoke];
        return true;
    }
    
    if ([self respondsToSelector:selector]) {
        NSMethodSignature *methodSignature = [self.class instanceMethodSignatureForSelector:selector]; // Signature
    
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSignature];
        invocation.target = self;// target
        
        invocation.selector = selector;
        //注意：设置参数的索引时不能从0开始，因为0已经被self占用，1已经被_cmd占用
        [invocation setArgument:&arguments atIndex:2];
        [invocation setArgument:&block atIndex:3];
        [invocation invoke];
        return true;
    }

    NSLog(@"method: %@, arguments: %@", method, arguments);
//    block(FlutterMethodNotImplemented);
    return false;
}


@end


@implementation NSObject (ModelHelper)

///通过运行时获取当前对象的所有属性的名称，以数组的形式返回
//- (NSArray *)allPropertyNames{
//    ///存储所有的属性名称
//    NSMutableArray *allNames = [NSMutableArray arrayWithCapacity:0];
//
//    ///存储属性的个数
//    unsigned int propertyCount = 0;
//    ///通过运行时获取当前类的属性
//    objc_property_t *propertys = class_copyPropertyList(self.class, &propertyCount);
//
//    //把属性放到数组中
//    for (int i = 0; i < propertyCount; i ++) {
//        ///取出第一个属性
//        objc_property_t property = propertys[i];
//
//        const char * propertyName = property_getName(property);
//        [allNames addObject:[NSString stringWithUTF8String:propertyName]];
//    }
//
//    ///释放
//    free(propertys);
//
//    return allNames;
//}
//
//- (char *)getPropertyRealType:(const char *)property_attr{
//    char *type;
//
//    char t = property_attr[1];
//
//    if (strcmp(&t, @encode(char)) == 0) {
//        type = "char";
//    }
//    else if (strcmp(&t, @encode(int)) == 0) {
//        type = "int";
//    }
//    else if (strcmp(&t, @encode(unsigned int)) == 0) {
//        type = "unsigned int";
//    }
//    else if (strcmp(&t, @encode(short)) == 0) {
//        type = "short";
//    }
//    else if (strcmp(&t, @encode(unsigned short)) == 0) {
//        type = "unsigned short";
//    }
//    else if (strcmp(&t, @encode(long)) == 0) {
//        type = "long";
//    }
//    else if (strcmp(&t, @encode(long long)) == 0) {
//        type = "long long";
//    }
//    else if (strcmp(&t, @encode(unsigned long)) == 0) {
//        type = "unsigned long";
//    }
//    else if (strcmp(&t, @encode(unsigned long long)) == 0) {
//        type = "unsigned long long";
//    }
//    else if (strcmp(&t, @encode(float)) == 0) {
//        type = "float";
//    }
//    else if (strcmp(&t, @encode(double)) == 0) {
//        type = "double";
//    }
//    else if (strcmp(&t, @encode(unsigned char)) == 0) {
//        type = "unsigned char";
//    }
//    else if (strcmp(&t, @encode(_Bool)) == 0 || strcmp(&t, @encode(bool)) == 0) {
//        type = "BOOL";
//    }
//    else if (strcmp(&t, @encode(void)) == 0) {
//        type = "void";
//    }
//    else if (strcmp(&t, @encode(char *)) == 0) {
//        type = "char *";
//    }
//    else if (strcmp(&t, @encode(id)) == 0) {
//        type = "id";
//    }
//    else if (strcmp(&t, @encode(Class)) == 0) {
//        type = "Class";
//    }
//    else if (strcmp(&t, @encode(SEL)) == 0) {
//        type = "SEL";
//    }
//    else {
//        type = "";
//    }
//    return type;
//}
//
//#pragma make -Model
//
//-(id)convertFromDict:(NSDictionary *)dict key:(NSString *)key{
//
//    id value = [dict valueForKey:key];
//    if ([value isKindOfClass:[NSString class]]) {
//        ////通过用匹配的UTF-8字符替换所有编码百分比的序列，从而返回接收器创建的新字符串。
//        value = [value stringByRemovingPercentEncoding];
//        return value;
//    }
//
//    if([value isKindOfClass:[NSNumber class]]){
//        NSString * valueStr = [value stringValue];
//        if (![valueStr containsString:@"."]) return valueStr;
//
//    }
//
//    if([value isKindOfClass:[NSNumber class]]){
//        const char * pObjCType = [((NSNumber*)value) objCType];
//        //int
//        if (strcmp(pObjCType, @encode(int))  == 0) {
////            DDLog(@"字典中key=%@的值是int类型,值为%ld",key,[value integerValue]);
//            return [@([value integerValue]) stringValue];
//        }
//
//        if (strcmp(pObjCType, @encode(unsigned int))  == 0) {
////            DDLog(@"字典中key=%@的值是int类型,值为%d",key,[value unsignedIntValue]);
//            return [@([value unsignedIntValue]) stringValue];
//        }
//
//        //float
//        if (strcmp(pObjCType, @encode(float)) == 0) {
//
//            CGFloat valueFloat = [value floatValue];
//            valueFloat = roundf(valueFloat *100)/100.0;
//
//            NSString * valueFloatStr = [NSString stringWithFormat:@"%.2f",valueFloat];
////            DDLog(@"字典中key=%@的值是float类型,值为%f",key,valueFloat);
//            return valueFloatStr;
//
//        }
//        //double
//        if (strcmp(pObjCType, @encode(double))  == 0) {
//
//            double valueDouble = [value doubleValue];
//            valueDouble = round(valueDouble *100)/100.0;
//
//            NSString * valueDoubleStr = [NSString stringWithFormat:@"%.2f",valueDouble];
////            DDLog(@"字典中key=%@的值是double类型,值为%f",key,valueDouble);
//            return valueDoubleStr;
//
//        }
//
//        //long
//        if (strcmp(pObjCType, @encode(long))  == 0) {
//
//            long valueLong = [value longValue];
//            valueLong = roundl(valueLong *100)/100.0;
//
//            NSString * valueLongStr = [NSString stringWithFormat:@"%.2ld",valueLong];
////            DDLog(@"字典中key=%@的值是double类型,值为%ld",key,valueLong);
//            return valueLongStr;
//
//        }
//
//        if (strcmp(pObjCType, @encode(long long))  == 0) {
//
//            long long valueLongLong = [value longLongValue];
//            valueLongLong = roundl(valueLongLong *100)/100.0;
//
//            NSString * valueLongLonggStr = [NSString stringWithFormat:@"%.2lld",valueLongLong];
////            DDLog(@"字典中key=%@的值是double类型,值为%lld",key,valueLongLong);
//            return valueLongLonggStr;
//
//        }
//
//
//        if (strcmp(pObjCType, @encode(unsigned long))  == 0) {
//
//            unsigned long valueLongU = [value unsignedLongValue];
//            valueLongU = roundl(valueLongU *100)/100.0;
//
//            NSString * valueLongUStr = [NSString stringWithFormat:@"%.2lu",valueLongU];
////            DDLog(@"字典中key=%@的值是double类型,值为%ld",key,valueLongU);
//            return valueLongUStr;
//
//        }
//
//        if (strcmp(pObjCType, @encode(unsigned long long))  == 0) {
//
//            unsigned long long valueLongLongU = [value unsignedLongValue];
//            valueLongLongU = roundl(valueLongLongU *100)/100.0;
//
//            NSString * valueLongLongUStr = [NSString stringWithFormat:@"%.2lld",valueLongLongU];
////            DDLog(@"字典中key=%@的值是double类型,值为%llu",key,valueLongLongU);
//            return valueLongLongUStr;
//
//        }
//        //bool
//        if (strcmp(pObjCType, @encode(BOOL)) == 0) {
////            DDLog(@"字典中key=%@的值是bool类型,值为%i",key,[value boolValue]);
//            return [@([value boolValue]) stringValue];
//
//        }
//    }
//    return @"";
//}
//
//-(void)convertBaseTypesForYYModelDict:(NSDictionary *)dict mapperDict:(NSDictionary *)mapperDict{
//
//    pthread_mutex_t mutex;
//    pthread_mutex_init(&mutex,NULL);
//    pthread_mutex_lock(&mutex);
//
//    //do your stuff
//    [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
//        key = [self mapKeyWithMapDict:mapperDict originKey:key];
//        if ([obj isKindOfClass:[NSArray class]]) {
//            return ;
//        }
//        else if ([obj isKindOfClass:[NSString class]]) {
//            [self setValue:obj forKey:key];
//
//        }
//        else if ([obj isKindOfClass:[NSNumber class]]) {
//            NSString *string = [(NSNumber *)obj stringValue];
//            [self setValue:string forKey:key];
//
//        }
//        else{
//            NSString * string = [self convertFromDict:dict key:key];
//            [self setValue:string forKey:key];
//
//        }
//    }];
//
//    pthread_mutex_unlock(&mutex);
//    pthread_mutex_destroy(&mutex);
//}
//
///**
// 通过映射字典查找对应的映射键
// */
//- (NSString *)mapKeyWithMapDict:(NSDictionary *)dict originKey:(NSString *)originKey{
//    if (!dict || dict.allKeys.count == 0) {
//        return originKey;
//    }
//
//    __block NSString * result = originKey;
//    [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
//        if ([obj isKindOfClass:[NSString class]] && [obj isEqualToString:originKey]) {
//            result = key;
//            *stop = YES;
//
//        }
//        else if ([obj isKindOfClass:[NSArray class]] && [(NSArray *)obj containsObject:originKey]) {
//            result = key;
//            *stop = YES;
//
//        }
//    }];
//    return result;
//}
//
//-(void)convertBaseTypesForYYModelDict:(NSDictionary *)dict{
//
//    pthread_mutex_t mutex;
//    pthread_mutex_init(&mutex,NULL);
//    pthread_mutex_lock(&mutex);
//    //do your stuff
//    [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
//        if ([obj isKindOfClass:[NSArray class]]) {
//            return ;
//        }
//        else if ([obj isKindOfClass:[NSString class]]) {
//            [self setValue:obj forKey:key];
//
//        }
//        else if ([obj isKindOfClass:[NSNumber class]]) {
//            NSString *string = [(NSNumber *)obj stringValue];
//            [self setValue:string forKey:key];
//
//        }
//        else{
//            NSString * string = [self convertFromDict:dict key:key];
//            [self setValue:string forKey:key];
//
//        }
//    }];
//
//    pthread_mutex_unlock(&mutex);
//    pthread_mutex_destroy(&mutex);
//}

/**
 * @property (readonly, copy) NSString *description;
 * description是NSObject的一个只读属性，对于一般的属性都会有getter和setter方法，但是readonly的属性顾名思义就只有getter方法啦。
 * 当你在XCode控制台使用po命令打印一个对象的时候，如果没有重写description方法，往往打印出的结果就是“类名＋内存地址”，当然，我们只对继承自NSObject的非responder类对象感兴趣
 * 细心的你会发现UIResponder也是继承自NSObject
 * 这就是为什么UIViewController、UIView等控件们也有description方法了
 * description 描述的意思，顾名思义就是说一个对象有什么属性，每个属性对应的属性值是什么
 * 关于怎样重写description方法，不管是听说还是看博客，相信你一定有自己的想法了。关于如何写一个拷贝到哪里都能用的通用description方法，请先拷贝以下代码到你的类中，测试一下，看看有没有感觉很爽
 * 在拷贝代码之后如果你看到了红色的报错，说明你忘记import "objc/runtime.h"啦，至于runtime是什么鬼东西，网上有很多博客，我知道自己写不好关于这鬼的博客，在这里也就不妖言惑众了。
 */
- (NSString *)description{
    //当然，如果你有兴趣知道出类名字和对象的内存地址，也可以像下面这样调用super的description方法
    //    NSString * desc = [super description];
    NSString *desc = @"\n";
    
    unsigned int outCount;
    //获取obj的属性数目
    objc_property_t *properties = class_copyPropertyList(self.class, &outCount);
    
    for (int i = 0; i < outCount; i ++) {
        objc_property_t property = properties[i];
        //获取property的C字符串
        const char * propName = property_getName(property);
        if (propName) {
            //获取NSString类型的property名字
            NSString * prop = [NSString stringWithCString:propName encoding:[NSString defaultCStringEncoding]];
            
            if (![NSClassFromString(prop) isKindOfClass:[NSObject class]]) {
                continue;
            }
            
            //获取property对应的值
            id obj = [self valueForKey:prop];
            //将属性名和属性值拼接起来
            desc = [desc stringByAppendingFormat:@"%@ : %@;\n",prop,obj];
        }
    }
    
    free(properties);
    return desc;
}


@end


@implementation NSJSONSerialization (Helper)

+ (nullable id)ObjForResource:(nullable NSString *)name ofType:(nullable NSString *)ext{
    if (!name) {
        return nil;
    }
    
    NSString *path = [NSBundle.mainBundle pathForResource:name ofType:ext];
    if (!path) {
        return nil;
    }
    NSData *data = [[NSData alloc]initWithContentsOfFile:path];
    if (!data) {
        return nil;
    }

    NSError *error;
    id obj = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    if (error) {
        return nil;
    }
    return obj;
}


@end
