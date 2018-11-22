//
//  NSNumberFormatter+Helper.h
//  Location
//
//  Created by BIN on 2017/12/21.
//  Copyright © 2017年 Location. All rights reserved.
//

#import <Foundation/Foundation.h>

FOUNDATION_EXPORT NSString * const kFormat_num ;// 默认(四舍五入)
FOUNDATION_EXPORT NSString * const kFormat_num_decimal ;
FOUNDATION_EXPORT NSString * const kFormat_num_percent ;
FOUNDATION_EXPORT NSString * const kFormat_num_currency ;
FOUNDATION_EXPORT NSString * const kFormat_num_scientific ;
FOUNDATION_EXPORT NSString * const kFormat_num_plusSign ;
FOUNDATION_EXPORT NSString * const kFormat_num_minusSign ;
FOUNDATION_EXPORT NSString * const kFormat_num_exponentSymbol ;

@interface NSNumberFormatter (Helper)

+ (NSNumberFormatter *)numberIdentify:(NSString *)identify;

+ (NSNumberFormatter *)numberFormat:(NSString *)formatStr;

+ (NSString *)numberStyle:(NSNumberFormatterStyle)nstyle number:(id)number;


@end
