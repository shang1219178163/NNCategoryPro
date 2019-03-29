//
//  CABasicAnimation+Helper.h
//  
//
//  Created by BIN on 2018/9/18.
//  Copyright © 2018年 SHANG. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

FOUNDATION_EXPORT NSString * const kTransformMoveX ;// x方向平移
FOUNDATION_EXPORT NSString * const kTransformMoveY ;// y方向平移

FOUNDATION_EXPORT NSString * const kTransformScale ;//比例转化
FOUNDATION_EXPORT NSString * const kTransformScaleX ;//宽的比例
FOUNDATION_EXPORT NSString * const kTransformScaleY ;//高的比例

FOUNDATION_EXPORT NSString * const kTransformRotationZ ;
FOUNDATION_EXPORT NSString * const kTransformRotationX ;
FOUNDATION_EXPORT NSString * const kTransformRotationY ;

FOUNDATION_EXPORT NSString * const kTransformSizW ;//横向拉伸缩放 @(0.4)最好是0~1之间的
FOUNDATION_EXPORT NSString * const kTransformPosition ;//位置(中心点的改变) [NSValue valueWithCGPoint:CGPointMake(300, 300)];
FOUNDATION_EXPORT NSString * const kTransformBounds ;//大小，中心不变  [NSValue valueWithCGRect:CGRectMake(0, 0, 200, 200)];
FOUNDATION_EXPORT NSString * const kTransformContents ;//内容,imageAnima.toValue = (id)[UIImage imageNamed:@"to"].CGImage;
FOUNDATION_EXPORT NSString * const kTransformOpacity ;//透明度
FOUNDATION_EXPORT NSString * const kTransformCornerRadius ;//圆角
FOUNDATION_EXPORT NSString * const kTransformBackgroundColor ;//背景

FOUNDATION_EXPORT NSString * const kTransformPath ;//
FOUNDATION_EXPORT NSString * const kTransformStrokeEnd ;//背景

//kCAValueFunctionRotateX
@interface CABasicAnimation (Helper)

@property (class, nonatomic, readonly, nullable) NSArray *functionNames;

/**
 源方法
 */
+(CABasicAnimation *)animKeyPath:(NSString *)keyPath duration:(CFTimeInterval)duration autoreverses:(BOOL)autoreverses repeatCount:(float)repeatCount fillMode:(NSString *)fillMode removedOnCompletion:(BOOL)removedOnCompletion functionName:(CAMediaTimingFunctionName)functionName;

+(CABasicAnimation *)animKeyPath:(NSString *)keyPath duration:(CFTimeInterval)duration fromValue:(id)fromValue toValue:(id)toValue autoreverses:(BOOL)autoreverses repeatCount:(float)repeatCount fillMode:(NSString *)fillMode removedOnCompletion:(BOOL)removedOnCompletion functionName:(CAMediaTimingFunctionName)functionName;

+(CABasicAnimation *)animKeyPath:(NSString *)keyPath duration:(CFTimeInterval)duration fromValue:(id)fromValue toValue:(id)toValue autoreverses:(BOOL)autoreverses repeatCount:(float)repeatCount;

+(CABasicAnimation *)animKeyPath:(NSString *)keyPath duration:(CFTimeInterval)duration fromValue:(id)fromValue toValue:(id)toValue;

@end
