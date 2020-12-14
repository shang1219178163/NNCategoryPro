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

/// 获取swift类文件名称
FOUNDATION_EXPORT NSString *NNSwiftClassName(NSString *name);
/// 关联对象的唯一无符号常量值
FOUNDATION_EXPORT NSString *RuntimeKeyFromParams(NSObject *obj, NSString *funcAbount);
//// 系统版本判断
//FOUNDATION_EXPORT BOOL iOSVer(CGFloat version);
/// 由角度转换弧度
FOUNDATION_EXPORT CGFloat CGRadianFromDegrees(CGFloat x);
/// 弧度转换角度
FOUNDATION_EXPORT CGFloat CGDegreesFromRadian(CGFloat x);
/// 获取随机数
FOUNDATION_EXPORT NSInteger RandomInteger(NSInteger from, NSInteger to);

FOUNDATION_EXPORT NSInteger StringFromBool(BOOL value);

FOUNDATION_EXPORT BOOL BoolFromString(NSString *value);
    
/// 四舍五入
FOUNDATION_EXPORT CGFloat RoundFloat(CGFloat value, NSInteger num);
/// swift类需要加命名空间
FOUNDATION_EXPORT NSString *SwiftClassName(NSString *className);
/// 地址字符串(hostname + port)
FOUNDATION_EXPORT NSString *UrlAddress(NSString *hostname, NSString *port);

NS_ASSUME_NONNULL_BEGIN

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

#pragma mark - -dispatchAsync
void GCDBlock(void(^block)(void));
void GCDMainBlock(void(^block)(void));
void GCDAfterMain(double delay ,void(^block)(void));
void GCDApplyGlobal(id obj ,void(^block)(size_t index));

@property(class, nonatomic, strong, readonly) NSString *identify;
@property(nonatomic, copy, nonnull) NSString *runtimeKey;

///(通用)富文本只有和一般文字同字体大小才能计算高度
- (CGSize)sizeWithText:(id)text font:(id)font width:(CGFloat)width;

@end

NS_ASSUME_NONNULL_END
