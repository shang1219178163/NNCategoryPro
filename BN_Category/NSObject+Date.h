//
//  NSObject+Date.h
//  ProductTemplet
//
//  Created by hsf on 2018/9/29.
//  Copyright © 2018年 BN. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSObject (Date)

- (BOOL)isTimeStamp;

- (NSDate *)toDateWithFormatter:(NSString *)dateFormatter;
- (NSDate *)toDate;

- (NSString *)toTimeDateWithFormatter:(NSString *)dateFormatter;
- (NSString *)toTimeDate;

#pragma mark - -转化

- (NSString *)toTimeStampWithFormatter:(NSString *)dateFormatter;
- (NSString *)toTimestamp;

- (NSDate *)dateWithTimeStamp:(NSString *)timeStamp;

#pragma mark- -字符串转日期
- (NSDate *)dateWithString:(NSString *)dateString format:(NSString *)format;
- (NSDate *)dateWithString:(NSString *)dateString;


#pragma mark- -日期转字符串
- (NSString *)stringWithDate:(NSDate *)date format:(NSString *)format;
- (NSString *)stringWithDate:(NSDate *)date;

#pragma mark - -时间戳

- (NSString *)toTimestampMonth;

- (NSString *)toTimestampShort;

- (NSString *)toTimestampFull;

- (NSString *)timeByAddingDays:(id)days;

/**  比较两个日期,年月日, 时分秒 各相差多久
 *   先判断年 若year>0   则相差这么多年,后面忽略
 *   再判断月 若month>0  则相差这么多月,后面忽略
 *   再判断日 若day>0    则相差这么多天,后面忽略(0是今天,1是昨天,2是前天)
 *          若day=0    则是今天 返回相差的总时长
 */
+ (NSDateComponents *)compareCalendar:(NSDate *)date;

/**  最近的日期*/
+ (NSString *)relativeDate:(NSDate *)date;

+ (NSString *)timeTipInfoFromTimestamp:(NSInteger)timestamp;

- (NSString *)compareCurrentTime;
- (NSString *)compareCurrentTimeDays;
- (NSString *)compareTimeInfo;

@end
