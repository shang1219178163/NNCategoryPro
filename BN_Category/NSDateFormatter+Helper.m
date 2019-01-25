//
//  NSDateFormatter+Helper.m
//  Location
//
//  Created by BIN on 2017/12/21.
//  Copyright © 2017年 Location. All rights reserved.
//

#import "NSDateFormatter+Helper.h"

const NSInteger kDate_second = 1 ;
const NSInteger kDate_minute = 60 ;
const NSInteger kDate_hour = 3600 ;
const NSInteger kDate_day = 86400 ;
const NSInteger kDate_week = 604800 ;
const NSInteger kDate_year = 31556926;

NSString * const kFormatDate = @"yyyy-MM-dd HH:mm:ss";
NSString * const kFormatDate_one = @"yyyy-MM-dd";
NSString * const kFormatDate_two = @"yyyyMMdd";
NSString * const kFormatDate_five = @"yyyyMMddHHmmss";

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

+ (NSString *)format:(NSString *)format date:(NSDate *)date {
    NSDateFormatter * fmt = [NSDateFormatter dateFormat:format];
    return [fmt stringFromDate:date];
}

+ (NSDate *)format:(NSString *)format dateStr:(NSString *)dateStr {
    NSDateFormatter * fmt = [NSDateFormatter dateFormat:format];
    return [fmt dateFromString:dateStr];
}

+ (NSString *)format:(NSString *)format interval:(NSTimeInterval)interval {
    NSDate * date = [NSDate dateWithTimeIntervalSince1970:interval];
    return [NSDateFormatter format:format date:date];
}

@end
