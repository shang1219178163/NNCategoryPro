//
//  NSDateFormatter+Helper.h
//  Location
//
//  Created by BIN on 2017/12/21.
//  Copyright © 2017年 Location. All rights reserved.
//

/**
 NSDateFormatter *dateFormatter = [NSDateFormatter dateFormat:@"MM/dd/yyyy"];

 */

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
FOUNDATION_EXPORT NSString * const kFormatDate ;
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
FOUNDATION_EXPORT NSString * const kFormatDateFive ;
/// EEE, dd MMM yyyy HH:mm:ss GMT
FOUNDATION_EXPORT NSString * const kFormatDateSix ;

@interface NSDateFormatter (Helper)

/// 获取DateFormatter(默认格式)
+ (NSDateFormatter *)dateFormat:(NSString *)formatStr;

/// Date -> String
+ (NSString *)stringFromDate:(NSDate *)date fmt:(NSString *)format;

/// String -> Date
+ (NSDate *)dateFromString:(NSString *)dateStr fmt:(NSString *)format;

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

@end

NS_ASSUME_NONNULL_END
