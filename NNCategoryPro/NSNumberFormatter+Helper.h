//
//  NSNumberFormatter+Helper.h
//  Location
//
//  Created by BIN on 2017/12/21.
//  Copyright © 2017年 Shang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// 四舍五入
FOUNDATION_EXPORT NSString * const kNumIdentify ;// 默认(四舍五入)
/// 分隔符,
FOUNDATION_EXPORT NSString * const kNumIdentifyDecimal ;
/// 百分比
FOUNDATION_EXPORT NSString * const kNumIdentifyPercent ;
/// 货币$
FOUNDATION_EXPORT NSString * const kNumIdentifyCurrency ;
/// 科学计数法 1.234E8
FOUNDATION_EXPORT NSString * const kNumIdentifyScientific ;
/// 加号符号
FOUNDATION_EXPORT NSString * const kNumIdentifyPlusSign ;
/// 减号符号
FOUNDATION_EXPORT NSString * const kNumIdentifyMinusSign ;
/// 指数符号
FOUNDATION_EXPORT NSString * const kNumIdentifyExponentSymbol ;
/// #,##0.00
FOUNDATION_EXPORT NSString * const kNumFormat;

@interface NSNumberFormatter (Helper)

@property (class, nonatomic, strong, readonly) NSDictionary *styleDic;

+ (NSNumberFormatter *)numberIdentify:(NSString *)identify;

/// [源]小数位数及四射五入处理
+ (NSString *)fractionDigits:(NSNumber *)obj
                         min:(NSUInteger)min
                         max:(NSUInteger)max
                roundingMode:(NSNumberFormatterRoundingMode)roundingMode;
/// [简]2位小数四射五入处理
+ (NSString *)fractionDigits:(NSNumber *)obj;

+ (NSNumberFormatter *)positiveFormat:(NSString *)formatStr;
///千分符
+ (NSNumberFormatter *)positive:(NSString *)formatStr
                         prefix:(NSString *)prefix
                         suffix:(NSString *)suffix
                        defalut:(NSString *)defalut;

/// number为NSNumber/String
+ (NSString *)localizedString:(NSNumberFormatterStyle)nstyle number:(NSString *)number;

@end

NS_ASSUME_NONNULL_END
