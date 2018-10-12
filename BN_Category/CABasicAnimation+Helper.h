//
//  CABasicAnimation+Helper.h
//  HuiZhuBang
//
//  Created by hsf on 2018/9/18.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

static NSString * const kTransformMoveX = @"transform.translation.x";// x方向平移
static NSString * const kTransformMoveY = @"transform.translation.y";// y方向平移

static NSString * const kTransformScale = @"transform.scale";//比例转化
static NSString * const kTransformScaleX = @"transform.scale.x";//宽的比例
static NSString * const kTransformScaleY = @"transform.scale.y";//高的比例

static NSString * const kTransformRotationZ = @"transform.rotation.z";
static NSString * const kTransformRotationX = @"transform.rotation.x";
static NSString * const kTransformRotationY = @"transform.rotation.y";

static NSString * const kTransformSizW = @"contentsRect.size.width";//横向拉伸缩放 @(0.4)最好是0~1之间的
static NSString * const kTransformPosition = @"position";//位置(中心点的改变) [NSValue valueWithCGPoint:CGPointMake(300, 300)];
static NSString * const kTransformBounds = @"bounds";//大小，中心不变  [NSValue valueWithCGRect:CGRectMake(0, 0, 200, 200)];
static NSString * const kTransformContents = @"contents";//内容,imageAnima.toValue = (id)[UIImage imageNamed:@"to"].CGImage;
static NSString * const kTransformOpacity = @"opacity";//透明度
static NSString * const kTransformCornerRadius = @"cornerRadius";//圆角
static NSString * const kTransformBackgroundColor = @"backgroundColor";//背景

static NSString * const kTransformPath = @"path";//
static NSString * const kTransformStrokeEnd = @"strokeEnd";//背景

//kCAValueFunctionRotateX
@interface CABasicAnimation (Helper)

@property (class, nonatomic, readonly, nullable) NSArray *functionNames;

/**
 源方法
 */
+(CABasicAnimation *)animKeyPath:(NSString *)keyPath duration:(CFTimeInterval)duration autoreverses:(BOOL)autoreverses repeatCount:(float)repeatCount fillMode:(NSString *)fillMode removedOnCompletion:(BOOL)removedOnCompletion functionName:(NSString *)functionName;

+(CABasicAnimation *)animKeyPath:(NSString *)keyPath duration:(CFTimeInterval)duration fromValue:(id)fromValue toValue:(id)toValue autoreverses:(BOOL)autoreverses repeatCount:(float)repeatCount fillMode:(NSString *)fillMode removedOnCompletion:(BOOL)removedOnCompletion functionName:(NSString *)functionName;

+(CABasicAnimation *)animKeyPath:(NSString *)keyPath duration:(CFTimeInterval)duration fromValue:(id)fromValue toValue:(id)toValue autoreverses:(BOOL)autoreverses repeatCount:(float)repeatCount;

@end
