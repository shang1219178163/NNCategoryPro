//
//  NSObject+Helper.h
//  
//
//  Created by BIN on 2017/8/10.
//  Copyright © 2017年 SHANG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <objc/runtime.h>

#import "UIScreen+Helper.h"
#import "UIColor+Helper.h"

NS_ASSUME_NONNULL_BEGIN

/// 获取swift类文件名称
FOUNDATION_EXPORT NSString *NNSwiftClassName(NSString *name);
/// 地址字符串(hostname + port)
FOUNDATION_EXPORT NSString *UrlAddress(NSString *hostname, NSString *port);

/// 关联对象的唯一无符号常量值
FOUNDATION_EXPORT NSString *RuntimeKeyFromParams(NSObject *obj, NSString *funcAbount);

/// 由角度转换弧度
FOUNDATION_EXPORT CGFloat CGRadianFromDegrees(CGFloat x);
/// 弧度转换角度
FOUNDATION_EXPORT CGFloat CGDegreesFromRadian(CGFloat x);
/// 获取随机数
FOUNDATION_EXPORT NSInteger RandomInteger(NSInteger from, NSInteger to);
/// 四舍五入
FOUNDATION_EXPORT CGFloat RoundFloat(CGFloat value, NSInteger num);


#pragma mark --dispatch
void asyncUI(id(^globle)(void), void(^main)(id));

/// dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block);
void dispatch_global_async(void(^block)(void));
/// dispatch_async(dispatch_get_main_queue(), block);
void dispatch_main_async(void(^block)(void));
/// dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(second * NSEC_PER_SEC)), dispatch_get_global_queue(0, 0), block);
void dispatch_global_after(double second, void(^block)(void));
/// dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(second * NSEC_PER_SEC)), dispatch_get_main_queue(), block);
void dispatch_main_after(double second, void(^block)(void));
/// dispatch_apply(count, dispatch_get_global_queue(0, 0), block);
void dispatch_global_apply(NSUInteger count, void(^block)(size_t index));
/// dispatch_apply(count, dispatch_get_main_queue(), block);
void dispatch_main_apply(NSUInteger count, void(^block)(size_t index));


@interface NSObject (Helper)<NSCoding>

///遍历成员变量列表
- (void)enumerateIvars:(void(^)(Ivar v, NSString *name, _Nullable id value))block;
///遍历属性列表
- (void)enumeratePropertys:(void(^)(objc_property_t property, NSString *name, _Nullable id value))block;
///遍历方法列表
- (void)enumerateMethods:(void(^)(Method method, NSString *name))block;
///遍历遵循的协议列表
- (void)enumerateProtocols:(void(^)(Protocol *proto, NSString *name))block;

///详情模型转字典
- (NSDictionary *)toDictionary;

///(通用)富文本只有和一般文字同字体大小才能计算高度
- (CGSize)sizeWithText:(id)text font:(UIFont *)font width:(CGFloat)width;

@end


//弃用
@interface NSObject (ModelHelper)

//-(id)convertFromDict:(NSDictionary *)dict key:(NSString *)key;
//
//-(void)convertBaseTypesForYYModelDict:(NSDictionary *)dict;
//-(void)convertBaseTypesForYYModelDict:(NSDictionary *)dict mapperDict:(NSDictionary *)mapperDict;

@end



@interface NSJSONSerialization (Helper)

+ (nullable id)ObjForResource:(nullable NSString *)name ofType:(nullable NSString *)ext;
    
    
@end


NS_ASSUME_NONNULL_END
