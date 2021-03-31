//
//  NSNumberFormatter+Helper.h
//  Location
//
//  Created by BIN on 2017/12/21.
//  Copyright © 2017年 Shang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
 
/// #,##0.00
FOUNDATION_EXPORT NSString * const kNumFormat;

@interface NSNumberFormatter (Helper)

@property(nonatomic, copy, readonly) NSNumberFormatter *(^digits)(NSUInteger minIntegerDigits, NSUInteger maxIntegerDigits, NSUInteger minFractionDigits, NSUInteger maxFractionDigits);

@property(nonatomic, copy, readonly) NSNumberFormatter *(^group)(NSString *groupingSeparator, NSUInteger groupingSize);

@property(nonatomic, copy, readonly) NSNumberFormatter *(^positivePrefix)(NSString *);

@property(nonatomic, copy, readonly) NSNumberFormatter *(^positiveSuffix)(NSString *);

@property(nonatomic, copy, readonly) NSNumberFormatter *(^negativePrefix)(NSString *);

@property(nonatomic, copy, readonly) NSNumberFormatter *(^negativeSuffix)(NSString *);

@property(nonatomic, copy, readonly) NSNumberFormatter *(^positiveFormat)(NSString *);

@property(nonatomic, copy, readonly) NSNumberFormatter *(^negativeFormat)(NSString *);

@property(nonatomic, copy, readonly) NSNumberFormatter *(^paddingCharacter)(NSString *);


/// 根据 NumberFormatter.Style 生成/获取 NumberFormatter, 避免多次创建(效果如下)
/// none_              0.6767 -> 1              123456789.6767 -> 123456790
/// decimal_           0.6767 -> 0.677          123456789.6767 -> 123,456,789.677
/// currency_          0.6767 -> ¥0.68          123456789.6767 -> ¥123,456,789.68
/// currencyISOCode_   0.6767 -> CNY 0.68       123456789.6767 -> CNY 123,456,789.68
/// currencyPlural_    0.6767 -> 0.68 人民币     123456789.6767 -> 123,456,789.68 人民币
/// currencyAccounting_0.6767 -> ¥0.68          123456789.6767 -> ¥123,456,789.68
/// percent_           0.6767 -> 68%            123456789.6767 -> 12,345,678,968%
/// scientific_        0.6767 -> 6.767E-1       123456789.6767 -> 1.234567896767E8
/// spellOut_          0.6767 -> 〇点六七六七     123456789.6767 -> 一亿二千三百四十五万六千七百八十九点六七六七
/// ordinal_           0.6767 -> 第1            123456789.6767 -> 第123,456,790
/// @param style NSNumberFormatterStyle
+ (NSNumberFormatter *)numberStyle:(NSNumberFormatterStyle)style;

+ (NSNumberFormatter *)format:(NSNumberFormatterStyle)style
            minFractionDigits:(NSUInteger)minFractionDigits
            maxFractionDigits:(NSUInteger)maxFractionDigits
               positivePrefix:(NSString *)positivePrefix
            groupingSeparator:(NSString *)groupingSeparator
                 groupingSize:(NSUInteger)groupingSize;
// 小数位数
+ (NSString *)fractionDigits:(NSNumber *)obj
                         min:(NSUInteger)min
                         max:(NSUInteger)max
                roundingMode:(NSNumberFormatterRoundingMode)roundingMode;
// 小数位数
+ (NSString *)fractionDigits:(NSNumber *)obj;
/// number为NSNumber/String
+ (NSString *)localizedString:(NSNumberFormatterStyle)style number:(NSString *)number;


@end


@interface NSDecimalNumber (Helper)

@property (nonatomic, strong, readonly) NSString *string;

NSDecimalNumber * NSDecNumFromString(NSString *string);

NSDecimalNumber * NSDecNumFromFloat(CGFloat num);

/**
 四舍五入
 @param scale 小数点后保留的位数
 */
NSDecimalNumber * NSDecNumFromRoundPlain(NSDecimalNumber *num, NSUInteger scale);

/**
 只入不舍
 @param scale 小数点后保留的位数
 */
NSDecimalNumber * NSDecNumFromRoundUp(NSDecimalNumber *num, NSUInteger scale);
/**
 只舍不入
 @param scale 小数点后保留的位数
 */
NSDecimalNumber * NSDecNumFromRoundDown(NSDecimalNumber *num, NSUInteger scale);
/**
 (也是四舍五入,这是和NSRoundPlain不一样,如果精确的哪位是5,
 它要看精确度的前一位是偶数还是奇数,如果是奇数,则入,偶数则舍,例如scale=1,表示精确到小数点后一位, NSDecimalNumber 为1.25时,
 NSRoundPlain结果为1.3,而NSRoundBankers则是1.2)
 @param scale 小数点后保留的位数
 */
NSDecimalNumber * NSDecNumFromRoundBanks(NSDecimalNumber *num, NSUInteger scale);
    
@end
NS_ASSUME_NONNULL_END
