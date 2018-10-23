//
//  CAKeyframeAnimation+Helper.h
//  HuiZhuBang
//
//  Created by hsf on 2018/9/19.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface CAKeyframeAnimation (Helper)

/**
 源方法
 */
+(CAKeyframeAnimation *)animDuration:(CFTimeInterval)duration autoreverses:(BOOL)autoreverses repeatCount:(float)repeatCount fillMode:(NSString *)fillMode removedOnCompletion:(BOOL)removedOnCompletion functionName:(NSString *)functionName;

+(CAKeyframeAnimation *)animPath:(CGPathRef)pathRef duration:(CFTimeInterval)duration autoreverses:(BOOL)autoreverses repeatCount:(float)repeatCount fillMode:(NSString *)fillMode removedOnCompletion:(BOOL)removedOnCompletion functionName:(NSString *)functionName;

+(CAKeyframeAnimation *)animPath:(CGPathRef)pathRef duration:(CFTimeInterval)duration autoreverses:(BOOL)autoreverses repeatCount:(float)repeatCount;

//
+(CAKeyframeAnimation *)animValues:(NSArray<NSValue *>*)values duration:(CFTimeInterval)duration autoreverses:(BOOL)autoreverses repeatCount:(float)repeatCount fillMode:(NSString *)fillMode removedOnCompletion:(BOOL)removedOnCompletion functionName:(NSString *)functionName;

+(CAKeyframeAnimation *)animValues:(NSArray<NSValue *>*)values duration:(CFTimeInterval)duration autoreverses:(BOOL)autoreverses repeatCount:(float)repeatCount;


@end
