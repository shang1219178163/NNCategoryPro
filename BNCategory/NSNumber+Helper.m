
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

-(NSString *)stringValue{
    NSParameterAssert([self isKindOfClass:[NSNumber class]]);
    NSNumberFormatter *formatter = [NSNumberFormatter numberIdentify:kNumIdentify];
    formatter.numberStyle = NSNumberFormatterNoStyle;
    //    DDLog(@"_%p_",formatter);
    formatter.minimumIntegerDigits = 1;//最少一位整数
    formatter.maximumFractionDigits = 2;//最多两位小数
    formatter.roundingMode = NSNumberFormatterRoundHalfUp;
    NSString *string = [formatter stringFromNumber:self];
    return string;
}

/**
 Decimal或Percent
 @param digit 最大位数
 */
NSString * NSStringFromRoundHalfUp(NSNumber *number, NSUInteger digit, NSNumberFormatterStyle numberStyle){
    NSString *identity = numberStyle == NSNumberFormatterPercentStyle ? kNumIdentify_percent : kNumIdentify ;
    NSNumberFormatter *formatter = [NSNumberFormatter numberIdentify:identity];
    //    formatter.numberStyle = NSNumberFormatterDecimalStyle;
    //    formatter.numberStyle = NSNumberFormatterPercentStyle;
    formatter.numberStyle = numberStyle;
    formatter.roundingMode = NSNumberFormatterRoundHalfUp;
    formatter.maximumFractionDigits = digit;
    NSString *string = [formatter stringFromNumber:number];
    return string;
}

#pragma mark - ceil , round, floor

NSNumber * NSNumberFromRound(NSNumber *number, NSUInteger digit, NSNumberFormatterRoundingMode roundingMode){
    switch (roundingMode) {
        case NSNumberFormatterRoundCeiling:
            return NSNumberFromRoundCeil(number, digit);
            break;
        case NSNumberFormatterRoundFloor:
            return NSNumberFromRoundFloor(number, digit);
            break;
        default:
            return NSNumberFromRoundHalfUp(number, digit);//默认四舍五入
            break;
    }
    return nil;
    
//    NSNumberFormatter *formatter = [NSNumberFormatter numberIdentify:kNumIdentify];
//    formatter.numberStyle = NSNumberFormatterNoStyle;
//
//    formatter.roundingMode = NSNumberFormatterRoundHalfUp;//四舍五入
//    formatter.roundingMode = NSNumberFormatterRoundCeiling;//向上取整
//    formatter.roundingMode = NSNumberFormatterRoundFloor;//向下取整
//    formatter.roundingMode = roundingMode;
//    formatter.maximumFractionDigits = digit;
//    formatter.minimumFractionDigits = digit;
//
//    //NSLog(@"round target:%@ result:%@",number,[formatter  stringFromNumber:number]);
//    NSNumber *result = [NSNumber numberWithDouble:[[formatter stringFromNumber:number] doubleValue]];
//    return result;
}

/**
 四舍五入

 @param number 穿传入值
 @param digit 限制最大位数
 */
NSNumber * NSNumberFromRoundHalfUp(NSNumber *number, NSUInteger digit){
    NSNumberFormatter *formatter = [NSNumberFormatter numberIdentify:kNumIdentify];
    formatter.numberStyle = NSNumberFormatterNoStyle;
    formatter.roundingMode = NSNumberFormatterRoundHalfUp;
    formatter.maximumFractionDigits = digit;
    formatter.minimumFractionDigits = digit;
    
    //NSLog(@"round target:%@ result:%@",number,[formatter  stringFromNumber:number]);
    NSNumber *result = [NSNumber numberWithDouble:[[formatter stringFromNumber:number] doubleValue]];
    return result;
    
}
/**
 向上取整
 
 @param number 穿传入值
 @param digit 限制最大位数
 */
NSNumber * NSNumberFromRoundCeil(NSNumber *number, NSUInteger digit){
    NSNumberFormatter *formatter = [NSNumberFormatter numberIdentify:kNumIdentify];
    formatter.numberStyle = NSNumberFormatterNoStyle;
    formatter.roundingMode = NSNumberFormatterRoundCeiling;
    formatter.maximumFractionDigits = digit;
    //NSLog(@"ceil target:%@ result:%@",number,[formatter stringFromNumber:number]);
    NSNumber *result = [NSNumber numberWithDouble:[[formatter stringFromNumber:number] doubleValue]];
    return result;
}
/**
 向下取整
 
 @param number 穿传入值
 @param digit 限制最大位数
 */
NSNumber * NSNumberFromRoundFloor(NSNumber *number, NSUInteger digit){
    NSNumberFormatter *formatter = [NSNumberFormatter numberIdentify:kNumIdentify];
    formatter.numberStyle = NSNumberFormatterNoStyle;
    formatter.roundingMode = NSNumberFormatterRoundFloor;
    formatter.maximumFractionDigits = digit;
    
    NSNumber *result = [NSNumber numberWithDouble:[[formatter stringFromNumber:number] doubleValue]];
    //NSLog(@"prev:%@, result:%@",number, result);
    return result;
}



@end
