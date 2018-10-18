//
//  NSObject+Helper.h
//  HuiZhuBang
//
//  Created by BIN on 2017/8/10.
//  Copyright © 2017年 WeiHouKeJi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "NSObject+Date.h"
#import "UIScreen+Helper.h"
#import "UIColor+Helper.h"

UIKIT_EXTERN NSString * NSStringFromIndexPath(NSIndexPath *indexPath);
UIKIT_EXTERN NSString * NSStringFromLet(id obj);

UIKIT_EXTERN NSString * NSStringFromInt(NSInteger obj);
UIKIT_EXTERN NSString * NSStringFromFloat(CGFloat obj);

UIKIT_EXTERN UIImage * UIImageFromColor(UIColor * color);

UIKIT_EXTERN UIColor * UIColorFromRGBA(CGFloat r,CGFloat g,CGFloat b,CGFloat a);
UIKIT_EXTERN UIColor * UIColorFromRGB(CGFloat r,CGFloat g,CGFloat b);
UIKIT_EXTERN UIColor * UIColorDim(CGFloat White,CGFloat a);

UIKIT_EXTERN UIColor * UIColorFromRGB_Init(CGFloat r,CGFloat g,CGFloat b,CGFloat a);
UIKIT_EXTERN UIColor * UIColorFromHex(NSInteger hexValue);

UIKIT_EXTERN BOOL iOSVersion(CGFloat version);

UIKIT_EXTERN CGFloat BN_RadianFromDegrees(CGFloat x);//由角度转换弧度
UIKIT_EXTERN CGFloat BN_DegreesFromRadian(CGFloat x);//弧度转换角度

UIKIT_EXTERN CGFloat roundFloat(CGFloat value,NSInteger num);


@interface NSObject (Helper)

void BN_dispatchAsyncMain(void(^block)(void));
void BN_dispatchAsyncGlobal(void(^block)(void));
//void dispatchAfterDelay(void(^block)(void));
void BN_dispatchAfterDelay(double delay ,void(^block)(void));

void BN_dispatchApply(id obj ,void(^block)(dispatch_queue_t queue, size_t index));

/**
 代码块返回单个参数的时候,不适用于id不能代表的类型()
*/
//@property (nonatomic, copy) BlockObject blockObject;//其他类使用该属性注意性能
@property (nonatomic, copy) void(^blockObject)(id obj, id item, NSInteger idx);//其他类使用该属性注意性能

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

- (NSString *)JSONValue;

/**
 富文本特殊部分设置
 */
- (NSDictionary *)attrDictWithFont:(id)font textColor:(UIColor *)textColor;

/**
 富文本整体设置
 */
- (NSDictionary *)attrParaDictWithFont:(id)font textColor:(UIColor *)textColor alignment:(NSTextAlignment)alignment;

/**
 (通用)富文本只有和一般文字同字体大小才能计算高度
 */
- (CGSize)sizeWithText:(id)text font:(id)font width:(CGFloat)width;


/**
 (通用)密集view父视图尺寸
 */
- (CGSize)sizeItemsViewWidth:(CGFloat)width items:(NSArray *)items numberOfRow:(NSInteger)numberOfRow itemHeight:(CGFloat)itemHeight padding:(CGFloat)padding;

/**
 (详细)富文本产生
 
 @param text 源字符串
 @param textTaps 特殊部分数组(每一部分都必须包含在text中)
 @param font 一般字体大小(传NSNumber或者UIFont)
 @param tapFont 特殊部分子体大小(传NSNumber或者UIFont)
 @param tapColor 特殊部分颜色
 @return 富文本字符串
 */
- (NSAttributedString *)getAttString:(NSString *)text textTaps:(NSArray *)textTaps font:(id)font tapFont:(id)tapFont tapColor:(UIColor *)tapColor alignment:(NSTextAlignment)alignment;

- (NSAttributedString *)getAttString:(NSString *)text textTaps:(NSArray *)textTaps font:(id)font tapFont:(id)tapFont color:(UIColor *)color tapColor:(UIColor *)tapColor alignment:(NSTextAlignment)alignment;

- (NSMutableAttributedString *)getAttString:(NSString *)string textTaps:(id)textTaps tapColor:(UIColor *)tapColor;

/**
 富文本产生
 */
- (NSMutableAttributedString *)getAttString:(NSString *)string textTaps:(NSArray *)textTaps;


- (NSArray *)getAttListByPrefix:(NSString *)prefix titleList:(NSArray *)titleList mustList:(NSArray *)mustList;

- (NSAttributedString *)getAttringByPrefix:(NSString *)prefix content:(NSString *)content isMust:(BOOL)isMust;

- (NSAttributedString *)getAttringByPrefix:(NSString *)prefix content:(NSString *)content must:(id)must;

- (NSString *)stringFromBool:(NSNumber *)boolNum;

- (BOOL)stringToBool:(NSString *)string;

- (BOOL)isKindOfClassList:(NSArray *)clzList;


+ (NSString *)getMaxLengthStrFromArr:(NSArray *)arr;

//获取随机数
- (NSInteger)getRandomNum:(NSInteger)from to:(NSInteger)to;

- (NSString *)getRandomStr:(NSInteger)from to:(NSInteger)to;

- (NSInteger)rowCountWithItemList:(NSArray *)itemList rowOfNumber:(NSInteger)rowOfNumber;

@end
