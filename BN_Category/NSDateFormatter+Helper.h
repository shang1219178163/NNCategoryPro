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

UIKIT_EXTERN const NSInteger kDate_second ;
UIKIT_EXTERN const NSInteger kDate_minute ;
UIKIT_EXTERN const NSInteger kDate_hour ;
UIKIT_EXTERN const NSInteger kDate_day ;
UIKIT_EXTERN const NSInteger kDate_week ;
UIKIT_EXTERN const NSInteger kDate_year ;

FOUNDATION_EXPORT NSString * const kFormatDate ;
FOUNDATION_EXPORT NSString * const kFormatDate_one ;
FOUNDATION_EXPORT NSString * const kFormatDate_two ;
FOUNDATION_EXPORT NSString * const kFormatDate_five ;

@interface NSDateFormatter (Helper)

+ (NSDateFormatter *)dateFormat:(NSString *)formatStr;

+ (NSString *)format:(NSString *)format date:(NSDate *)date;

+ (NSDate *)format:(NSString *)format dateStr:(NSString *)dateStr;

+ (NSString *)format:(NSString *)format interval:(NSTimeInterval)interval;

@end
