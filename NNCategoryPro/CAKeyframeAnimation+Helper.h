//
//  CAKeyframeAnimation+Helper.h
//  
//
//  Created by BIN on 2018/9/19.
//  Copyright © 2018年 SHANG. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

NS_ASSUME_NONNULL_BEGIN

@interface CAKeyframeAnimation (Helper)

/**
 [源]关键帧动画
 */
+(CAKeyframeAnimation *)animateWithDuration:(CFTimeInterval)duration
                               autoreverses:(BOOL)autoreverses
                                repeatCount:(float)repeatCount
                                   fillMode:(NSString *)fillMode
                        removedOnCompletion:(BOOL)removedOnCompletion
                               functionName:(CAMediaTimingFunctionName)functionName;
/**
 关键帧动画
 */
+(CAKeyframeAnimation *)animWithPath:(CGPathRef)pathRef
                            duration:(CFTimeInterval)duration
                        autoreverses:(BOOL)autoreverses
                         repeatCount:(float)repeatCount
                            fillMode:(NSString *)fillMode
                 removedOnCompletion:(BOOL)removedOnCompletion
                        functionName:(CAMediaTimingFunctionName)functionName;
/**
 关键帧动画
 fillMode:kCAFillModeForwards,
 removedOnCompletion:false
 functionName:kCAMediaTimingFunctionDefault
 */
+(CAKeyframeAnimation *)animWithPath:(CGPathRef)pathRef
                            duration:(CFTimeInterval)duration
                        autoreverses:(BOOL)autoreverses
                         repeatCount:(float)repeatCount;

/**
 [源]关键帧动画
 */
+(CAKeyframeAnimation *)animWithValues:(NSArray<NSValue *>*)values
                              duration:(CFTimeInterval)duration
                          autoreverses:(BOOL)autoreverses
                           repeatCount:(float)repeatCount
                              fillMode:(NSString *)fillMode
                   removedOnCompletion:(BOOL)removedOnCompletion
                          functionName:(CAMediaTimingFunctionName)functionName;
/**
 关键帧动画
 */
+(CAKeyframeAnimation *)animWithValues:(NSArray<NSValue *>*)values
                              duration:(CFTimeInterval)duration
                          autoreverses:(BOOL)autoreverses
                           repeatCount:(float)repeatCount;

@end

NS_ASSUME_NONNULL_END
