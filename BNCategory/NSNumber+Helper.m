
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
-(NSString *)to_string:(NSUInteger)max{
    NSString *result = [NSNumberFormatter fractionDigits:self min:2 max:max roundingMode:NSNumberFormatterRoundUp];
    return result;
}

// 转为2位小数四舍五入
-(NSString *)to_string{
    return [self to_string:2];
}

-(NSString *)stringValue{
//    NSParameterAssert([self isKindOfClass:[NSNumber class]]);
//    NSNumberFormatter *formatter = [NSNumberFormatter numberIdentify:kNumIdentify];
//    formatter.numberStyle = NSNumberFormatterNoStyle;
//    DDLog(@"_%p_",formatter);
//    formatter.minimumIntegerDigits = 1;//最少一位整数
//    formatter.maximumFractionDigits = 2;//最多两位小数
//    formatter.roundingMode = NSNumberFormatterRoundHalfUp;
//    NSString *result = [formatter stringFromNumber:self];
    return [self to_string];
}


@end
