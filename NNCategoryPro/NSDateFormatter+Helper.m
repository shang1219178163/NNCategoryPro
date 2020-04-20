//
//  NSDateFormatter+Helper.m
//  Location
//
//  Created by BIN on 2017/12/21.
//  Copyright © 2017年 Location. All rights reserved.
//

#import "NSDateFormatter+Helper.h"
#import <NNGloble/NNGloble.h>
#import "NSDate+Helper.h"

const NSInteger kDateMinute = 60 ;
const NSInteger kDateHour   = 3600 ;
const NSInteger kDateDay    = 86400 ;
const NSInteger kDateWeek   = 604800 ;
const NSInteger kDateYear   = 31556926 ;

NSString * const kFormatDate         = @"yyyy-MM-dd HH:mm:ss";
NSString * const kDateFormatMinute   = @"yyyy-MM-dd HH:mm";
NSString * const kDateFormatDay      = @"yyyy-MM-dd";

NSString * const kDateFormatMonth_CH = @"yyyy年MM月";
NSString * const kDateFormatDay_CH   = @"yyyy年MM月dd日";

NSString * const kDateFormatStart    = @"yyyy-MM-dd 00:00:00";
NSString * const kDateFormatEnd      = @"yyyy-MM-dd 23:59:59";

NSString * const kDateFormatTwo      = @"yyyyMMdd";
NSString * const kFormatDateFive     = @"yyyyMMddHHmmss";
NSString * const kFormatDateSix      = @"EEE, dd MMM yyyy HH:mm:ss 'GMT'";

@implementation NSDateFormatter (Helper)

+ (NSDateFormatter *)dateFormat:(NSString *)formtStr{
    // 版本2 ，使用当前线程字典来保存对象
    NSMutableDictionary *threadDic = NSThread.currentThread.threadDictionary;
    NSDateFormatter *formatter = [threadDic objectForKey:formtStr];
    if (!formatter) {
        formatter = [[NSDateFormatter alloc]init];
        formatter.dateFormat = formtStr;
        formatter.locale = [NSLocale localeWithLocaleIdentifier:kLanguageCN];
        formatter.timeZone = NSTimeZone.systemTimeZone;
        if ([formtStr containsString:@"GMT"]) {
            formatter.timeZone = [NSTimeZone timeZoneWithName:@"GMT"];
        }

        [threadDic setObject:formatter forKey:formtStr];
    }
    return formatter;
}

/**
 NSDate->日期字符串
 */
+ (NSString *)stringFromDate:(NSDate *)date fmt:(NSString *)format{
    NSDateFormatter * fmt = [NSDateFormatter dateFormat:format];
    return [fmt stringFromDate:date];
}
/**
 日期字符串->NSDate
 */
+ (NSDate *)dateFromString:(NSString *)dateStr fmt:(NSString *)format{
    NSDateFormatter * fmt = [NSDateFormatter dateFormat:format];
    return [fmt dateFromString:dateStr];
}

/**
 时间戳->日期字符串
 */
+ (NSString *)stringFromInterval:(NSString *)interval fmt:(NSString *)format{
    NSDate * date = [NSDate dateWithTimeIntervalSince1970:interval.doubleValue];
    return [NSDateFormatter stringFromDate:date fmt:format];
}

/**
 日期字符串->时间戳字符串
 */
+ (NSString *)intervalFromDateStr:(NSString *)dateStr fmt:(NSString *)format{
    NSDate * date = [NSDateFormatter dateFromString:dateStr fmt:format];
    NSString *intervalStr = [@(date.timeIntervalSince1970) stringValue];
    intervalStr = [intervalStr stringByReplacingOccurrencesOfString:@".00" withString:@""];
    return intervalStr;
}

/**
 时间戳->NSDate
 */
+ (NSDate *)dateFromInterval:(NSString *)interval{
    return [NSDate dateWithTimeIntervalSince1970:interval.doubleValue];
}

/**
 NSDate->时间戳
 */
+ (NSString *)intervalFromDate:(NSDate *)date{
    return [@(date.timeIntervalSince1970) stringValue];
}

+ (NSArray<NSString *> *)queryDate:(NSInteger)day{
    NSDate *endDate = NSDate.date;
    NSDate *startDate = [endDate addingDay:day hour:0 minute:0 second:0];
    
    NSString *endTime = [NSDateFormatter stringFromDate:endDate fmt:@"yyyy-MM-dd 23:59:59"];
    NSString *startTime = [NSDateFormatter stringFromDate:startDate fmt:@"yyyy-MM-dd 00:00:00"];
    return @[startTime, endTime];
}

//+ (NSString *)currentGMT {
//
//    NSDate *date = NSDate.date;
//    NSTimeZone.defaultTimeZone = [NSTimeZone timeZoneWithName:@"GMT"];;
//
//    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
//    formatter.dateFormat = @"EEE, dd MMM yyyy HH:mm:ss 'GMT'";
//    formatter.locale = [NSLocale localeWithLocaleIdentifier:kLanguageCN];
//    return [formatter stringFromDate:date];
//}

@end
