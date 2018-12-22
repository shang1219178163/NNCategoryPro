//
//  NSNumberFormatter+Helper.h
//  Location
//
//  Created by BIN on 2017/12/21.
//  Copyright © 2017年 Location. All rights reserved.
//

#import <Foundation/Foundation.h>

FOUNDATION_EXPORT NSString * const kNumIdentify ;// 默认(四舍五入)
FOUNDATION_EXPORT NSString * const kNumIdentify_decimal ;
FOUNDATION_EXPORT NSString * const kNumIdentify_percent ;
FOUNDATION_EXPORT NSString * const kNumIdentify_currency ;
FOUNDATION_EXPORT NSString * const kNumIdentify_scientific ;
FOUNDATION_EXPORT NSString * const kNumIdentify_plusSign ;
FOUNDATION_EXPORT NSString * const kNumIdentify_minusSign ;
FOUNDATION_EXPORT NSString * const kNumIdentify_exponentSymbol ;

FOUNDATION_EXPORT NSString * const kNumFormat;

@interface NSNumberFormatter (Helper)

+ (NSNumberFormatter *)numberIdentify:(NSString *)identify;

+ (NSNumberFormatter *)numberFormat:(NSString *)formatStr;

+ (NSString *)numberStyle:(NSNumberFormatterStyle)nstyle number:(id)number;


@end
