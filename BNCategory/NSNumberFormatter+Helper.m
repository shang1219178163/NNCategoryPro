//
//  NSNumberFormatter+Helper.m
//  Location
//
//  Created by BIN on 2017/12/21.
//  Copyright © 2017年 Location. All rights reserved.
//

#import "NSNumberFormatter+Helper.h"
#import "BNGloble.h"

NSString * const kNumIdentify = @"四舍五入";// 默认
NSString * const kNumIdentify_decimal = @"分隔符,保留3位小数";
NSString * const kNumIdentify_percent = @"百分比";
NSString * const kNumIdentify_currency = @"货币$";
NSString * const kNumIdentify_scientific = @"科学计数法 1.234E8";
NSString * const kNumIdentify_plusSign = @"加号符号";
NSString * const kNumIdentify_minusSign = @"减号符号";
NSString * const kNumIdentify_exponentSymbol = @"指数符号";

NSString * const kNumFormat = @"#,##0.00";

@implementation NSNumberFormatter (Helper)

static NSDictionary *_styleDic = nil;

+ (NSDictionary *)styleDic{
    if (!_styleDic) {
        _styleDic = @{
                      kNumIdentify: @(NSNumberFormatterNoStyle),
                      kNumIdentify_decimal: @(NSNumberFormatterDecimalStyle),
                      kNumIdentify_percent: @(NSNumberFormatterPercentStyle),
                      kNumIdentify_currency: @(NSNumberFormatterCurrencyStyle),
                      kNumIdentify_scientific: @(NSNumberFormatterScientificStyle),
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
        formatter.minimumFractionDigits = 2;//最少两位整数
        formatter.maximumFractionDigits = 2;//最多两位小数
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
    formatter.minimumFractionDigits = min;//最少一位整数
    formatter.maximumFractionDigits = max;//最多两位小数
    formatter.roundingMode = roundingMode;
    return [formatter stringFromNumber:obj] ? : @"";
}

// 小数位数
+ (NSString *)fractionDigits:(NSNumber *)obj{
    NSString *result = [NSNumberFormatter fractionDigits:obj min:2 max:2 roundingMode:NSNumberFormatterRoundUp];
    return result;
}

+ (NSNumberFormatter *)positiveFormat:(NSString *)formatStr{
    NSNumberFormatter *formatter = [NSNumberFormatter numberIdentify:formatStr];
    formatter.positiveFormat = formatStr;
    return formatter;
}

+ (NSString *)numberStyle:(NSNumberFormatterStyle)nstyle number:(id)number{
    if ([number isKindOfClass:[NSString class]]) {
        NSString * charSet = @"0123456789.";
        NSCharacterSet *set = [[NSCharacterSet characterSetWithCharactersInString:charSet] invertedSet];
        NSString *result = [[number componentsSeparatedByCharactersInSet:set] componentsJoinedByString:@""];
        if ([result isEqualToString:number]) {
            number = @([number floatValue]);
            NSString *string  = [NSNumberFormatter localizedStringFromNumber:number numberStyle:nstyle];
            return string;
        }
    }
    else if ([number isKindOfClass:[NSNumber class]]) {
        NSString *string = [NSNumberFormatter localizedStringFromNumber:number numberStyle:nstyle];
        return string;
        
    }
    return number;
}

@end
