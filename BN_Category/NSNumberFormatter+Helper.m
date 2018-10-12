//
//  NSNumberFormatter+Helper.m
//  Location
//
//  Created by BIN on 2017/12/21.
//  Copyright © 2017年 Location. All rights reserved.
//

#import "NSNumberFormatter+Helper.h"

@implementation NSNumberFormatter (Helper)

+ (NSNumberFormatter *)numberIdentify:(NSString *)identify{
    // 版本2 ，使用当前线程字典来保存对象
    NSMutableDictionary *threadDic = [[NSThread currentThread] threadDictionary];
    NSNumberFormatter *formatter = [threadDic objectForKey:identify];
    if (!formatter) {
        formatter = [[NSNumberFormatter alloc]init];
        [threadDic setObject:formatter forKey:identify];
    }
    return formatter;
}

+ (NSNumberFormatter *)numberFormat:(NSString *)formatStr{
    NSNumberFormatter *formatter = [self numberIdentify:formatStr];
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
