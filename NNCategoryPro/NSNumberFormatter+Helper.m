//
//  NSNumberFormatter+Helper.m
//  Location
//
//  Created by BIN on 2017/12/21.
//  Copyright © 2017年 Shang. All rights reserved.
//

#import "NSNumberFormatter+Helper.h"
#import <NNGloble/NNGloble.h>

NSString * const kNumFormat = @"¥###,##0.00";

@implementation NSNumberFormatter (Helper)

- (NSNumberFormatter * _Nonnull (^)(NSUInteger, NSUInteger, NSUInteger, NSUInteger))digits{
    return ^(NSUInteger minIntegerDigits, NSUInteger maxIntegerDigits, NSUInteger minFractionDigits, NSUInteger maxFractionDigits) {
        self.minimumIntegerDigits = minIntegerDigits;
        self.maximumIntegerDigits = maxIntegerDigits;
        self.minimumFractionDigits = minFractionDigits;
        self.maximumFractionDigits = maxFractionDigits;
        return self;
    };
}

- (NSNumberFormatter * _Nonnull (^)(NSString * _Nonnull, NSUInteger))group{
    return ^(NSString * groupingSeparator, NSUInteger groupingSize) {
        self.usesGroupingSeparator = true;
        self.groupingSeparator = groupingSeparator;
        self.groupingSize = groupingSize;
        return self;
    };
}


- (NSNumberFormatter * _Nonnull (^)(NSString *))positivePrefix{
    return ^(NSString * value) {
        self.positivePrefix = value;
        return self;
    };
}

- (NSNumberFormatter * _Nonnull (^)(NSString *))positiveSuffix{
    return ^(NSString * value) {
        self.positiveSuffix = value;
        return self;
    };
}

- (NSNumberFormatter * _Nonnull (^)(NSString *))negativePrefix{
    return ^(NSString * value) {
        self.negativePrefix = value;
        return self;
    };
}

- (NSNumberFormatter * _Nonnull (^)(NSString *))negativeSuffix{
    return ^(NSString * value) {
        self.negativeSuffix = value;
        return self;
    };
}

- (NSNumberFormatter * _Nonnull (^)(NSString *))positiveFormat{
    return ^(NSString * value) {
        self.positiveFormat = value;
        return self;
    };
}

- (NSNumberFormatter * _Nonnull (^)(NSString *))negativeFormat{
    return ^(NSString * value) {
        self.negativeFormat = value;
        return self;
    };
}

- (NSNumberFormatter * _Nonnull (^)(NSString *))paddingCharacter{
    return ^(NSString * value) {
        self.paddingCharacter = value;
        return self;
    };
}


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
+ (NSNumberFormatter *)numberStyle:(NSNumberFormatterStyle)style{
    NSString *key = [@"NSNumberFormatterStyle" stringByAppendingFormat:@"%@", @(style)];
    //使用当前线程字典来保存对象
    NSMutableDictionary *mdic = NSThread.currentThread.threadDictionary;
    NSNumberFormatter *formatter = mdic[key];
    if (formatter) {
        return formatter;
    }

    formatter = [[NSNumberFormatter alloc]init];
    formatter.locale = [NSLocale localeWithLocaleIdentifier:kLanguageCN];
    formatter.numberStyle = style;
//    formatter.minimumIntegerDigits = 1;//最少小数点前的位数
//    formatter.minimumFractionDigits = 2;//最少小数点后的位数
//    formatter.maximumFractionDigits = 2;//最多小数点后的位数
//    formatter.roundingMode = NSNumberFormatterRoundUp;

    mdic[key] = formatter;
    return formatter;
}

+ (NSNumberFormatter *)format:(NSNumberFormatterStyle)style
            minFractionDigits:(NSUInteger)minFractionDigits
            maxFractionDigits:(NSUInteger)maxFractionDigits
               positivePrefix:(NSString *)positivePrefix
            groupingSeparator:(NSString *)groupingSeparator
                 groupingSize:(NSUInteger)groupingSize{
    NSNumberFormatter *formatter = [NSNumberFormatter numberStyle:style];
    formatter.positivePrefix = positivePrefix;

    formatter.usesGroupingSeparator = true; //分隔设true
    formatter.groupingSeparator = groupingSeparator; //分隔符
    formatter.groupingSize = groupingSize;  //分隔位数
    return formatter;
}

// 小数位数
+ (NSString *)fractionDigits:(NSNumber *)obj
                         min:(NSUInteger)min
                         max:(NSUInteger)max
                roundingMode:(NSNumberFormatterRoundingMode)roundingMode{
    
    NSNumberFormatter *formatter = [NSNumberFormatter numberStyle:NSNumberFormatterCurrencyStyle];
    formatter.minimumFractionDigits = min;//最少小数点后的位数
    formatter.maximumFractionDigits = max;//最多小数点后的位数
    formatter.roundingMode = roundingMode;
    return [formatter stringFromNumber:obj];
}

// 小数位数
+ (NSString *)fractionDigits:(NSNumber *)obj{
    NSString *result = [NSNumberFormatter fractionDigits:obj
                                                     min:2
                                                     max:2
                                            roundingMode:NSNumberFormatterRoundUp];
    return result;
}

/// number为NSNumber/String
+ (NSString *)localizedString:(NSNumberFormatterStyle)style number:(NSString *)number{
    NSString *charSet = @"0123456789.";
    NSCharacterSet *set = [[NSCharacterSet characterSetWithCharactersInString:charSet] invertedSet];
    NSString *result = [[number componentsSeparatedByCharactersInSet:set] componentsJoinedByString:@""];
    NSNumber *value = @([result floatValue]);
    NSString *string = [NSNumberFormatter localizedStringFromNumber:value numberStyle:style];
    return string;
}




@end



@implementation NSDecimalNumber (Helper)

-(NSString *)string{
    return [NSString stringWithFormat:@"%@", self];
}

NSDecimalNumber * NSDecNumFromString(NSString *string){
    return [NSDecimalNumber decimalNumberWithString:string];
}

NSDecimalNumber * NSDecNumFromFloat(CGFloat num){
    return [NSDecimalNumber decimalNumberWithDecimal:[@(num) decimalValue]];
}

NSDecimalNumber * NSDecNumFrom(NSDecimalNumber *num, NSUInteger scale, NSRoundingMode roundingMode){
    NSDecimalNumberHandler * handler = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:roundingMode
                                                                                               scale:scale
                                                                                    raiseOnExactness:false
                                                                                     raiseOnOverflow:false
                                                                                    raiseOnUnderflow:false
                                                                                 raiseOnDivideByZero:true];
    return [num decimalNumberByRoundingAccordingToBehavior:handler];
}


/**
 四舍五入
 @param scale 小数点后保留的位数
 */
NSDecimalNumber * NSDecNumFromRoundPlain(NSDecimalNumber *num, NSUInteger scale){
    return NSDecNumFrom(num, scale, NSRoundPlain);
}

/**
 只入不舍
 @param scale 小数点后保留的位数
 */
NSDecimalNumber * NSDecNumFromRoundUp(NSDecimalNumber *num, NSUInteger scale){
    return NSDecNumFrom(num, scale, NSRoundUp);
}

/**
 只舍不入
 @param scale 小数点后保留的位数
 */
NSDecimalNumber * NSDecNumFromRoundDown(NSDecimalNumber *num, NSUInteger scale){
    return NSDecNumFrom(num, scale, NSRoundDown);
}

/**
 (也是四舍五入,这是和NSRoundPlain不一样,如果精确的哪位是5,
 它要看精确度的前一位是偶数还是奇数,如果是奇数,则入,偶数则舍,例如scale=1,表示精确到小数点后一位, NSDecimalNumber 为1.25时,
 NSRoundPlain结果为1.3,而NSRoundBankers则是1.2)
 @param scale 小数点后保留的位数
 */
NSDecimalNumber * NSDecNumFromRoundBanks(NSDecimalNumber *num, NSUInteger scale){
    return NSDecNumFrom(num, scale, NSRoundBankers);
}

@end
