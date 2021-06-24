//
//  CABasicAnimation+Helper.h
//  
//
//  Created by BIN on 2018/9/18.
//  Copyright © 2018年 SHANG. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

NS_ASSUME_NONNULL_BEGIN

/// x方向平移
FOUNDATION_EXPORT NSString * const kTransformMoveX ;
/// y方向平移
FOUNDATION_EXPORT NSString * const kTransformMoveY ;
/// 比例转化
FOUNDATION_EXPORT NSString * const kTransformScale ;
/// 宽的比例
FOUNDATION_EXPORT NSString * const kTransformScaleX ;
/// 高的比例
FOUNDATION_EXPORT NSString * const kTransformScaleY ;
/// 绕Z轴旋转
FOUNDATION_EXPORT NSString * const kTransformRotationZ ;
/// 绕X轴旋转
FOUNDATION_EXPORT NSString * const kTransformRotationX ;
/// 绕Y轴旋转
FOUNDATION_EXPORT NSString * const kTransformRotationY ;
/// 横向拉伸缩放 @(0.4)最好是0~1之间的
FOUNDATION_EXPORT NSString * const kTransformSizW ;
/// 位置(中心点的改变) [NSValue valueWithCGPoint:CGPointMake(300, 300)];
FOUNDATION_EXPORT NSString * const kTransformPosition ;
/// 大小，中心不变  [NSValue valueWithCGRect:CGRectMake(0, 0, 200, 200)];
FOUNDATION_EXPORT NSString * const kTransformBounds ;
/// 内容,imageAnima.toValue = (id)[UIImage imageNamed:@"to"].CGImage;
FOUNDATION_EXPORT NSString * const kTransformContents ;
/// 透明度
FOUNDATION_EXPORT NSString * const kTransformOpacity ;
/// 圆角
FOUNDATION_EXPORT NSString * const kTransformCornerRadius ;
/// 背景
FOUNDATION_EXPORT NSString * const kTransformBackgroundColor ;
/// Path
FOUNDATION_EXPORT NSString * const kTransformPath ;
/// 背景
FOUNDATION_EXPORT NSString * const kTransformStrokeEnd ;

//kCAValueFunctionRotateX

@interface CABasicAnimation (Helper)

@property (class, nonatomic, readonly, nullable) NSArray *functionNames;

/**
 源方法
 */
+(CABasicAnimation *)animKeyPath:(NSString *)keyPath
                        duration:(CFTimeInterval)duration
                    autoreverses:(BOOL)autoreverses
                     repeatCount:(float)repeatCount
                        fillMode:(NSString *)fillMode
             removedOnCompletion:(BOOL)removedOnCompletion
                    functionName:(CAMediaTimingFunctionName)functionName;

+(CABasicAnimation *)animKeyPath:(NSString *)keyPath
                        duration:(CFTimeInterval)duration
                       fromValue:(nullable id)fromValue
                         toValue:(nullable id)toValue
                    autoreverses:(BOOL)autoreverses
                     repeatCount:(float)repeatCount
                        fillMode:(NSString *)fillMode
             removedOnCompletion:(BOOL)removedOnCompletion
                    functionName:(CAMediaTimingFunctionName)functionName;

+(CABasicAnimation *)animKeyPath:(NSString *)keyPath
                        duration:(CFTimeInterval)duration
                       fromValue:(nullable id)fromValue
                         toValue:(nullable id)toValue
                    autoreverses:(BOOL)autoreverses
                     repeatCount:(float)repeatCount;

+(CABasicAnimation *)animKeyPath:(NSString *)keyPath
                        duration:(CFTimeInterval)duration
                       fromValue:(nullable id)fromValue
                         toValue:(nullable id)toValue;

@end


@interface CAAnimationGroup (Helper)

+(CAAnimationGroup *)animWithDuration:(CFTimeInterval)duration
                         autoreverses:(BOOL)autoreverses
                          repeatCount:(float)repeatCount
                             fillMode:(NSString *)fillMode
                  removedOnCompletion:(BOOL)removedOnCompletion;

+(CAAnimationGroup *)animList:(NSArray<CAAnimation *> *)list
                     duration:(CFTimeInterval)duration
                 autoreverses:(BOOL)autoreverses
                  repeatCount:(float)repeatCount
                     fillMode:(NSString *)fillMode
          removedOnCompletion:(BOOL)removedOnCompletion;

+(CAAnimationGroup *)animList:(NSArray<CAAnimation *> *)list
                     duration:(CFTimeInterval)duration
                 autoreverses:(BOOL)autoreverses
                  repeatCount:(float)repeatCount;
    
@end


@interface CAKeyframeAnimation (Helper)

/**
 [源]关键帧动画
 */
+(CAKeyframeAnimation *)animWithDuration:(CFTimeInterval)duration
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


@interface CASpringAnimation (Helper)

+(CASpringAnimation *)animKeyPath:(NSString *)keyPath
                         duration:(CFTimeInterval)duration
                        fromValue:(id)fromValue
                          toValue:(id)toValue
                     autoreverses:(BOOL)autoreverses
                      repeatCount:(float)repeatCount
                         fillMode:(NSString *)fillMode
              removedOnCompletion:(BOOL)removedOnCompletion;

@end

NS_ASSUME_NONNULL_END
