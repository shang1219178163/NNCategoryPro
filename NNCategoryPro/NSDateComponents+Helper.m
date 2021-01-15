//
//  NSDateComponents+Helper.m
//  ProductTemplet
//
//  Created by Bin Shang on 2019/8/20.
//  Copyright © 2019 BN. All rights reserved.
//

#import "NSDateComponents+Helper.h"
#import <NNGloble/NNGloble.h>

@implementation NSDateComponents (Helper)

+ (NSDateComponents *)dateWithYear:(NSInteger)year
                             month:(NSInteger)month
                               day:(NSInteger)day
                              hour:(NSInteger)hour
                            minute:(NSInteger)minute
                            second:(NSInteger)second{
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.year = year;
    components.month = month;
    components.day = day;
    components.hour = hour;
    components.minute = minute;
    components.second = second;
    return components;
}


@end



@implementation NSCalendar (Helper)

static NSCalendar *_shared = nil;
+ (NSCalendar *)shard{
    if (!_shared) {
        _shared = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    }
    return _shared;
}

+ (NSCalendarUnit)unitFlags{
    return NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay |
    NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond |
    NSCalendarUnitWeekdayOrdinal | NSCalendarUnitWeekday;
}

static NSArray *_dayList = nil;
+ (NSArray *)dayList{
    if (!_dayList) {
        _dayList = [kDesDay componentsSeparatedByString:@","];
    }
    return _dayList;
}

static NSArray *_monthList = nil;
+ (NSArray *)monthList{
    if (!_monthList) {
        _monthList = [kDesMonth componentsSeparatedByString:@","];
    }
    return _monthList;
}

static NSArray *_weekList = nil;
+ (NSArray *)weekList{
    if (!_weekList) {
        _weekList = [kDesWeek componentsSeparatedByString:@","];
    }
    return _weekList;
}

@end
