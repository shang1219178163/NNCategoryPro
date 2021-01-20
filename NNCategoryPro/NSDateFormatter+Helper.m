//
//  NSDateFormatter+Helper.m
//  Location
//
//  Created by BIN on 2017/12/21.
//  Copyright © 2017年 Shang. All rights reserved.
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
    NSDateFormatter *fmt = [NSDateFormatter dateFormat:format];
    return [fmt stringFromDate:date];
}
/**
 日期字符串->NSDate
 */
+ (nullable NSDate *)dateFromString:(NSString *)dateStr fmt:(NSString *)format{
    NSDateFormatter *fmt = [NSDateFormatter dateFormat:format];
    NSString *tmp = dateStr.length <= format.length ? dateStr : [dateStr substringToIndex:format.length];
    return [fmt dateFromString:tmp];
}

/**
 时间戳->日期字符串
 */
+ (NSString *)stringFromInterval:(NSString *)interval fmt:(NSString *)format{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval.doubleValue];
    return [NSDateFormatter stringFromDate:date fmt:format];
}

/**
 日期字符串->时间戳字符串
 */
+ (NSString *)intervalFromDateStr:(NSString *)dateStr fmt:(NSString *)format{
    NSDate *date = [NSDateFormatter dateFromString:dateStr fmt:format];
    if (!date) {
        return @"";
    }
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
//    NSDate *date = NSDate.date;
//    NSTimeZone.defaultTimeZone = [NSTimeZone timeZoneWithName:@"GMT"];;
//
//    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
//    formatter.dateFormat = @"EEE, dd MMM yyyy HH:mm:ss 'GMT'";
//    formatter.locale = [NSLocale localeWithLocaleIdentifier:kLanguageCN];
//    return [formatter stringFromDate:date];
//}

+ (NSArray *)betweenDaysWithDate:(NSDate *)fromDate toDate:(NSDate *)toDate block:(void(^)(NSDateComponents *comps, NSDate *date))block{
    if (!fromDate || !toDate) {
        return @[];
    }
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier: NSCalendarIdentifierGregorian];
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay |  NSCalendarUnitWeekday;

    NSDate *start = fromDate;
    NSDate *end = toDate;
    
    NSMutableArray *marr = [NSMutableArray array];
    NSDateComponents *comps;

    NSComparisonResult result = [start compare:end];
    while (result != NSOrderedDescending) {
        comps = [calendar components:unit fromDate:start];

        NSString *dateStr = [NSDateFormatter stringFromDate:start fmt:@"yyyy-MM-dd"];
        [marr addObject:dateStr];
        
        if (block) {
            block(comps, start);
        }
        //后一天
        comps.day += 1;
        start = [calendar dateFromComponents:comps];
        //对比日期大小
        result = [start compare:end];
    }
    return marr.copy;
}

@end


@implementation NSDateComponents (Helper)

+ (NSDateComponents *)dateWithYear:(NSInteger)year
                             month:(NSInteger)month
                               day:(NSInteger)day
                              hour:(NSInteger)hour
                            minute:(NSInteger)minute
                            second:(NSInteger)second{
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    comps.year = year;
    comps.month = month;
    comps.day = day;
    comps.hour = hour;
    comps.minute = minute;
    comps.second = second;
    return comps;
}


@end


@implementation NSCalendar (Helper)

static NSCalendar *_shared = nil;
+ (NSCalendar *)shard{
    if (!_shared) {
        _shared = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    }
    return _shared;
}

+ (NSCalendarUnit)unitFlags{
    return NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay |
    NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond |
    NSCalendarUnitWeekdayOrdinal | NSCalendarUnitWeekday;
}

static NSArray *_dayList = nil;
+ (NSArray *)dayList{
    if (!_dayList) {
        NSString *string = @"初一, 初二, 初三, 初四, 初五, 初六, 初七, 初八, 初九, 初十,十一, 十二, 十三, 十四, 十五, 十六, 十七, 十八, 十九, 二十, 廿一, 廿二, 廿三, 廿四, 廿五, 廿六, 廿七, 廿八, 廿九, 三十, 三十一";
        _dayList = [string componentsSeparatedByString:@","];
    }
    return _dayList;
}

static NSArray *_monthList = nil;
+ (NSArray *)monthList{
    if (!_monthList) {
        NSString *string = @"正月, 二月, 三月, 四月, 五月, 六月, 七月, 八月,九月, 十月, 冬月, 腊月";
        _monthList = [string componentsSeparatedByString:@","];
    }
    return _monthList;
}

static NSArray *_weekList = nil;
+ (NSArray *)weekList{
    if (!_weekList) {
        NSString *string = @"星期一,星期二,星期三,星期四,星期五,星期六,星期天";
        _weekList = [string componentsSeparatedByString:@","];
    }
    return _weekList;
}

@end
