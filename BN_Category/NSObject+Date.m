//
//  NSObject+Date.m
//  ProductTemplet
//
//  Created by hsf on 2018/9/29.
//  Copyright © 2018年 BN. All rights reserved.
//

/*
G:      公元时代，例如AD公元
yy:     年的后2位
yyyy:   完整年
MM:     月，显示为1-12,带前置0
MMM:    月，显示为英文月份简写,如 Jan
MMMM:   月，显示为英文月份全称，如 Janualy
dd:     日，2位数表示，如02
d:      日，1-2位显示，如2，无前置0
EEE:    简写星期几，如Sun
EEEE:   全写星期几，如Sunday
aa:     上下午，AM/PM
H:      时，24小时制，0-23
HH:     时，24小时制，带前置0
h:      时，12小时制，无前置0
hh:     时，12小时制，带前置0
m:      分，1-2位
mm:     分，2位，带前置0
s:      秒，1-2位
ss:     秒，2位，带前置0
S:      毫秒
Z：     GMT（时区）
*/

#import "NSObject+Date.h"

#import "NSDate+Helper.h"

@implementation NSObject (Date)

- (BOOL)isTimeStamp{
    NSParameterAssert([self isKindOfClass:[NSString class]] || [self isKindOfClass:[NSNumber class]]);
    if ([self isKindOfClass:[NSString class]]) {
        NSString * string = (NSString *)self;
        if (string.length < 10) {
            return NO;
        }
        if ([string containsString:@"-"] || [string containsString:@"/"] || [string containsString:@" "] || [string containsString:@"."]) {
            return NO;
        }
    }else{
        NSNumber * value = (NSNumber *)self;
        if (value.integerValue < (NSInteger)10000000000) {//时间戳都是十位以上
            return NO;
        }
    }
    return YES;
    
}

- (NSDate *)toDateWithFormatter:(NSString *)dateFormatter{
    NSParameterAssert([self isKindOfClass:[NSString class]] || [self isKindOfClass:[NSNumber class]]);
    if ([self isTimeStamp] == NO) {
        return nil;
    }
    NSTimeInterval timeInterval = [self isKindOfClass:[NSString class]] ? [(NSString *)self integerValue] : [(NSNumber *)self integerValue];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    return date;
}

- (NSDate *)toDate{
    NSDate * date = [self toDateWithFormatter:kFormat_date];
    return date;
}

- (NSString *)toTimeDateWithFormatter:(NSString *)dateFormatter{
    NSParameterAssert([self isKindOfClass:[NSString class]] || [self isKindOfClass:[NSNumber class]] || [self isKindOfClass:[NSDate class]]);

    NSDate * date = [self isKindOfClass:[NSDate class]] ? (NSDate *)self : [self toDate];
    NSDateFormatter *formatter = [NSDateFormatter dateFormat:dateFormatter];
    NSString * timeStr = [formatter stringFromDate:date];
    return timeStr;
}

- (NSString *)toTimeDate{
    NSString * timeStr = [self toTimeDateWithFormatter:kFormat_date];
    return timeStr;
}

#pragma mark - -转化

- (NSString *)toTimeStampWithFormatter:(NSString *)dateFormatter{
    NSParameterAssert([self isKindOfClass:[NSString class]] || [self isKindOfClass:[NSNumber class]]);
    NSString * time = [self isKindOfClass:[NSString class]] ? (NSString *)self : [(NSNumber *)self stringValue];
    if ([self isTimeStamp] == YES) {
        return time;
    }
    NSDateFormatter *formatter = [NSDateFormatter dateFormat:dateFormatter];
    NSDate *date = [formatter dateFromString:time]; //将字符串按formatter转成nsdate
    NSString * timestamp = [@([date timeIntervalSince1970]) stringValue];//时间转时间戳的方法:
    return timestamp;
}

- (NSString *)toTimestamp{
    NSParameterAssert([self isKindOfClass:[NSString class]] || [self isKindOfClass:[NSNumber class]] || [self isKindOfClass:[NSDate class]]);
    
    if ([self isKindOfClass:[NSDate class]]) {
        NSString * timestamp = [@([(NSDate *)self timeIntervalSince1970]) stringValue];//时间转时间戳的方法:
        return timestamp;
    }
 
    NSString * dateStr = [self isKindOfClass:[NSString class]] ? (NSString *)self : [(NSNumber *)self stringValue];
    NSString * formatStr = kFormat_date;
    if ([dateStr containsString:@"-"] && [dateStr containsString:@":"]){
        formatStr = kFormat_date;
        
    }
    else if ([dateStr containsString:@"-"] && ![dateStr containsString:@":"]){
        formatStr = kFormat_date_one;
        
    }
    else if (![dateStr containsString:@"-"] && ![dateStr containsString:@":"]){
        formatStr = kFormat_date_two;
        
    }
    else{
        NSLog(@"<%@>时间格式不对",dateStr);
        
    }
    //时间转时间戳的方法:
    NSString * timestamp = [dateStr toTimeDateWithFormatter:formatStr];
    return timestamp;
}


- (NSDate *)dateWithTimeStamp:(NSString *)timeStamp{
    NSDate * date = [self dateWithString:[timeStamp toTimeDate]];
    return date;
}


#pragma mark- -字符串转日期
- (NSDate *)dateWithString:(NSString *)dateString format:(NSString *)format{
    NSDateFormatter *formatter = [NSDateFormatter dateFormat:format];
    NSDate * date = [formatter dateFromString:dateString];
    return date;
}

- (NSDate *)dateWithString:(NSString *)dateString{
    NSDate * date = [self dateWithString:dateString format:kFormat_date];
    return date;
}


#pragma mark- -日期转字符串

- (NSString *)stringWithDate:(NSDate *)date format:(NSString *)format{
    NSDateFormatter *formatter = [NSDateFormatter dateFormat:format];
    NSString *dateStr = [formatter stringFromDate:date];
    return dateStr;
    
}

- (NSString *)stringWithDate:(NSDate *)date{
    NSString * dateStr = [self stringWithDate:date format:kFormat_date];;
    return dateStr;
}

#pragma mark - -时间戳

- (NSString *)toTimestampMonth{
    NSString * dateStr = (NSString *)self;
    
    NSString * tmp = @"01 00:00:00";//后台接口时间戳不要时分秒
    dateStr = [dateStr stringByReplacingCharactersInRange:NSMakeRange(dateStr.length - tmp.length, tmp.length) withString:tmp];
    
    return [dateStr toTimestamp];
}

- (NSString *)toTimestampShort{
    NSString * dateStr = (NSString *)self;
    
    NSString * tmp = @" 00:00:00";//后台接口时间戳不要时分秒
    if (dateStr.length == 10) dateStr = [dateStr stringByAppendingString:tmp];
    dateStr = [dateStr stringByReplacingCharactersInRange:NSMakeRange(dateStr.length - tmp.length, tmp.length) withString:tmp];
    
    return [dateStr toTimestamp];
}

- (NSString *)toTimestampFull{
    NSString * dateStr = (NSString *)self;
    
    NSString * tmp = @" 23:59:59";//后台接口时间戳不要时分秒
    if (dateStr.length == 10) dateStr = [dateStr stringByAppendingString:tmp];
    dateStr = [dateStr stringByReplacingCharactersInRange:NSMakeRange(dateStr.length - tmp.length, tmp.length) withString:tmp];
    
    return [dateStr toTimestamp];
}

- (NSString *)timeByAddingDays:(id)days{
    NSParameterAssert([days isKindOfClass:[NSString class]] || [days isKindOfClass:[NSNumber class]]);

    if (days == nil) days = @0;
    NSString * dateStr = [self toTimeDate];
    NSDate * date = [self dateWithString:dateStr format:kFormat_date];
    NSString * newtime = [self stringWithDate:[date dateByAddingDays:[days integerValue]]];
    return newtime;
}


/**  比较两个日期,年月日, 时分秒 各相差多久
 *   先判断年 若year>0   则相差这么多年,后面忽略
 *   再判断月 若month>0  则相差这么多月,后面忽略
 *   再判断日 若day>0    则相差这么多天,后面忽略(0是今天,1是昨天,2是前天)
 *          若day=0    则是今天 返回相差的总时长
 */
+ (NSDateComponents *)compareCalendar:(NSDate *)date{
    
    NSDate * currtentDate = [NSDate date];
    
    // 比较日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    // 这个返回的是相差多久
    // 比如差12个小时, 无论在不在同一天 day都是0
    // NSDateComponents *components = [calendar components:unit fromDate:date toDate:currtentDate options:0];
    NSDateComponents *currentCalendar =[calendar components:unit fromDate:currtentDate];
    NSDateComponents *targetCalendar =[calendar components:unit fromDate:date];
    
    BOOL isYear = currentCalendar.year == targetCalendar.year;
    BOOL isMonth = currentCalendar.month == targetCalendar.month;
    BOOL isDay = currentCalendar.day == targetCalendar.day;
    
    NSDateComponents *components = [[NSDateComponents alloc] init];
    
    if (isYear) {
        if (isMonth) {
            if (isDay) {
                // 时分秒
                components = [calendar components:unit fromDate:date toDate:currtentDate options:0];
            }
            [components setValue:(currentCalendar.day - targetCalendar.day) forComponent:NSCalendarUnitDay];
        }
        [components setValue:(currentCalendar.month - targetCalendar.month) forComponent:NSCalendarUnitMonth];
    }
    [components setValue:(currentCalendar.year - targetCalendar.year) forComponent:NSCalendarUnitYear];
    return components;
}

/**  最近的日期*/
+ (NSString *)relativeDate:(NSDate *)date{
    
    // 日期格式化类
    NSDateFormatter *format = [NSDateFormatter dateFormat:kFormat_date];
    // 设置日期格式(y:年,M:月,d:日,H:时,m:分,s:秒)
    format.dateFormat = @"yyyy-MM-dd";
    
    NSDate * currtentDate = [NSDate date];
    NSDateComponents *components = [self compareCalendar:date];
    // 比较时间
    NSTimeInterval t = [currtentDate timeIntervalSinceDate:date];
    
    // 一分钟内
    if (t < 60) {
        return @"刚刚";
    }
    // 一小时内
    else if (t < 60 * 60) {
        return [NSString stringWithFormat:@"%@分钟前", @(t/60)];
    }
    // 今天
    else if (components.year == 0 && components.month == 0 && components.day == 0) {
        if (t/3600 > 3) {
            format.dateFormat = @"HH:mm";
            return [format stringFromDate:date];
        }
        return [NSString stringWithFormat:@"%@小时前", @(t/3600)];
    }
    // 昨天
    else if (components.year == 0 && components.month == 0 && components.day == 1) {
        format.dateFormat = @"昨天 HH:mm";
        return [format stringFromDate:date];
    }
    // 前天
    else if (components.year == 0 && components.month == 0 && components.day == 2) {
        return @"前天";
    }
    // 今年
    else if (components.year == 0) {
        format.dateFormat = @"MM-dd";
        return [format stringFromDate:date];
    }
    // 今年以前
    return [format stringFromDate:date];;
}

+ (NSString *)timeTipInfoFromTimestamp:(NSInteger)timestamp{
    
    NSDateFormatter * dateFormtter = [NSDateFormatter dateFormat:kFormat_date];
    
    NSDate * date = [NSDate dateWithTimeIntervalSince1970:timestamp];
    NSTimeInterval late =[date timeIntervalSince1970]*1;    //转记录的时间戳
    NSDate * dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval now = [dat timeIntervalSince1970]*1;   //获取当前时间戳
    NSString *timeString = @"";
    NSTimeInterval cha = now - late;
    // 发表在一小时之内
    if (cha/3600<1) {
        if (cha/60<1) {
            timeString = @"1";
        }
        else{
            timeString = [NSString stringWithFormat:@"%f", cha/60];
            timeString = [timeString substringToIndex:timeString.length-7];
        }
        timeString=[NSString stringWithFormat:@"%@分钟前", timeString];
    }
    // 在一小时以上24小以内
    else if (cha/3600>1&&cha/86400<1) {
        timeString = [NSString stringWithFormat:@"%f", cha/3600];
        timeString = [timeString substringToIndex:timeString.length-7];
        timeString=[NSString stringWithFormat:@"%@小时前", timeString];
    }
    // 发表在24以上10天以内
    else if (cha/86400>1&&cha/86400*3<1){
        //86400 = 60(分)*60(秒)*24(小时)   3天内
        timeString = [NSString stringWithFormat:@"%f", cha/86400];
        timeString = [timeString substringToIndex:timeString.length-7];
        timeString=[NSString stringWithFormat:@"%@天前", timeString];
    }
    // 发表时间大于10天
    else{
        [dateFormtter setDateFormat:@"yyyy-MM-dd"];
        timeString = [dateFormtter stringFromDate:date];
    }
    return timeString;
}

-(NSString *)compareCurrentTime{
    NSAssert([self isKindOfClass:[NSString class]] || [self isKindOfClass:[NSDate class]], @"NSString/NSDate");
    NSDate * compareDate = nil;
    if ([self isKindOfClass:[NSDate class]]) {
        compareDate = (NSDate *)self;
    }
    
    if ([self isKindOfClass:[NSString class]]) {
        compareDate = [self toDate];
    }
    
    NSTimeInterval  timeInterval = [compareDate timeIntervalSinceNow];
    timeInterval = -timeInterval;
    long temp = 0;
    NSString *result;
    if (timeInterval < 60) {
        result = [NSString stringWithFormat:@"刚刚"];
        
    }
    else if((temp = timeInterval/60) <60){
        result = [NSString stringWithFormat:@"%@分前",@(temp)];
        
    }
    else if((temp = temp/60) <24){
        result = [NSString stringWithFormat:@"%@小前",@(temp)];
        
    }
    else if((temp = temp/24) <30){
        result = [NSString stringWithFormat:@"%@天前",@(temp)];
        
    }
    else if((temp = temp/30) <12){
        result = [NSString stringWithFormat:@"%@月前",@(temp)];
        
    }
    else{
        temp = temp/12;
        result = [NSString stringWithFormat:@"%@年前",@(temp)];
        
    }
    return  result;
    
}

-(NSString *)compareCurrentTimeDays{
    NSAssert([self isKindOfClass:[NSString class]] || [self isKindOfClass:[NSDate class]], @"NSString/NSDate");
    NSDate * compareDate = nil;
    if ([self isKindOfClass:[NSDate class]]) {
        compareDate = (NSDate *)self;
    }
    
    if ([self isKindOfClass:[NSString class]]) {
        if (((NSString *)self).length >= 10) {
            compareDate = [self toDate];
            
        }else{
            return @"";
            
        }
    }
    
    //     NSTimeInterval time = [[NSDate date] timeIntervalSinceDate:oldDate];
    //     DDLog(@"time:%f",time/60/60/24);
    
    NSTimeInterval  timeInterval = [compareDate timeIntervalSinceNow];
    timeInterval = -timeInterval;
    long temp = 0;
    NSString *result;
    if (timeInterval < 60) {
        result = [NSString stringWithFormat:@"刚刚"];
        
    }
    else if((temp = timeInterval/60) <60){
        result = [NSString stringWithFormat:@"%@分前",@(temp)];
        
    }
    else if((temp = temp/60) <24){
        result = [NSString stringWithFormat:@"%@小前",@(temp)];
        
    }
    else{
        temp = temp/24;
        result = [NSString stringWithFormat:@"%@天前",@(temp)];
        
    }
    return  result;
    
}

-(NSString *)compareTimeInfo{
    NSAssert([self isKindOfClass:[NSString class]] || [self isKindOfClass:[NSDate class]], @"NSString/NSDate");
    NSDate * compareDate = nil;
    if ([self isKindOfClass:[NSDate class]]) {
        compareDate = (NSDate *)self;
    }
    
    if ([self isKindOfClass:[NSString class]]) {
        if (((NSString *)self).length >= 10) {
            compareDate = [self toDate];
            
        }else{
            return @"";
            
        }
    }
    NSDateFormatter *formatter = [NSDateFormatter dateFormat:kFormat_date];
    NSString * dateStr = [formatter stringFromDate:compareDate];
    
    NSString * timeNow = NSDate.date.now;
    
    NSString * dateInfo = dateStr;
    if ([[dateStr substringWithRange:NSMakeRange(0, 4)] isEqualToString:[timeNow substringWithRange:NSMakeRange(0, 4)]]) {
        dateInfo = [dateStr substringWithRange:NSMakeRange(5, 11)];
        
    }else{
        dateInfo = [dateStr substringWithRange:NSMakeRange(0, 15)];
        
    }
    return  dateInfo;
    
}


@end
