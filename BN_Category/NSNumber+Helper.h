//
//  NSNumber+Helper.h
//  
//
//  Created by BIN on 2018/7/20.
//  Copyright © 2018年 SHANG. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSNumber (Helper)

@property (nonatomic, strong, readonly) NSDecimalNumber *decNumer;

/**
 NSNumberFormatter格式化
 
 */
-(NSString *)stringValue;

NSString * NSStringFromRoundHalfUp(NSNumber *number, NSUInteger digit, NSNumberFormatterStyle numberStyle);

#pragma mark - ceil , round, floor

NSNumber * NSNumberFromRound(NSNumber *number, NSUInteger digit, NSNumberFormatterRoundingMode roundingMode);
/**
 四舍五入
 
 @param number 穿传入值
 @param digit 限制最大位数
 */
NSNumber * NSNumberFromRoundHalfUp(NSNumber *number, NSUInteger digit);
/**
 向上取整
 
 @param number 穿传入值
 @param digit 限制最大位数
 */
NSNumber * NSNumberFromRoundCeil(NSNumber *number, NSUInteger digit);
/**
 向下取整
 
 @param number 穿传入值
 @param digit 限制最大位数
 */
NSNumber * NSNumberFromRoundFloor(NSNumber *number, NSUInteger digit);


@end
