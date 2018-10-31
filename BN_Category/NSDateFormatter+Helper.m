//
//  NSDateFormatter+Helper.m
//  Location
//
//  Created by BIN on 2017/12/21.
//  Copyright © 2017年 Location. All rights reserved.
//

#import "NSDateFormatter+Helper.h"

@implementation NSDateFormatter (Helper)


+ (NSDateFormatter *)dateFormat:(NSString *)formatStr{
    // 版本2 ，使用当前线程字典来保存对象
    NSMutableDictionary *threadDic = NSThread.currentThread.threadDictionary;
    NSDateFormatter *formatter = [threadDic objectForKey:formatStr];
    if (!formatter) {
        formatter = [[NSDateFormatter alloc]init];
        formatter.dateFormat = formatStr;
        formatter.locale = [NSLocale localeWithLocaleIdentifier:@"zh_CN"];
        formatter.timeZone = NSTimeZone.systemTimeZone;

        [threadDic setObject:formatter forKey:formatStr];
    }
    return formatter;
}


@end
