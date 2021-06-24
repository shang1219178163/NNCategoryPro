//
//  NSDate+Helper.h
//  Location
//
//  Created by BIN on 2017/12/21.
//  Copyright © 2017年 Shang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// 60s
FOUNDATION_EXPORT const NSInteger kDateMinute ;
/// 3600s
FOUNDATION_EXPORT const NSInteger kDateHour ;
/// 86400
FOUNDATION_EXPORT const NSInteger kDateDay ;
/// 604800
FOUNDATION_EXPORT const NSInteger kDateWeek ;
/// 31556926
FOUNDATION_EXPORT const NSInteger kDateYear ;

/// yyyy-MM-dd HH:mm:ss
FOUNDATION_EXPORT NSString * const kDateFormat ;
/// yyyy-MM-dd HH:mm
FOUNDATION_EXPORT NSString * const kDateFormatMinute ;
/// yyyy-MM-dd
FOUNDATION_EXPORT NSString * const kDateFormatDay ;
/// yyyy年M月
FOUNDATION_EXPORT NSString * const kDateFormatMonth_CH ;
/// yyyy年MM月dd日
FOUNDATION_EXPORT NSString * const kDateFormatDay_CH ;
/// yyyy-MM-dd 00:00:00
FOUNDATION_EXPORT NSString * const kDateFormatStart ;
/// yyyy-MM-dd 23:59:59
FOUNDATION_EXPORT NSString * const kDateFormatEnd ;
/// yyyyMMdd
FOUNDATION_EXPORT NSString * const kDateFormatTwo ;
/// yyyyMMddHHmmss
FOUNDATION_EXPORT NSString * const kDateFormatFive ;
/// EEE, dd MMM yyyy HH:mm:ss GMT
FOUNDATION_EXPORT NSString * const kDateFormatSix ;

@interface NSDate (Helper)

/// 本地时间(东八区时间)
@property(nonatomic, strong, readonly, class) NSDate *dateLocale;

@property(nonatomic, assign, readonly, class) NSTimeInterval timeZoneInterval;

///获取当前时间描述
@property(nonatomic, strong, readonly) NSString *now;
///获取当前时间戳
@property(nonatomic, strong, readonly) NSString *timeStamp;

@property(nonatomic, strong, readonly) NSString *timeStamp13;

@property(nonatomic, strong, readonly) NSDate *dateTomorrow;

@property(nonatomic, strong, readonly) NSDate *dateYesterday;

@property(nonatomic, strong, readonly) NSDateComponents *components;

@property(nonatomic, assign, readonly) NSInteger year;

@property(nonatomic, assign, readonly) NSInteger month;

@property(nonatomic, assign, readonly) NSInteger day;

@property(nonatomic, assign, readonly) NSInteger hour;

@property(nonatomic, assign, readonly) NSInteger minute;

@property(nonatomic, assign, readonly) NSInteger second;

@property(nonatomic, assign, readonly) NSInteger week;

@property(nonatomic, assign, readonly) NSInteger weekday;

@property(nonatomic, assign, readonly) NSInteger weekdayOrdinal;

@property(nonatomic, assign, readonly) BOOL isToday;

@property(nonatomic, assign, readonly) BOOL isTomorrow;

@property(nonatomic, assign, readonly) BOOL isYesterday;

@property(nonatomic, assign, readonly) BOOL isTypicallyWeekend;

@property(nonatomic, assign, readonly) BOOL isTypicallyWorkday;
///两时间之间的 NSDateComponents
- (NSDateComponents *)componentsToDate:(NSDate *)date;

///某个日期月份包含的天数
- (NSInteger)countOfDayInMonth;
///两时间之间的天数
- (NSInteger)countOfDayToDate:(NSDate *)date;

///某个日期鱼粉的第一天的值(默认顺序为“日一二三四五六”，1:星期日，2:星期一，依次类推)
-(NSInteger)firstWeekDay;

- (BOOL)isSameWeekAsDate:(NSDate *)date;
       
- (BOOL)isEarlierThanDate:(NSDate *)date;

- (BOOL)isLaterThanDate:(NSDate *)date;

- (NSDate *)addingDay:(NSInteger)day
                 hour:(NSInteger)hour
               minute:(NSInteger)minute
               second:(NSInteger)second;

- (NSDate *)dateByAddDays:(NSInteger)dDays;

@end



@interface NSDateFormatter (Helper)

/// 获取DateFormatter(默认格式)
+ (NSDateFormatter *)dateFormat:(NSString *)formatStr;

/// Date -> String
+ (NSString *)stringFromDate:(NSDate *)date fmt:(NSString *)format;

/// String -> Date
+ (nullable NSDate *)dateFromString:(NSString *)dateStr fmt:(NSString *)format;

/// 时间戳字符串 -> 日期字符串
+ (NSString *)stringFromInterval:(NSString *)interval fmt:(NSString *)format;

/// 日期字符串 -> 时间戳字符串
+ (NSString *)intervalFromDateStr:(NSString *)dateStr fmt:(NSString *)format;

/// 时间戳->NSDate
+ (NSDate *)dateFromInterval:(NSString *)interval;

/// NSDate->时间戳
+ (NSString *)intervalFromDate:(NSDate *)date;

/// 时间区间
+ (NSArray<NSString *> *)queryDate:(NSInteger)day;
///获取指定时间内的所有日期
+ (NSArray *)betweenDaysWithDate:(NSDate *)fromDate toDate:(NSDate *)toDate block:(void(^)(NSDateComponents *comps, NSDate *date))block;

@end


@interface NSDateComponents (Helper)

+ (NSDateComponents *)dateWithYear:(NSInteger)year
                             month:(NSInteger)month
                               day:(NSInteger)day
                              hour:(NSInteger)hour
                            minute:(NSInteger)minute
                            second:(NSInteger)second;

@end


@interface NSCalendar (Helper)

@property(nonatomic, readonly, class) NSArray *monthList;
@property(nonatomic, readonly, class) NSArray *dayList;
@property(nonatomic, readonly, class) NSArray *weekList;

@property(nonatomic, strong, readonly, class) NSCalendar *shard;

@property(nonatomic, assign, readonly, class) NSCalendarUnit unitFlags;
    
@end



@interface NSLocale (Helper)

///chinese
@property(nonatomic, readonly, class) NSLocale *zh_CN;
///USA
@property(nonatomic, readonly, class) NSLocale *en_US;

@end

NS_ASSUME_NONNULL_END
