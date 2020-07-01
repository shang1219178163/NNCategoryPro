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
        _styleDic = @{
                      kNumIdentify: @(NSNumberFormatterNoStyle),
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
+ (NSString *)localizedString:(NSNumberFormatterStyle)nstyle number:(NSString *)number{
    NSString *charSet = @"0123456789.";
    NSCharacterSet *set = [[NSCharacterSet characterSetWithCharactersInString:charSet] invertedSet];
    NSString *result = [[number componentsSeparatedByCharactersInSet:set] componentsJoinedByString:@""];
    NSNumber *value = @([result floatValue]);
    NSString *string = [NSNumberFormatter localizedStringFromNumber:value numberStyle:nstyle];
    return string;
}


@end
