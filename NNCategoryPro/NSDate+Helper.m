//
//  NSDate+Helper.m
//  Location
//
//  Created by BIN on 2017/12/21.
//  Copyright © 2017年 Shang. All rights reserved.
//

#import "NSDate+Helper.h"
#import <NNGloble/NNGloble.h>

const NSInteger kDateMinute = 60 ;
const NSInteger kDateHour   = 3600 ;
const NSInteger kDateDay    = 86400 ;
const NSInteger kDateWeek   = 604800 ;
const NSInteger kDateYear   = 31556926 ;

NSString * const kDateFormat         = @"yyyy-MM-dd HH:mm:ss";
NSString * const kDateFormatMinute   = @"yyyy-MM-dd HH:mm";
NSString * const kDateFormatDay      = @"yyyy-MM-dd";

NSString * const kDateFormatMonth_CH = @"yyyy年MM月";
NSString * const kDateFormatDay_CH   = @"yyyy年MM月dd日";

NSString * const kDateFormatStart    = @"yyyy-MM-dd 00:00:00";
NSString * const kDateFormatEnd      = @"yyyy-MM-dd 23:59:59";

NSString * const kDateFormatTwo      = @"yyyyMMdd";
NSString * const kDateFormatFive     = @"yyyyMMddHHmmss";
NSString * const kDateFormatSix      = @"EEE, dd MMM yyyy HH:mm:ss 'GMT'";

@implementation NSDate(Helper)

+ (NSDate *)dateLocale{
//    return [NSDate.date dateByAddingTimeInterval:8 * 60 * 60];
    NSTimeInterval interval = [NSTimeZone.systemTimeZone secondsFromGMTForDate: NSDate.date];
    return [NSDate.date dateByAddingTimeInterval:interval];;
}

+ (NSTimeInterval)timeZoneInterval{
    return [NSTimeZone.systemTimeZone secondsFromGMTForDate: NSDate.date];
}

///获取当前时间
-(NSString *)now{
    NSString *time = [NSDateFormatter stringFromDate:self fmt:kDateFormat];
    return time;
}

///获取时间的时间戳
-(NSString *)timeStamp{
   return [@(self.timeIntervalSince1970) stringValue];
}

///获取时间的时间戳
- (NSString *)timeStamp13{
   return [@(self.timeIntervalSince1970*1000) stringValue];
}

- (NSString *)betweenInfo:(NSDate *)date{
    NSTimeInterval value = fabs(date.timeIntervalSince1970 - self.timeIntervalSince1970);
    
    NSInteger year = 0;
    NSInteger day = 0;
    NSInteger hour = 0;
    NSInteger minute = 0;
    NSInteger second = 0;
    
    NSString *result = @"";
    if (value > 365*24*3600) {
        year = value/(365*24*3600);
        result = [result stringByAppendingFormat:@"%@年", @(year)];
        value -= year*(365*24*3600);
    }
    
    if (value > 24*3600) {
        day = value/(24*3600);
        result = [result stringByAppendingFormat:@"%@天", @(day)];
        value -= day*(24*3600);
    }
    
    if (value > 3600) {
        hour = value/3600;
        result = [result stringByAppendingFormat:@"%@小时", @(hour)];
        value -= hour*3600;
    }
    
    if (value > 60) {
        minute = value/60;
        result = [result stringByAppendingFormat:@"%@分", @(minute)];
        value -= minute*60;
    }
    
    if (value > 0) {
        second = value;
        result = [result stringByAppendingFormat:@"%@秒", @(second)];
    }
    return result;
}

- (NSDate *)dateTomorrow{
    return [self dateByAddDays:1];
}

- (NSDate *)dateYesterday{
    return [self dateByAddDays:-1];
}

- (NSDateComponents *)components{
    return [NSCalendar.shard components:NSCalendar.unitFlags fromDate:self];
}

- (NSDateComponents *)componentsToDate:(NSDate *)date{
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay |
    NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    return [NSCalendar.shard components:unit fromDate:self toDate:date options:0];
}

- (NSInteger)year{
    return self.components.year;
}

- (NSInteger)month{
    return self.components.month;
}

- (NSInteger)day{
    return self.components.day;
}

- (NSInteger)hour{
    return self.components.hour;
}

- (NSInteger)minute{
    return self.components.minute;
}

- (NSInteger)second{
    return self.components.second;
}

- (NSInteger)week{
    return self.components.weekOfMonth;
}

- (NSInteger)weekday{
    return self.components.weekday;
}

- (NSInteger)weekdayOrdinal{// e.g. 2nd Tuesday of the month is 2
    return self.components.weekdayOrdinal;
}

- (BOOL)isToday{
    return [NSCalendar.shard isDateInToday:self];
}

- (BOOL)isTomorrow{
    return [NSCalendar.shard isDateInTomorrow:self];
}

- (BOOL)isYesterday{
    return [NSCalendar.shard isDateInYesterday:self];
}

- (BOOL)isTypicallyWeekend{
    NSDateComponents *comps = [NSCalendar.shard components:NSCalendar.unitFlags fromDate:self];
    bool result = (comps.weekday == 1) || (comps.weekday == 7);
    return result;
}

- (BOOL)isTypicallyWorkday{
    return ![self isTypicallyWeekend];
}

/**
 某个日期月份包含的天数
 */
- (NSInteger)countOfDayInMonth{
    NSRange range = [NSCalendar.shard rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:self];
    return range.length;
}

- (NSInteger)countOfDayToDate:(NSDate *)date{
    NSDateComponents *comps = [NSCalendar.shard components:NSCalendarUnitDay fromDate:self toDate:date options:0];
    return comps.day;
}

/**
 某个日期鱼粉的第一天的值(默认顺序为“日一二三四五六”，1:星期日，2:星期一，依次类推)
 */
-(NSInteger)firstWeekDay{
    NSInteger day = [NSCalendar.shard ordinalityOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitWeekOfYear forDate:self];
    return day;
}

- (BOOL)isSameWeekAsDate:(NSDate *)date{
    return [NSCalendar.shard isDate:self inSameDayAsDate:date];
}
       
- (BOOL)isEarlierThanDate:(NSDate *)date{
    return ([self compare:date] == NSOrderedAscending);
}

- (BOOL)isLaterThanDate:(NSDate *)date{
    return ([self compare:date] == NSOrderedDescending);
}

- (NSDate *)addingDay:(NSInteger)day
                 hour:(NSInteger)hour
               minute:(NSInteger)minute
               second:(NSInteger)second{
    NSTimeInterval aTimeInterval = self.timeIntervalSince1970 + kDateDay*day + kDateHour*hour + kDateMinute*minute + second;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:aTimeInterval];
    return date;
}

- (NSDate *)dateByAddDays:(NSInteger) dDays{
    return [self addingDay:dDays hour:0 minute:0 second:0];;
}

- (NSDate *)dateByAddHours:(NSInteger )dHours{
    return [self addingDay:0 hour:dHours minute:0 second:0];;
}

- (NSDate *)dateByAddMinutes:(NSInteger )dMinutes{
    return [self addingDay:0 hour:0 minute:dMinutes second:0];;
}
          

@end



@implementation NSDateFormatter (Helper)

+ (NSDateFormatter *)dateFormat:(NSString *)formtStr{
    // 版本2 ，使用当前线程字典来保存对象
    NSMutableDictionary *threadDic = NSThread.currentThread.threadDictionary;
    NSDateFormatter *formatter = [threadDic objectForKey:formtStr];
    if (!formatter) {
        formatter = [[NSDateFormatter alloc]init];
        formatter.dateFormat = formtStr;
        formatter.locale = NSLocale.zh_CN;
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


