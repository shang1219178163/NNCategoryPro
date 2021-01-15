//
//  NSDate+Helper.m
//  Location
//
//  Created by BIN on 2017/12/21.
//  Copyright © 2017年 Shang. All rights reserved.
//

#import "NSDate+Helper.h"

#import "NSDateFormatter+Helper.h"
#import "NSDateComponents+Helper.h"

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
    NSString *time = [NSDateFormatter stringFromDate:self fmt:kFormatDate];
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
