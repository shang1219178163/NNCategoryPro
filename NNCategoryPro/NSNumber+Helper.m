
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

// 转为2位小数四舍五入
-(NSString *)toString{
    NSString *result = [NSNumberFormatter fractionDigits:self
                                                     min:2
                                                     max:2
                                            roundingMode:NSNumberFormatterRoundUp];
    return result;
}

@end
