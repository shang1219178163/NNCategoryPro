//
//  NSObject+ModelHelper.m
//  HuiZhuBang
//
//  Created by BIN on 2017/11/28.
//  Copyright © 2017年 WeiHouKeJi. All rights reserved.
//

#import "NSObject+ModelHelper.h"

#import <objc/runtime.h>
#import <pthread.h>

#import "NSNumber+Helper.h"
#import <MJExtension/MJExtension.h>


@implementation NSObject (ModelHelper)

-(void)BN_setValidValueFromModel:(id)model{
    //mj_keyValue获取的是已经赋值的部分,值为空的不包含
    NSDictionary * dic = ((NSObject *)self).mj_keyValues;
    NSDictionary * dicModel = ((NSObject *)model).mj_keyValues;

    if ([self class] == [model class]) {
        [dicModel enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
//            DDLog(@"_%@_%@",key,obj);
            [self setValue:obj forKey:key];
            
        }];
    }
    else{
        [dicModel enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            if ([dic.allKeys containsObject:key]) {
                [self setValue:obj forKey:key];
                
            }
        }];
    }
}




#pragma make - -runtime
///通过运行时获取当前对象的所有属性的名称，以数组的形式返回
- (NSArray *)allPropertyNames{
    ///存储所有的属性名称
    NSMutableArray *allNames = [NSMutableArray arrayWithCapacity:0];
    
    ///存储属性的个数
    unsigned int propertyCount = 0;
    ///通过运行时获取当前类的属性
    objc_property_t *propertys = class_copyPropertyList([self class], &propertyCount);
    
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

- (char *)getPropertyRealType:(const char *)property_attr {
    char * type;
    
    char t = property_attr[1];
    
    if (strcmp(&t, @encode(char)) == 0) {
        type = "char";
    }
    else if (strcmp(&t, @encode(int)) == 0) {
        type = "int";
    }
    else if (strcmp(&t, @encode(unsigned int)) == 0) {
        type = "unsigned int";
    }
    else if (strcmp(&t, @encode(short)) == 0) {
        type = "short";
    }
    else if (strcmp(&t, @encode(unsigned short)) == 0) {
        type = "unsigned short";
    }
    else if (strcmp(&t, @encode(long)) == 0) {
        type = "long";
    }
    else if (strcmp(&t, @encode(long long)) == 0) {
        type = "long long";
    }
    else if (strcmp(&t, @encode(unsigned long)) == 0) {
        type = "unsigned long";
    }
    else if (strcmp(&t, @encode(unsigned long long)) == 0) {
        type = "unsigned long long";
    }
    else if (strcmp(&t, @encode(float)) == 0) {
        type = "float";
    }
    else if (strcmp(&t, @encode(double)) == 0) {
        type = "double";
    }
    else if (strcmp(&t, @encode(unsigned char)) == 0) {
        type = "unsigned char";
    }
    else if (strcmp(&t, @encode(_Bool)) == 0 || strcmp(&t, @encode(bool)) == 0) {
        type = "BOOL";
    }
    else if (strcmp(&t, @encode(void)) == 0) {
        type = "void";
    }
    else if (strcmp(&t, @encode(char *)) == 0) {
        type = "char *";
    }
    else if (strcmp(&t, @encode(id)) == 0) {
        type = "id";
    }
    else if (strcmp(&t, @encode(Class)) == 0) {
        type = "Class";
    }
    else if (strcmp(&t, @encode(SEL)) == 0) {
        type = "SEL";
    }
    else {
        type = "";
    }
    return type;
}

#pragma make - -Model

//-(NSString *)convertToStrFromDict:(NSDictionary *)dict key:(NSString *)key{
//    return [@([dict[key] doubleValue]) stringValue];
//
//}

//- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
//    
//    [self convertBaseTypesForYYModelDict:dic];
//    
//    return YES;
//}

-(id)convertFromDict:(NSDictionary *)dict key:(NSString *)key{
    
    id value = [dict valueForKey:key];
    if ([value isKindOfClass:[NSString class]]) {
        ////通过用匹配的UTF-8字符替换所有编码百分比的序列，从而返回接收器创建的新字符串。
        value = [value stringByRemovingPercentEncoding];
        return value;
    }
    
    if([value isKindOfClass:[NSNumber class]]){
        NSString * valueStr = [value stringValue];
        if (![valueStr containsString:@"."]) return valueStr;
        
    }
    
    if([value isKindOfClass:[NSNumber class]]){
        const char * pObjCType = [((NSNumber*)value) objCType];
        //int
        if (strcmp(pObjCType, @encode(int))  == 0) {
//            DDLog(@"字典中key=%@的值是int类型,值为%ld",key,[value integerValue]);
            return [@([value integerValue]) stringValue];
        }
        
        if (strcmp(pObjCType, @encode(unsigned int))  == 0) {
//            DDLog(@"字典中key=%@的值是int类型,值为%d",key,[value unsignedIntValue]);
            return [@([value unsignedIntValue]) stringValue];
        }
        
        //float
        if (strcmp(pObjCType, @encode(float)) == 0) {

            CGFloat valueFloat = [value floatValue];
            valueFloat = roundf(valueFloat *100)/100.0;
            
            NSString * valueFloatStr = [NSString stringWithFormat:@"%.2f",valueFloat];
//            DDLog(@"字典中key=%@的值是float类型,值为%f",key,valueFloat);
            return valueFloatStr;
            
        }
        //double
        if (strcmp(pObjCType, @encode(double))  == 0) {
            
            double valueDouble = [value doubleValue];
            valueDouble = round(valueDouble *100)/100.0;
            
            NSString * valueDoubleStr = [NSString stringWithFormat:@"%.2f",valueDouble];
//            DDLog(@"字典中key=%@的值是double类型,值为%f",key,valueDouble);
            return valueDoubleStr;
            
        }
        
        //long
        if (strcmp(pObjCType, @encode(long))  == 0) {
            
            long valueLong = [value longValue];
            valueLong = roundl(valueLong *100)/100.0;
            
            NSString * valueLongStr = [NSString stringWithFormat:@"%.2ld",valueLong];
//            DDLog(@"字典中key=%@的值是double类型,值为%ld",key,valueLong);
            return valueLongStr;
            
        }
        
        if (strcmp(pObjCType, @encode(long long))  == 0) {
            
            long long valueLongLong = [value longLongValue];
            valueLongLong = roundl(valueLongLong *100)/100.0;
            
            NSString * valueLongLonggStr = [NSString stringWithFormat:@"%.2lld",valueLongLong];
//            DDLog(@"字典中key=%@的值是double类型,值为%lld",key,valueLongLong);
            return valueLongLonggStr;
            
        }
        
        
        if (strcmp(pObjCType, @encode(unsigned long))  == 0) {
            
            unsigned long valueLongU = [value unsignedLongValue];
            valueLongU = roundl(valueLongU *100)/100.0;

            NSString * valueLongUStr = [NSString stringWithFormat:@"%.2lu",valueLongU];
//            DDLog(@"字典中key=%@的值是double类型,值为%ld",key,valueLongU);
            return valueLongUStr;
            
        }
        
        if (strcmp(pObjCType, @encode(unsigned long long))  == 0) {
            
            unsigned long long valueLongLongU = [value unsignedLongValue];
            valueLongLongU = roundl(valueLongLongU *100)/100.0;
            
            NSString * valueLongLongUStr = [NSString stringWithFormat:@"%.2lld",valueLongLongU];
//            DDLog(@"字典中key=%@的值是double类型,值为%llu",key,valueLongLongU);
            return valueLongLongUStr;
            
        }
        //bool
        if (strcmp(pObjCType, @encode(BOOL)) == 0) {
//            DDLog(@"字典中key=%@的值是bool类型,值为%i",key,[value boolValue]);
            return [@([value boolValue]) stringValue];
            
        }
    }
    return @"";
}

-(void)convertBaseTypesForYYModelDict:(NSDictionary *)dict mapperDict:(NSDictionary *)mapperDict{
    
    pthread_mutex_t mutex;
    pthread_mutex_init(&mutex,NULL);
    pthread_mutex_lock(&mutex);
    
    //do your stuff
    [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        key = [self mapKeyWithMapDict:mapperDict originKey:key];
        if ([obj isKindOfClass:[NSArray class]]) {
            return ;
        }
        else if ([obj isKindOfClass:[NSString class]]) {
            [self setValue:obj forKey:key];
            
        }
        else if ([obj isKindOfClass:[NSNumber class]]) {
            NSString *string = [(NSNumber *)obj BN_StringValue];
            [self setValue:string forKey:key];
            
        }
        else{
            NSString * string = [self convertFromDict:dict key:key];
            [self setValue:string forKey:key];
            
        }
    }];
    
    pthread_mutex_unlock(&mutex);
    pthread_mutex_destroy(&mutex);
    
}

/**
 通过映射字典查找对应的映射键
 */
- (NSString *)mapKeyWithMapDict:(NSDictionary *)dict originKey:(NSString *)originKey{
    if (!dict || dict.allKeys.count == 0) {
        return originKey;
    }
    
    __block NSString * result = originKey;
    [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[NSString class]] && [obj isEqualToString:originKey]) {
            result = key;
            *stop = YES;

        }
        else if ([obj isKindOfClass:[NSArray class]] && [(NSArray *)obj containsObject:originKey]) {
            result = key;
            *stop = YES;
            
        }
    }];
    return result;
    
}

-(void)convertBaseTypesForYYModelDict:(NSDictionary *)dict{
    
    pthread_mutex_t mutex;
    pthread_mutex_init(&mutex,NULL);
    pthread_mutex_lock(&mutex);
    //do your stuff
    [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[NSArray class]]) {
            return ;
        }
        else if ([obj isKindOfClass:[NSString class]]) {
            [self setValue:obj forKey:key];
            
        }
        else if ([obj isKindOfClass:[NSNumber class]]) {
            NSString *string = [(NSNumber *)obj BN_StringValue];
            [self setValue:string forKey:key];
            
        }
        else{
            NSString * string = [self convertFromDict:dict key:key];
            [self setValue:string forKey:key];
            
        }
    }];
    
    pthread_mutex_unlock(&mutex);
    pthread_mutex_destroy(&mutex);
    
}

//-(void)convertBaseTypesForYYModelDict:(NSDictionary *)dict{
//
//    pthread_mutex_t mutex;
//    pthread_mutex_init(&mutex,NULL);
//    pthread_mutex_lock(&mutex);
//    //do your stuff
//    [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
//        id value = [dict valueForKey:key];
//        if ([value isKindOfClass:[NSArray class]]) {
//            return ;
//        }
//        else if ([value isKindOfClass:[NSString class]]) {
//            [self setValue:value forKey:key];
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
//
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
    NSString * desc = @"\n";
    
    unsigned int outCount;
    //获取obj的属性数目
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    
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
