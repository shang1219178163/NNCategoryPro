
//
//  NSNumber+Helper.m
//  
//
//  Created by BIN on 2018/7/20.
//  Copyright © 2018年 SHANG. All rights reserved.
//

#import "NSNumber+Helper.h"

#import "NSNumberFormatter+Helper.h"

@implementation NSNumber (Helper)

-(NSDecimalNumber *)decNumer{
    return [NSDecimalNumber decimalNumberWithDecimal:self.decimalValue];
}

// 转为max位小数四舍五入
-(NSString *)toString:(NSUInteger)max{
    NSString *result = [NSNumberFormatter fractionDigits:self min:2 max:max roundingMode:NSNumberFormatterRoundUp];
    return result;
}

// 转为2位小数四舍五入
-(NSString *)toString{
    return [self toString:2];
}

@end
