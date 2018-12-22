//
//  NSNumberFormatter+Helper.m
//  Location
//
//  Created by BIN on 2017/12/21.
//  Copyright © 2017年 Location. All rights reserved.
//

#import "NSNumberFormatter+Helper.h"

NSString * const kNumIdentify = @"四舍五入";// 默认
NSString * const kNumIdentify_decimal = @"分隔符,";//
NSString * const kNumIdentify_percent = @"百分比";//
NSString * const kNumIdentify_currency = @"货币$";//
NSString * const kNumIdentify_scientific = @"科学计数法 1.234E8";//
NSString * const kNumIdentify_plusSign = @"加号符号";//
NSString * const kNumIdentify_minusSign = @"减号符号";//
NSString * const kNumIdentify_exponentSymbol = @"指数符号";//

NSString * const kNumFormat = @"#,##0.00";

@implementation NSNumberFormatter (Helper)

+ (NSNumberFormatter *)numberIdentify:(NSString *)identify{
    //使用当前线程字典来保存对象
    NSMutableDictionary *threadDic = NSThread.currentThread.threadDictionary;
    NSNumberFormatter *formatter = [threadDic objectForKey:identify];
    if (!formatter) {
        formatter = [[NSNumberFormatter alloc]init];
        formatter.locale = [NSLocale localeWithLocaleIdentifier:@"zh_CN"];

        [threadDic setObject:formatter forKey:identify];
    }
    return formatter;
}

+ (NSNumberFormatter *)numberFormat:(NSString *)formatStr{
    NSNumberFormatter *formatter = [self numberIdentify:formatStr];
    formatter.numberStyle = NSNumberFormatterNoStyle;//
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
