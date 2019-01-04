//
//  +Helper.m
//  Location
//
//  Created by BIN on 2017/12/21.
//  Copyright © 2017年 Location. All rights reserved.
//

#import "NSDate+Helper.h"

#import "NSObject+Date.h"

#import "BN_GeneralConst.h"

#define kDateComponents (NSCalendarUnitYear| NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekdayOrdinal | NSCalendarUnitWeekday)

const NSInteger kDate_second = 1 ;
const NSInteger kDate_minute = 60 ;
const NSInteger kDate_hour = 3600 ;
const NSInteger kDate_day = 86400 ;
const NSInteger kDate_week = 604800 ;
const NSInteger kDate_year = 31556926;

NSString * const kFormat_date = @"yyyy-MM-dd HH:mm:ss";
NSString * const kFormat_date_one = @"yyyy-MM-dd";
NSString * const kFormat_date_two = @"yyyyMMdd";
NSString * const kFormat_date_five = @"yyyyMMddHHmmss";

@implementation NSDate(Helper)

static NSArray * _dayList = nil;
static NSArray * _monthList = nil;
static NSArray * _weekList = nil;

+ (NSArray *)dayList{
    if (!_dayList) {
        _dayList = [kDes_day componentsSeparatedByString:@","];
    }
    return _dayList;
}

+ (NSArray *)monthList{
    if (!_monthList) {
        _monthList = [kDes_month componentsSeparatedByString:@","];
    }
    return _monthList;
}

+ (NSArray *)weekList{
    if (!_weekList) {
        _weekList = [kDes_week componentsSeparatedByString:@","];
    }
    return _weekList;
}

/**
 *  获取时间的时间戳
 */
-(NSString *)timeStamp{
   return [(NSDate *)self toTimestamp];
}

/**
 *  获取当前时间
 */
-(NSString *)now{
    NSDateFormatter *formatter = [NSDateFormatter dateFormat:kFormat_date];
    NSString * dateStr = [formatter stringFromDate:self];
    return dateStr;
}

- (NSDate *)localFromUTC{

    NSDate *soureDate = self;
    //设置源日期时区
    NSTimeZone * sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];//或GMT
    //设置转换后的目标日期时区
    NSTimeZone * destinationTimeZone = [NSTimeZone localTimeZone];
    //得到源日期与世界标准时间的偏移量
    NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:soureDate];
    //目标日期与本地时区的偏移量
    NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:soureDate];
    //得到时间偏移量的差值
    NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
    //转为现在时间
    NSDate * destinationDate = [[NSDate alloc] initWithTimeInterval:interval sinceDate:soureDate];
    return destinationDate;
}


+(NSString *)getNowChinaTime {
    
    NSDate*date = NSDate.date;
    
    //如果这里转换了就是格林威治时间
    //时区转换，取得系统时区，取得格林威治时间差秒
    //NSTimeInterval timeZoneOff set=[[NSTimeZone  systemTimeZone] secondsFromGMT];
    //date = [date  dateByAddingTimeInterva  l:timeZoneOff set];
    //格式化日期时间
    
    NSDateFormatter  *formatter = [NSDateFormatter dateFormat:kFormat_date];
    NSString* dateStr = [formatter stringFromDate:date];
    return dateStr;
    
}

/*距离当前的时间间隔描述*/

- (NSString *)timeIntervalDescription{
    
    NSTimeInterval timeInterval = -[self timeIntervalSinceNow];
    if(timeInterval <60) {
        return NSLocalizedString(@"NSDateCategory.text1",@"");
        
    } else if (timeInterval <3600) {
        return [NSString  stringWithFormat:NSLocalizedString(@"NSDateCategory.text2",@""), timeInterval /60];
        
    } else if (timeInterval <86400) {
        return [NSString stringWithFormat:NSLocalizedString(@"NSDateCategory.text3",@""), timeInterval /3600];
        
    } else if (timeInterval <2592000) {//30天内
        return [NSString  stringWithFormat:NSLocalizedString(@"NSDateCategory.text4",@""), timeInterval /86400];
        
    } else if (timeInterval <31536000) {//30天至1年内
        NSDateFormatter  *dateFormatter = [NSDateFormatter dateFormat:NSLocalizedString(@"NSDateCategory.text5",@"")];
        return [dateFormatter stringFromDate:  self ];
        
    } else {
        return [NSString stringWithFormat:NSLocalizedString(@"NSDateCategory.text6",@""), timeInterval /31536000];
        
    }
    
}

/*精确到分钟的日期描述*/

- (NSString *)minuteDescription{
    NSDateFormatter  *dateFormatter = [NSDateFormatter  dateFormat:kFormat_date];
    NSString *theDay = [dateFormatter stringFromDate:self];//日期的年月日
    NSString *currentDay = [dateFormatter stringFromDate:[NSDate date]];//当前年月日
    
    if([theDay isEqualToString:currentDay]) {//当天
        [dateFormatter setDateFormat :@"ah:mm"];
        return [dateFormatter stringFromDate:self ];
        
    }
    else if ([[dateFormatter  dateFromString:currentDay]timeIntervalSinceDate:[dateFormatter dateFromString:theDay]] ==86400) {//昨天
        [dateFormatter setDateFormat :@"ah:mm"];
        return [NSString  stringWithFormat:NSLocalizedString(@"NSDateCategory.text7", @'"'), [dateFormatter stringFromDate:  self ]];
        
    }
    else if ([[dateFormatter dateFromString:currentDay]timeIntervalSinceDate:[dateFormatter dateFromString:theDay]] <86400*7) {//间隔一周内
        [dateFormatter  setDateFormat :@"EEEE ah:mm"];
        return [dateFormatter stringFromDate:self ];
        
    }
    else{//以前
        [dateFormatter setDateFormat :@"yyyy-MM-dd ah:mm"];
        return [dateFormatter stringFromDate:  self ];
        
    }
    
}

/*标准时间日期描述*/

-(NSString *)formattedTime{
    NSDateFormatter  * formatter = [[NSDateFormatter alloc]init];
    [formatter   setDateFormat :@"YYYY-MM-dd"];
    
    NSString* dateNow = [formatter stringFromDate:NSDate.date];
    
    NSDateComponents *components = [[NSDateComponents alloc]init];
    
    [components setDay:[[dateNow substringWithRange:NSMakeRange(8,2)]intValue]];
    [components setMonth:[[dateNow substringWithRange:NSMakeRange(5,2)]intValue]];
    [components setYear:[[dateNow substringWithRange:NSMakeRange(0,4)]intValue]];
    
    NSCalendar *gregorian = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate *date = [gregorian dateFromComponents:components];//今天0点时间
    
    NSInteger hour = [self hoursAfterDate:date];
    NSDateFormatter *dateFormatter =nil;
    NSString *ret =@"";
    
    //hasAMPM==TURE为12小时制，否则为24小时制
    
    NSString*formatStringForHours = [NSDateFormatter dateFormatFromTemplate:@"j"options:0 locale:[NSLocale currentLocale]];
    NSRange containsA = [formatStringForHours rangeOfString:@"a"];
    BOOL hasAMPM = containsA.location!=NSNotFound;
    
    if(!hasAMPM) {//24小时制
        if(hour <=24&& hour >=0) {
            dateFormatter = [NSDateFormatter dateFormat:@"HH:mm"];
            
        } else if (hour <0&& hour >= -24) {
            dateFormatter = [NSDateFormatter dateFormat:NSLocalizedString(@"NSDateCategory.text8",@"")];
            
        } else {
            dateFormatter = [NSDateFormatter dateFormat:@"yyyy-MM-dd"];
            
        }
        
    } else {
        
        if(hour >=0&& hour <=6) {
            dateFormatter = [NSDateFormatter dateFormat:NSLocalizedString(@"NSDateCategory.text9",@"")];
            
        } else if (hour >6&& hour <=11) {
            dateFormatter = [NSDateFormatter dateFormat:NSLocalizedString(@"NSDateCategory.text10",@"")];
            
        } else if (hour >11&& hour <=17) {
            dateFormatter = [NSDateFormatter dateFormat:NSLocalizedString(@"NSDateCategory.text11",@"")];
            
        } else if (hour >17&& hour <=24) {
            dateFormatter = [NSDateFormatter dateFormat:NSLocalizedString(@"NSDateCategory.text12",@"")];
            
        } else if (hour <0&& hour >= -24){
            dateFormatter = [NSDateFormatter dateFormat:NSLocalizedString(@"NSDateCategory.text13",@"")];
            
        } else {
            dateFormatter = [NSDateFormatter dateFormat:@"yyyy-MM-dd"];
            
        }
    }
    
    ret = [dateFormatter stringFromDate:  self ];
    return ret;
    
}

/*格式化日期描述*/

- (NSString *)formattedDateDescription{
    NSDateFormatter  *dateFormatter = [[NSDateFormatter alloc ]init];
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    
    NSString *theDay = [dateFormatter stringFromDate:self];//日期的年月日
    NSString *currentDay = [dateFormatter stringFromDate:[NSDate date]];//当前年月日
    NSInteger  timeInterval = -[self timeIntervalSinceNow];
    
    if(timeInterval <60) {
        return NSLocalizedString(@"NSDateCategory.text1",@"");
        
    } else if (timeInterval <3600) {//1小时内
        return [NSString stringWithFormat:NSLocalizedString(@"NSDateCategory.text2",@""), timeInterval /60];
        
    } else if (timeInterval <21600) {//6小时内
        return [NSString stringWithFormat:NSLocalizedString(@"NSDateCategory.text3",@""), timeInterval /3600];
        
    } else if ([theDay isEqualToString:currentDay]) {//当天
        dateFormatter.dateFormat = @"HH:mm";
        return [NSString stringWithFormat:NSLocalizedString(@"NSDateCategory.text14",@""), [dateFormatter stringFromDate:self ]];
        
    } else if ([[dateFormatter dateFromString:currentDay]timeIntervalSinceDate:[dateFormatter dateFromString:theDay]] == 86400) {//昨天
        dateFormatter.dateFormat = @"HH:mm";
        return [NSString  stringWithFormat:NSLocalizedString(@"NSDateCategory.text7",@""), [dateFormatter stringFromDate:self]];
        
    } else {//以前
        dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm";
        return [dateFormatter stringFromDate:self];
        
    }
}

- (double)timeIntervalSince1970InMilliSecond {
    double ret = [self  timeIntervalSince1970] *1000;
    return ret;
    
}

+ (NSDate*)dateWithTimeIntervalInMilliSecondSince1970:(double)timeIntervalInMilliSecond {
    
    NSDate *ret = nil;
    double timeInterval = timeIntervalInMilliSecond;
    if(timeIntervalInMilliSecond >140000000000) {
        timeInterval = timeIntervalInMilliSecond /1000;
        
    }
    ret = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    return ret;
    
}

+ (NSString *)formattedTimeFromTimeInterval:(long long)time{
    return [[NSDate dateWithTimeIntervalInMilliSecondSince1970:time]formattedTime];
    
}

#pragma mark Relative Dates

+ (NSDate *)dateWithDaysFromNow: (NSInteger )days{
    return [NSDate.date dateByAddDays:days];
    
}

+ (NSDate *)dateWithDaysBeforeNow:(NSInteger )days{
    return [NSDate.date dateBySubtractDays:days];
    
}

+ (NSDate *)dateTomorrow{
    return [NSDate dateWithDaysFromNow:1];
    
}

+ (NSDate *)dateYesterday{
    return [NSDate  dateWithDaysBeforeNow:1];
    
}

+ (NSDate *)dateWithHoursFromNow:(NSInteger )dHours{
    
    NSTimeInterval aTimeInterval = NSDate.date.timeIntervalSinceReferenceDate +kDate_hour* dHours;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
    
}

+ (NSDate *)dateWithHoursBeforeNow:(NSInteger )dHours{
    NSTimeInterval aTimeInterval = NSDate.date.timeIntervalSinceReferenceDate -kDate_hour* dHours;
    NSDate*newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
    
}

+ (NSDate *)dateWithMinutesFromNow:(NSInteger )dMinutes{
    NSTimeInterval aTimeInterval = NSDate.date.timeIntervalSinceReferenceDate +kDate_minute* dMinutes;
    NSDate*newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
    
}

+ (NSDate *)dateWithMinutesBeforeNow:(NSInteger )dMinutes{
    NSTimeInterval aTimeInterval = NSDate.date.timeIntervalSinceReferenceDate -kDate_minute* dMinutes;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
    
}

#pragma mark Comparing Dates

- (BOOL)isEqualToDateIgnoringTime:(NSDate *)aDate{
    NSDateComponents *components1 = [NSCalendar.currentCalendar components:kDateComponents fromDate:self ];
    NSDateComponents *components2 = [NSCalendar.currentCalendar components:kDateComponents fromDate:aDate];
    return ((components1.year== components2.year) && (components1.month== components2.month) && (components1.day== components2.day));
    
}

- (BOOL)isToday{
    return [self isEqualToDateIgnoringTime:NSDate.date];
}

- (BOOL)isTomorrow{
    return [self isEqualToDateIgnoringTime:[NSDate dateTomorrow]];
    
}

- (BOOL)isYesterday{
    return [self isEqualToDateIgnoringTime:[NSDate dateYesterday]];
    
}

// This hard codes the assumption that a week is 7 days

- (BOOL)isSameWeekAsDate:(NSDate*) aDate{
    NSDateComponents *components1 = [NSCalendar.currentCalendar components:kDateComponents fromDate:self ];

    NSDateComponents *components2 = [NSCalendar.currentCalendar components:kDateComponents fromDate:aDate];

    // Must be same week. 12/31 and 1/1 will both be week "1" if they are in the same week

    if(components1.weekOfYear!= components2.weekOfYear)return NO;

    // Must have a time interval under 1 week. Thanks @aclark
    return (fabs([self timeIntervalSinceDate:aDate]));
       
}
       
- (BOOL)isThisWeek{
    return [self isSameWeekAsDate:NSDate.date];

}

- (BOOL)isNextWeek{
    NSTimeInterval aTimeInterval = NSDate.date.timeIntervalSinceReferenceDate +kDate_week;
    NSDate*newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];

    return [self isSameWeekAsDate:newDate];

}

- (BOOL)isLastWeek{
    NSTimeInterval aTimeInterval = NSDate.date.timeIntervalSinceReferenceDate -kDate_week;

    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return [self isSameWeekAsDate:newDate];

}

// Thanks, mspasov
- (BOOL)isSameMonthAsDate:(NSDate *)aDate{
    NSDateComponents *components1 = [NSCalendar.currentCalendar components:NSCalendarUnitYear|NSCalendarUnitMonth fromDate:self ];
    NSDateComponents *components2 = [NSCalendar.currentCalendar components:NSCalendarUnitYear|NSCalendarUnitMonth fromDate:aDate];

    return ((components1.month== components2.month) &&(components1.year== components2.year));

}

- (BOOL)isThisMonth{
    return [self isSameMonthAsDate:NSDate.date];

}

- (BOOL)isSameYearAsDate:(NSDate *)aDate{
    NSDateComponents *components1 = [NSCalendar.currentCalendar components:NSCalendarUnitYear fromDate:self ];
    NSDateComponents *components2 = [NSCalendar.currentCalendar components:NSCalendarUnitYear fromDate:aDate];
    return (components1.year== components2.year);

}

- (BOOL)isThisYear{
    return [self isSameYearAsDate:NSDate.date];

}

- (BOOL)isNextYear{
    NSDateComponents *components1 = [NSCalendar.currentCalendar components:NSCalendarUnitYear fromDate:self ];
    NSDateComponents *components2 = [NSCalendar.currentCalendar components:NSCalendarUnitYear fromDate:NSDate.date];
    return (components1.year== (components2.year+1));

}

- (BOOL)isLastYear{
    NSDateComponents *components1 = [NSCalendar.currentCalendar components:NSCalendarUnitYear fromDate:self ];
    NSDateComponents *components2 = [NSCalendar.currentCalendar components:NSCalendarUnitYear fromDate:NSDate.date];
    return (components1.year== (components2.year-1));

}

- (BOOL)isEarlierThanDate:(NSDate *)aDate{
    return ([self compare:aDate] ==NSOrderedAscending);

}

- (BOOL)isLaterThanDate:(NSDate *)aDate{
    return ([self compare:aDate] ==NSOrderedDescending);

}

- (BOOL)isInFuture{
    return ([self isLaterThanDate:NSDate.date]);

}

- (BOOL)isInPast{
    return ([self isEarlierThanDate:NSDate.date]);
}

#pragma mark Roles

- (BOOL)isTypicallyWeekend{
    NSDateComponents *components = [NSCalendar.currentCalendar components:NSCalendarUnitWeekday fromDate:self];
    if((components.weekday == 1) ||  (components.weekday == 7))return YES;
    return NO;
}

- (BOOL)isTypicallyWorkday{
    return ![self isTypicallyWeekend];

}

#pragma mark Adjusting Dates

- (NSDate *)dateByAddingDay:(NSInteger)day hour:(NSInteger)hour minute:(NSInteger)minute second:(NSInteger)second{
    NSTimeInterval aTimeInterval = self.timeIntervalSinceReferenceDate +kDate_day*day + kDate_hour*hour + kDate_minute*minute + kDate_second*second;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

- (NSDate *)dateByAddDays:(NSInteger) dDays{
    return [self dateByAddingDay:dDays hour:0 minute:0 second:0];;
}

- (NSDate *)dateBySubtractDays:(NSInteger) dDays{
    return [self dateByAddingDay:(dDays * -1) hour:0 minute:0 second:0];;
}

- (NSDate *)dateByAddHours:(NSInteger )dHours{
    return [self dateByAddingDay:0 hour:dHours minute:0 second:0];;
}

- (NSDate *)dateBySubtractHours:(NSInteger )dHours{
    return [self dateByAddingDay:0 hour:(dHours * -1) minute:0 second:0];;
}

- (NSDate *)dateByAddMinutes:(NSInteger )dMinutes{
    return [self dateByAddingDay:0 hour:0 minute:dMinutes second:0];;
}

- (NSDate *)dateBySubtractMinutes:(NSInteger)dMinutes{
    return [self dateByAddingDay:0 hour:0 minute:(dMinutes * -1) second:0];;
}

- (NSDate *)dateAfterHour:(NSInteger)hour minute:(NSInteger)minute second:(NSInteger)second{
    NSDateComponents *components = [NSCalendar.currentCalendar components:NSUIntegerMax fromDate:self];
    components.hour     =   hour;
    components.minute   =   minute;
    components.second   =   second;
    return [NSCalendar.currentCalendar dateFromComponents:components];
    
//    NSTimeInterval ts = [[NSCalendar.currentCalendar dateFromComponents:components] timeIntervalSince1970];
//    return [NSDate dateWithTimeIntervalSince1970:ts];
}

- (NSDate *)dateAtStartOfDay{
    return [self dateAfterHour:0 minute:0 second:0];
}


- (NSDateComponents *)componentsWithOffsetFromDate:(NSDate *)aDate{
    NSDateComponents  *dTime = [NSCalendar.currentCalendar components:kDateComponents fromDate:aDate toDate:self options:0];
    return dTime;
}

#pragma mark Retrieving Intervals

- (NSInteger)minutesAfterDate:(NSDate *)aDate{
    NSTimeInterval ti = [self timeIntervalSinceDate:aDate];
    return (NSInteger ) (ti /kDate_minute);
}

- (NSInteger)minutesBeforeDate:(NSDate *)aDate{
    NSTimeInterval ti = [aDate timeIntervalSinceDate:self ];
    return (NSInteger)(ti /kDate_minute);
}

- (NSInteger)hoursAfterDate:(NSDate *)aDate{
    NSTimeInterval ti = [self timeIntervalSinceDate:aDate];
    return (NSInteger)(ti /kDate_hour);
}

- (NSInteger)hoursBeforeDate:(NSDate *)aDate{
    NSTimeInterval ti = [aDate timeIntervalSinceDate:self ];
    return (NSInteger) (ti /kDate_hour);
}

- (NSInteger)daysAfterDate:(NSDate *)aDate{
    NSTimeInterval ti = [self timeIntervalSinceDate:aDate];
    return (NSInteger) (ti /kDate_day);
}

- (NSInteger)daysBeforeDate:(NSDate *)aDate{
    NSTimeInterval ti = [aDate timeIntervalSinceDate:self ];
    return (NSInteger) (ti /kDate_day);
}

- (NSInteger)distanceInDaysToDate:(NSDate*)anotherDate{
    NSCalendar *gregorianCalendar = [[NSCalendar alloc ]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorianCalendar components:NSCalendarUnitDay fromDate:self toDate:anotherDate options:0];
    return components.day;

}

#pragma mark -- Decomposing Dates

- (NSInteger)nearestHour{
    NSTimeInterval aTimeInterval = NSDate.date.timeIntervalSinceReferenceDate +kDate_minute*30;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    NSDateComponents *components = [NSCalendar.currentCalendar components:NSCalendarUnitHour fromDate:newDate];
    return components.hour;
}

- (NSDateComponents *)components{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
//    calendar.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    calendar.locale = [NSLocale localeWithLocaleIdentifier:NSLocaleIdentifier];
    NSDateComponents *components = [calendar components:kDateComponents fromDate:self];
    return components;
}

- (NSInteger)hour{
    return self.components.hour;
}

- (NSInteger)minute{
    return self.components.minute;
}

- (NSInteger)seconds{
    return self.components.second;
}

- (NSInteger)day{
    return self.components.day;
}

- (NSInteger)month{
    return self.components.month;
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

- (NSString *)weekdayDes{
    return NSDate.weekList[self.weekdayOrdinal - 1];
}

- (NSInteger)year{
    return self.components.year;
}


           
@end
