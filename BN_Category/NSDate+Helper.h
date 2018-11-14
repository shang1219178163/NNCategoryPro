//
//  NSDate+Helper.h
//  Location
//
//  Created by BIN on 2017/12/21.
//  Copyright © 2017年 Location. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "NSDateFormatter+Helper.h"

#define kTime_MINUTE    60

#define D_MINUTE        60
#define D_HOUR          3600
#define D_DAY           86400
#define D_WEEK          604800
#define D_YEAR          31556926

FOUNDATION_EXPORT NSString * const kFormat_date ;
FOUNDATION_EXPORT NSString * const kFormat_date_one ;
FOUNDATION_EXPORT NSString * const kFormat_date_two ;
FOUNDATION_EXPORT NSString * const kFormat_date_five ;

@interface NSDate (Helper)

//@property (class, nonatomic, strong, readonly) NSString *timeStamp;
//@property (class, nonatomic, strong, readonly) NSString *now;

@property (nonatomic, strong, readonly) NSString *timeStamp;
@property (nonatomic, strong, readonly) NSString *now;

- (NSDate *)localFromUTC;

/**
 *得到当前时间，yyyy-MM-dd HH:mm:ss
 */

+ (NSString *)getNowChinaTime;

- (NSString *)timeIntervalDescription;//距离当前的时间间隔描述

- (NSString *)minuteDescription;/*精确到分钟的日期描述*/

- (NSString *)formattedTime;

- (NSString *)formattedDateDescription;//格式化日期描述

- (double)timeIntervalSince1970InMilliSecond;

+ (NSDate *)dateWithTimeIntervalInMilliSecondSince1970:(double)timeIntervalInMilliSecond;

+ (NSString *)formattedTimeFromTimeInterval:(long long)time;

// Relative dates from the current date

+ (NSDate *)dateTomorrow;

+ (NSDate *)dateYesterday;

+ (NSDate *)dateWithDaysFromNow:(NSInteger)days;

+ (NSDate *)dateWithDaysBeforeNow:(NSInteger)days;

+ (NSDate *)dateWithHoursFromNow:(NSInteger)dHours;

+ (NSDate *)dateWithHoursBeforeNow:(NSInteger)dHours;

+ (NSDate *)dateWithMinutesFromNow:(NSInteger)dMinutes;

+ (NSDate *)dateWithMinutesBeforeNow:(NSInteger)dMinutes;

// Comparing dates

- (BOOL)isEqualToDateIgnoringTime: (NSDate*) aDate;

- (BOOL)isToday;

- (BOOL)isTomorrow;

- (BOOL)isYesterday;

- (BOOL)isSameWeekAsDate: (NSDate*) aDate;

- (BOOL)isThisWeek;

- (BOOL)isNextWeek;

- (BOOL)isLastWeek;

- (BOOL)isSameMonthAsDate: (NSDate*) aDate;

- (BOOL)isThisMonth;

- (BOOL)isSameYearAsDate: (NSDate*) aDate;

- (BOOL)isThisYear;

- (BOOL)isNextYear;

- (BOOL)isLastYear;

- (BOOL)isEarlierThanDate: (NSDate*) aDate;

- (BOOL)isLaterThanDate: (NSDate*) aDate;

- (BOOL)isInFuture;

- (BOOL)isInPast;

// Date roles

- (BOOL)isTypicallyWorkday;

- (BOOL)isTypicallyWeekend;

// Adjusting dates

- (NSDate *)dateByAddingDays: (NSInteger) dDays;

- (NSDate *)dateBySubtractingDays: (NSInteger) dDays;

- (NSDate *)dateByAddingHours: (NSInteger) dHours;

- (NSDate *)dateBySubtractingHours: (NSInteger) dHours;

- (NSDate *)dateByAddingMinutes: (NSInteger) dMinutes;

- (NSDate *)dateBySubtractingMinutes: (NSInteger) dMinutes;

- (NSDate *)dateAtStartOfDay;

// Retrieving intervals

- (NSInteger) minutesAfterDate: (NSDate*) aDate;

- (NSInteger) minutesBeforeDate: (NSDate*) aDate;

- (NSInteger) hoursAfterDate: (NSDate*) aDate;

- (NSInteger) hoursBeforeDate: (NSDate*) aDate;

- (NSInteger) daysAfterDate: (NSDate*) aDate;

- (NSInteger) daysBeforeDate: (NSDate*) aDate;

- (NSInteger)distanceInDaysToDate:(NSDate*)anotherDate;

// Decomposing dates

@property (readonly) NSInteger nearestHour;

@property (readonly) NSInteger hour;

@property (readonly) NSInteger minute;

@property (readonly) NSInteger seconds;

@property (readonly) NSInteger day;

@property (readonly) NSInteger month;

@property (readonly) NSInteger week;

@property (readonly) NSInteger weekday;

@property (readonly) NSInteger weekdayOrdinal;// e.g. 2nd Tuesday of the month == 2

@property (readonly) NSInteger year;

@property (readonly) NSDateComponents *components;

@end
