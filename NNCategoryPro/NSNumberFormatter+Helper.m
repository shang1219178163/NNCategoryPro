//
//  NSNumberFormatter+Helper.m
//  Location
//
//  Created by BIN on 2017/12/21.
//  Copyright © 2017年 Shang. All rights reserved.
//

#import "NSNumberFormatter+Helper.h"
#import <NNGloble/NNGloble.h>

NSString * const kNumIdentify = @"四舍五入";// 默认
NSString * const kNumIdentifyDecimal = @"分隔符,保留3位小数";
NSString * const kNumIdentifyPercent = @"百分比";
NSString * const kNumIdentifyCurrency = @"货币$";
NSString * const kNumIdentifyScientific = @"科学计数法 1.234E8";
NSString * const kNumIdentifyPlusSign = @"加号符号";
NSString * const kNumIdentifyMinusSign = @"减号符号";
NSString * const kNumIdentifyExponentSymbol = @"指数符号";

NSString * const kNumFormat = @"#,##0.00";

@implementation NSNumberFormatter (Helper)

static NSDictionary *_styleDic = nil;
+ (NSDictionary *)styleDic{
    if (!_styleDic) {
        _styleDic = @{kNumIdentify: @(NSNumberFormatterNoStyle),
                      kNumIdentifyDecimal: @(NSNumberFormatterDecimalStyle),
                      kNumIdentifyPercent: @(NSNumberFormatterPercentStyle),
                      kNumIdentifyCurrency: @(NSNumberFormatterCurrencyStyle),
                      kNumIdentifyScientific: @(NSNumberFormatterScientificStyle),
                      };
    }
    return _styleDic;
}

+ (NSNumberFormatter *)numberIdentify:(NSString *)identify{
    //使用当前线程字典来保存对象
    NSMutableDictionary *threadDic = NSThread.currentThread.threadDictionary;
    NSNumberFormatter *formatter = [threadDic objectForKey:identify];
    if (!formatter) {
        formatter = [[NSNumberFormatter alloc]init];
        formatter.locale = [NSLocale localeWithLocaleIdentifier:kLanguageCN];
        formatter.minimumIntegerDigits = 1;//最少小数点前的位数
        formatter.minimumFractionDigits = 2;//最少小数点后的位数
        formatter.maximumFractionDigits = 2;//最多小数点后的位数
        formatter.roundingMode = NSNumberFormatterRoundUp;
        //格式
        if ([NSNumberFormatter.styleDic.allKeys containsObject:identify]) {
            NSUInteger style = [NSNumberFormatter.styleDic[identify] unsignedIntegerValue];
            if (style > 10 || style == 7) {
                formatter.numberStyle = NSNumberFormatterNoStyle;
            }
        }
        [threadDic setObject:formatter forKey:identify];
    }
    return formatter;
}

// 小数位数
+ (NSString *)fractionDigits:(NSNumber *)obj
                         min:(NSUInteger)min
                         max:(NSUInteger)max
                roundingMode:(NSNumberFormatterRoundingMode)roundingMode{
    
    NSNumberFormatter *formatter = [NSNumberFormatter numberIdentify:kNumIdentify];
    formatter.minimumFractionDigits = min;//最少小数点后的位数
    formatter.maximumFractionDigits = max;//最多小数点后的位数
    formatter.roundingMode = roundingMode;
    return [formatter stringFromNumber:obj] ? : @"";
}

// 小数位数
+ (NSString *)fractionDigits:(NSNumber *)obj{
    NSString *result = [NSNumberFormatter fractionDigits:obj
                                                     min:2
                                                     max:2
                                            roundingMode:NSNumberFormatterRoundUp];
    return result;
}

+ (NSNumberFormatter *)positiveFormat:(NSString *)formatStr{
    NSNumberFormatter *formatter = [NSNumberFormatter numberIdentify:kNumIdentifyDecimal];
    formatter.positiveFormat = formatStr;
    return formatter;
}

+ (NSNumberFormatter *)positive:(NSString *)formatStr
                         prefix:(NSString *)prefix
                         suffix:(NSString *)suffix
                        defalut:(NSString *)defalut{
    NSNumberFormatter *formatter = [NSNumberFormatter numberIdentify:kNumIdentifyDecimal];
    formatter.positivePrefix = prefix;
    formatter.positiveSuffix = suffix;

    formatter.usesGroupingSeparator = true; //分隔设true
    formatter.groupingSeparator = @","; //分隔符
    formatter.groupingSize = 3;  //分隔位数
    return formatter;
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
