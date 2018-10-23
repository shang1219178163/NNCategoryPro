//
//  +Helper.m
//  Location
//
//  Created by BIN on 2017/12/21.
//  Copyright © 2017年 Location. All rights reserved.
//

#import "NSDate+Helper.h"

#import "NSObject+Date.h"

#define kDATE_Components (NSCalendarUnitYear| NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekdayOrdinal | NSCalendarUnitWeekday)

#define kCalendar_Current [NSCalendar currentCalendar]

@implementation NSDate(Helper)

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


+(NSString*)getNowChinaTime {
    
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

- (NSString*)timeIntervalDescription{
    
    NSTimeInterval timeInterval = -[self timeIntervalSinceNow];
    if(timeInterval <60) {
        return NSLocalizedString(@"NSDateCategory.text1",@"");
        
    }else if (timeInterval <3600) {
        return [NSString  stringWithFormat:NSLocalizedString(@"NSDateCategory.text2",@""), timeInterval /60];
        
    }else if (timeInterval <86400) {
        return [NSString stringWithFormat:NSLocalizedString(@"NSDateCategory.text3",@""), timeInterval /3600];
        
    }else if (timeInterval <2592000) {//30天内
        return [NSString  stringWithFormat:NSLocalizedString(@"NSDateCategory.text4",@""), timeInterval /86400];
        
    }else if (timeInterval <31536000) {//30天至1年内
        NSDateFormatter  *dateFormatter = [NSDateFormatter dateFormat:NSLocalizedString(@"NSDateCategory.text5",@"")];
        return [dateFormatter stringFromDate:  self ];
        
    }else{
        return [NSString stringWithFormat:NSLocalizedString(@"NSDateCategory.text6",@""), timeInterval /31536000];
        
    }
    
}

/*精确到分钟的日期描述*/

- (NSString*)minuteDescription{
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

-(NSString*)formattedTime{
    NSDateFormatter  * formatter = [[NSDateFormatter  alloc ]init];
    [formatter   setDateFormat :@"YYYY-MM-dd"];
    
    NSString* dateNow = [formatter stringFromDate:  [NSDate  date]];
    
    NSDateComponents*components = [[NSDateComponents alloc ]init];
    
    [components setDay:[[dateNow substringWithRange:NSMakeRange(8,2)]intValue]];
    [components setMonth:[[dateNow substringWithRange:NSMakeRange(5,2)]intValue]];
    [components setYear:[[dateNow substringWithRange:NSMakeRange(0,4)]intValue]];
    
    NSCalendar *gregorian = [[NSCalendar alloc ]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate *date = [gregorian dateFromComponents:components];//今天0点时间
    
    NSInteger  hour = [self hoursAfterDate:date];
    NSDateFormatter  *dateFormatter =nil;
    NSString*ret =@"";
    
    //hasAMPM==TURE为12小时制，否则为24小时制
    
    NSString*formatStringForHours = [NSDateFormatter  dateFormatFromTemplate:@"j"options:0 locale:[NSLocale currentLocale]];
    NSRange containsA = [formatStringForHours rangeOfString:@"a"];
    BOOL hasAMPM = containsA.location!=NSNotFound;
    
    if(!hasAMPM) {//24小时制
        if(hour <=24&& hour >=0) {
            dateFormatter = [NSDateFormatter dateFormat:@"HH:mm"];
            
        }else if (hour <0&& hour >= -24) {
            dateFormatter = [NSDateFormatter dateFormat:NSLocalizedString(@"NSDateCategory.text8",@"")];
            
        }else{
            dateFormatter = [NSDateFormatter dateFormat:@"yyyy-MM-dd"];
            
        }
        
    }else{
        
        if(hour >=0&& hour <=6) {
            dateFormatter = [NSDateFormatter dateFormat:NSLocalizedString(@"NSDateCategory.text9",@"")];
            
        }else if (hour >6&& hour <=11) {
            dateFormatter = [NSDateFormatter dateFormat:NSLocalizedString(@"NSDateCategory.text10",@"")];
            
        }else if (hour >11&& hour <=17) {
            dateFormatter = [NSDateFormatter dateFormat:NSLocalizedString(@"NSDateCategory.text11",@"")];
            
        }else if (hour >17&& hour <=24) {
            dateFormatter = [NSDateFormatter dateFormat:NSLocalizedString(@"NSDateCategory.text12",@"")];
            
        }else if (hour <0&& hour >= -24){
            dateFormatter = [NSDateFormatter dateFormat:NSLocalizedString(@"NSDateCategory.text13",@"")];
            
        }else{
            dateFormatter = [NSDateFormatter dateFormat:@"yyyy-MM-dd"];
            
        }
    }
    
    ret = [dateFormatter stringFromDate:  self ];
    return ret;
    
}

/*格式化日期描述*/

- (NSString*)formattedDateDescription{
    NSDateFormatter  *dateFormatter = [[NSDateFormatter alloc ]init];
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    
    NSString *theDay = [dateFormatter stringFromDate:self];//日期的年月日
    NSString *currentDay = [dateFormatter stringFromDate:[NSDate date]];//当前年月日
    NSInteger  timeInterval = -[self timeIntervalSinceNow];
    
    if(timeInterval <60) {
        return NSLocalizedString(@"NSDateCategory.text1",@"");
        
    }else if (timeInterval <3600) {//1小时内
        return [NSString stringWithFormat:NSLocalizedString(@"NSDateCategory.text2",@""), timeInterval /60];
        
    }else if (timeInterval <21600) {//6小时内
        return [NSString stringWithFormat:NSLocalizedString(@"NSDateCategory.text3",@""), timeInterval /3600];
        
    }else if ([theDay isEqualToString:currentDay]) {//当天
        dateFormatter.dateFormat = @"HH:mm";
        return [NSString stringWithFormat:NSLocalizedString(@"NSDateCategory.text14",@""), [dateFormatter stringFromDate:self ]];
        
    }else if ([[dateFormatter dateFromString:currentDay]timeIntervalSinceDate:[dateFormatter dateFromString:theDay]] == 86400) {//昨天
        dateFormatter.dateFormat = @"HH:mm";
        return [NSString  stringWithFormat:NSLocalizedString(@"NSDateCategory.text7",@""), [dateFormatter stringFromDate:self]];
        
    }else{//以前
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

+ (NSString*)formattedTimeFromTimeInterval:(long long)time{
    return [[NSDate dateWithTimeIntervalInMilliSecondSince1970:time]formattedTime];
    
}

#pragma mark Relative Dates

+ (NSDate*) dateWithDaysFromNow: (NSInteger  ) days{
    return [[NSDate  date]dateByAddingDays:days];
    
}

+ (NSDate*) dateWithDaysBeforeNow: (NSInteger  ) days{
    return [[NSDate  date]dateBySubtractingDays:days];
    
}

+ (NSDate*) dateTomorrow{
    return [NSDate  dateWithDaysFromNow:1];
    
}

+ (NSDate*) dateYesterday{
    return [NSDate  dateWithDaysBeforeNow:1];
    
}

+ (NSDate*) dateWithHoursFromNow: (NSInteger  ) dHours{
    
    NSTimeInterval aTimeInterval = [[NSDate  date]timeIntervalSinceReferenceDate] +D_HOUR* dHours;
    
    NSDate *newDate = [NSDate  dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
    
}

+ (NSDate*) dateWithHoursBeforeNow: (NSInteger  ) dHours{
    NSTimeInterval aTimeInterval = [[NSDate  date]timeIntervalSinceReferenceDate] -D_HOUR* dHours;
    
    NSDate*newDate = [NSDate  dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
    
}

+ (NSDate*) dateWithMinutesFromNow: (NSInteger  ) dMinutes{
    NSTimeInterval aTimeInterval = [[NSDate  date]timeIntervalSinceReferenceDate] +D_MINUTE* dMinutes;
    
    NSDate*newDate = [NSDate  dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
    
}

+ (NSDate*) dateWithMinutesBeforeNow: (NSInteger  ) dMinutes{
    NSTimeInterval aTimeInterval = [[NSDate  date]timeIntervalSinceReferenceDate] -D_MINUTE* dMinutes;
    
    NSDate *newDate = [NSDate  dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
    
}

#pragma mark Comparing Dates

- (BOOL) isEqualToDateIgnoringTime: (NSDate*) aDate{
    NSDateComponents *components1 = [kCalendar_Current components:kDATE_Components fromDate:self ];
    NSDateComponents *components2 = [kCalendar_Current components:kDATE_Components fromDate:aDate];
    return ((components1.year== components2.year) && (components1.month== components2.month) && (components1.day== components2.day));
    
}

- (BOOL) isToday{
    return [self isEqualToDateIgnoringTime:[NSDate  date]];
    
}

- (BOOL) isTomorrow{
    return [self isEqualToDateIgnoringTime:[NSDate  dateTomorrow]];
    
}

- (BOOL) isYesterday{
    return [self isEqualToDateIgnoringTime:[NSDate  dateYesterday]];
    
}

// This hard codes the assumption that a week is 7 days

- (BOOL) isSameWeekAsDate:(NSDate*) aDate{
    NSDateComponents*components1 = [kCalendar_Current components:kDATE_Components fromDate:self ];

    NSDateComponents*components2 = [kCalendar_Current components:kDATE_Components fromDate:aDate];

    // Must be same week. 12/31 and 1/1 will both be week "1" if they are in the same week

    if(components1.weekOfYear!= components2.weekOfYear)return NO;

    // Must have a time interval under 1 week. Thanks @aclark
    return (fabs([self timeIntervalSinceDate:aDate]));
       
}
       
- (BOOL) isThisWeek{
    return [self isSameWeekAsDate:[NSDate  date]];

}

- (BOOL) isNextWeek{
    NSTimeInterval aTimeInterval = [[NSDate  date]timeIntervalSinceReferenceDate] +D_WEEK;
    NSDate*newDate = [NSDate  dateWithTimeIntervalSinceReferenceDate:aTimeInterval];

    return [self isSameWeekAsDate:newDate];

}

- (BOOL) isLastWeek{
    NSTimeInterval aTimeInterval = [[NSDate  date]timeIntervalSinceReferenceDate] -D_WEEK;

    NSDate *newDate = [NSDate  dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return [self isSameWeekAsDate:newDate];

}

// Thanks, mspasov
- (BOOL) isSameMonthAsDate: (NSDate*) aDate{
    NSDateComponents*components1 = [kCalendar_Current components:NSCalendarUnitYear|NSCalendarUnitMonth fromDate:self ];
    NSDateComponents*components2 = [kCalendar_Current components:NSCalendarUnitYear|NSCalendarUnitMonth fromDate:aDate];

    return ((components1.month== components2.month) &&(components1.year== components2.year));

}

- (BOOL) isThisMonth{
    return [self isSameMonthAsDate:[NSDate  date]];

}

- (BOOL) isSameYearAsDate: (NSDate*) aDate{
    NSDateComponents*components1 = [kCalendar_Current components:NSCalendarUnitYear fromDate:self ];

    NSDateComponents*components2 = [kCalendar_Current components:NSCalendarUnitYear fromDate:aDate];
    return (components1.year== components2.year);

}

- (BOOL) isThisYear{
    return [self isSameYearAsDate:[NSDate  date]];

}

- (BOOL) isNextYear{
    NSDateComponents*components1 = [kCalendar_Current components:NSCalendarUnitYear fromDate:self ];
    NSDateComponents*components2 = [kCalendar_Current components:NSCalendarUnitYear fromDate:[NSDate  date]];

    return (components1.year== (components2.year+1));

}

- (BOOL) isLastYear{
    NSDateComponents*components1 = [kCalendar_Current components:NSCalendarUnitYear fromDate:self ];
    NSDateComponents*components2 = [kCalendar_Current components:NSCalendarUnitYear fromDate:[NSDate  date]];

    return (components1.year== (components2.year-1));

}

- (BOOL) isEarlierThanDate: (NSDate*) aDate{
    return ([self compare:aDate] ==NSOrderedAscending);

}

- (BOOL) isLaterThanDate: (NSDate*) aDate{
    return ([self compare:aDate] ==NSOrderedDescending);

}

- (BOOL) isInFuture{
    return ([self isLaterThanDate:[NSDate  date]]);

}

- (BOOL) isInPast{
    return ([self isEarlierThanDate:[NSDate  date]]);

}

#pragma mark Roles

- (BOOL) isTypicallyWeekend{
    NSDateComponents*components = [kCalendar_Current components:NSCalendarUnitWeekday fromDate:self ];

    if((components.weekday == 1) ||  (components.weekday == 7))return YES;
    return NO;

}

- (BOOL) isTypicallyWorkday{
    return ![self isTypicallyWeekend];

}

#pragma mark Adjusting Dates

- (NSDate *) dateByAddingDays:(NSInteger) dDays{
    NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] +D_DAY* dDays;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;

}

- (NSDate *) dateBySubtractingDays:(NSInteger) dDays{
    return [self dateByAddingDays: (dDays * -1)];

}

- (NSDate *) dateByAddingHours: (NSInteger  ) dHours{
    NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] +D_HOUR* dHours;
    NSDate *newDate = [NSDate  dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;

}

- (NSDate *) dateBySubtractingHours: (NSInteger  ) dHours{
    return [self dateByAddingHours: (dHours * -1)];

}

- (NSDate *) dateByAddingMinutes: (NSInteger  ) dMinutes{
    NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] +D_MINUTE* dMinutes;

    NSDate *newDate = [NSDate  dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;

}

- (NSDate *) dateBySubtractingMinutes: (NSInteger  ) dMinutes{
    return [self dateByAddingMinutes: (dMinutes * -1)];

}

- (NSDate *) dateAtStartOfDay{
    NSDateComponents*components = [kCalendar_Current components:kDATE_Components fromDate:self ];

    components.hour     =   0;
    components.minute   =   0;
    components.second   =   0;

    return [kCalendar_Current dateFromComponents:components];

}

- (NSDateComponents *) componentsWithOffsetFromDate: (NSDate*) aDate{
    NSDateComponents  *dTime = [kCalendar_Current components:kDATE_Components fromDate:aDate toDate:self options:0];
    return dTime;

}

#pragma mark Retrieving Intervals

- (NSInteger) minutesAfterDate: (NSDate*) aDate{
    NSTimeInterval ti = [self timeIntervalSinceDate:aDate];
    return (NSInteger ) (ti /D_MINUTE);

}

- (NSInteger) minutesBeforeDate: (NSDate*) aDate{
    NSTimeInterval ti = [aDate timeIntervalSinceDate:self ];
    return (NSInteger  ) (ti /D_MINUTE);

}

- (NSInteger) hoursAfterDate: (NSDate*) aDate{
    NSTimeInterval ti = [self timeIntervalSinceDate:aDate];
    return (NSInteger  ) (ti /D_HOUR);

}

- (NSInteger) hoursBeforeDate: (NSDate*) aDate{
    NSTimeInterval ti = [aDate timeIntervalSinceDate:self ];
    return (NSInteger) (ti /D_HOUR);

}

- (NSInteger) daysAfterDate: (NSDate*) aDate{
    NSTimeInterval ti = [self timeIntervalSinceDate:aDate];
    return (NSInteger) (ti /D_DAY);

}

- (NSInteger) daysBeforeDate: (NSDate*) aDate{
    NSTimeInterval ti = [aDate timeIntervalSinceDate:self ];
    return (NSInteger) (ti /D_DAY);

}

- (NSInteger)distanceInDaysToDate:(NSDate*)anotherDate{
    NSCalendar *gregorianCalendar = [[NSCalendar alloc ]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorianCalendar components:NSCalendarUnitDay fromDate:self toDate:anotherDate options:0];
    return components.day;

}

#pragma mark -- Decomposing Dates

- (NSInteger)nearestHour{
    NSTimeInterval aTimeInterval = [[NSDate  date]timeIntervalSinceReferenceDate] +D_MINUTE*30;
    NSDate *newDate = [NSDate  dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    NSDateComponents*components = [kCalendar_Current components:NSCalendarUnitHour fromDate:newDate];
    return components.hour;

}

- (NSDateComponents *)components{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
//    calendar.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    calendar.locale = [NSLocale localeWithLocaleIdentifier:NSLocaleIdentifier];
    NSDateComponents *components = [calendar components:kDATE_Components fromDate:self ];
    return components;
    
}

- (NSInteger)hour{
//    NSDateComponents *components = [kCalendar_Current components:kDATE_Components fromDate:self ];
//    return components.hour;
    return self.components.hour;

}

- (NSInteger)minute{
//    NSDateComponents *components = [kCalendar_Current components:kDATE_Components fromDate:self ];
//    return components.minute;
    return self.components.minute;

}

- (NSInteger)seconds{
//    NSDateComponents *components = [kCalendar_Current components:kDATE_Components fromDate:self ];
//    return components.second;
    return self.components.second;

}

- (NSInteger)day{
//    NSDateComponents *components = [kCalendar_Current components:kDATE_Components fromDate:self ];
//    return components.day;
    return self.components.day;

}

- (NSInteger)month{
//    NSDateComponents *components = [kCalendar_Current components:kDATE_Components fromDate:self ];
//    return components.month;
    return self.components.month;

}

- (NSInteger)week{
//    NSDateComponents*components = [kCalendar_Current components:kDATE_Components fromDate:self ];
//    return components.weekOfMonth;
    return self.components.weekOfMonth;

}

- (NSInteger)weekday{
//    NSDateComponents *components = [kCalendar_Current components:kDATE_Components fromDate:self];
//    return components.weekday;
    return self.components.weekday;

}

- (NSInteger)weekdayOrdinal{// e.g. 2nd Tuesday of the month is 2
//    NSDateComponents *components = [kCalendar_Current components:kDATE_Components fromDate:self ];
//    return components.weekdayOrdinal;
    return self.components.weekdayOrdinal;

}

- (NSInteger)year{
//    NSDateComponents *components = [kCalendar_Current components:kDATE_Components fromDate:self ];
//    return components.year;
    return self.components.year;

}


           
@end
