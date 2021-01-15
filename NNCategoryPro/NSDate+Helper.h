//
//  NSDate+Helper.h
//  Location
//
//  Created by BIN on 2017/12/21.
//  Copyright © 2017年 Shang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

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

NS_ASSUME_NONNULL_END
