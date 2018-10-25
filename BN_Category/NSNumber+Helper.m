
//
//  NSNumber+Helper.m
//  HuiZhuBang
//
//  Created by BIN on 2018/7/20.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//

#import "NSNumber+Helper.h"

#import "NSNumberFormatter+Helper.h"

@implementation NSNumber (Helper)

-(NSString *)stringValue{

    NSParameterAssert([self isKindOfClass:[NSNumber class]]);
    NSNumberFormatter *formatter = [NSNumberFormatter numberIdentify:@"四舍五入"];
    //    DDLog(@"_%p_",formatter);
    formatter.minimumIntegerDigits = 1;
    formatter.maximumFractionDigits = 2;
    formatter.roundingMode = NSNumberFormatterRoundFloor;
    NSString *string = [formatter stringFromNumber:self];
    return string;
}

@end
