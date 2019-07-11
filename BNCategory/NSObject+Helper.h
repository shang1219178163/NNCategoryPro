//
//  NSObject+Helper.h
//  
//
//  Created by BIN on 2017/8/10.
//  Copyright © 2017年 SHANG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "UIScreen+Helper.h"
#import "UIColor+Helper.h"

/// 关联对象的唯一无符号常量值
FOUNDATION_EXPORT NSString *RuntimeKeyFromParams(NSObject *obj, NSString *funcAbount);
// 系统版本判断
FOUNDATION_EXPORT BOOL iOSVer(CGFloat version);
/// 由角度转换弧度
FOUNDATION_EXPORT CGFloat CGRadianFromDegrees(CGFloat x);
/// 弧度转换角度
FOUNDATION_EXPORT CGFloat CGDegreesFromRadian(CGFloat x);
/// 四舍五入
FOUNDATION_EXPORT CGFloat roundFloat(CGFloat value, NSInteger num);
/// swift类需要加命名空间
FOUNDATION_EXPORT NSString *SwiftClassName(NSString *className);
// NSObject -> NSData
FOUNDATION_EXPORT NSData *JSONDataFromObj(id obj);
/// NSObject -> NSString
FOUNDATION_EXPORT NSString *JSONStringFromObj(id obj);
/// NSString -> NSObject/NSDiction/NSArray
FOUNDATION_EXPORT id JSONObjectFromString(NSString *string);
/// NSData -> NSObject/NSDiction/NSArray
FOUNDATION_EXPORT id JSONObjectFromData(NSData *data);

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Helper)<NSCoding>

void dispatchAsyncMain(void(^block)(void));
void dispatchAsyncGlobal(void(^block)(void));
void dispatchAfterMain(double delay ,void(^block)(void));
void dispatchApplyGlobal(id obj ,void(^block)(size_t index));

/**
 代码块返回单个参数的时候,不适用于id不能代表的类型()
*/
//@property (nonatomic, copy) BlockObject blockObject;//其他类使用该属性注意性能
@property (nonatomic, copy) void(^blockObject)(id obj, id item, NSInteger idx);//其他类使用该属性注意性能
@property (nonatomic, copy) void (^block)(id sender);
@property (nonatomic, copy, nonnull) NSString *runtimeKey;
/// NSObject->NSData
@property (nonatomic, strong, readonly) NSData * _Nullable jsonData;
/// NSObject->NSString
@property (nonatomic, strong, readonly) NSString * _Nullable jsonString;
/// NSString/NSData->NSObject/NSDiction/NSArray
@property (nonatomic, strong, readonly) id _Nullable objValue;
/// NSString/NSData->NSDictionary
@property (nonatomic, strong, readonly) NSDictionary * _Nullable dictValue;

- (NSArray *)allPropertyNames:(NSString *)clsName;

/**
 模型转字典
 */
- (NSDictionary *)modelToDictionary;

/**
 模型转JSON
 */
- (NSString *)modelToJSONWithError:(NSError **)error;

-(BOOL)validObject;

-(NSString *)showNilText;

/**
 (通用)富文本只有和一般文字同字体大小才能计算高度
 */
- (CGSize)sizeWithText:(id)text font:(id)font width:(CGFloat)width;

/**
 (通用)密集view父视图尺寸
 */
- (CGSize)sizeItemsViewWidth:(CGFloat)width items:(NSArray *)items numberOfRow:(NSInteger)numberOfRow itemHeight:(CGFloat)itemHeight padding:(CGFloat)padding;

- (NSString *)stringFromBool:(NSNumber *)boolNum;

- (BOOL)stringToBool:(NSString *)string;

+ (NSString *)getMaxLengthStrFromArr:(NSArray *)arr;

//获取随机数
- (NSInteger)getRandomNum:(NSInteger)from to:(NSInteger)to;

- (NSString *)getRandomStr:(NSInteger)from to:(NSInteger)to;

- (NSInteger)rowCountWithItemList:(NSArray *)itemList rowOfNumber:(NSInteger)rowOfNumber;

@end

NS_ASSUME_NONNULL_END
