//
//  CABasicAnimation+Helper.m
//  
//
//  Created by BIN on 2018/9/18.
//  Copyright © 2018年 SHANG. All rights reserved.
//

#import "CABasicAnimation+Helper.h"

NSString * const kTransformMoveX = @"transform.translation.x";// x方向平移
NSString * const kTransformMoveY = @"transform.translation.y";// y方向平移

NSString * const kTransformScale = @"transform.scale";//比例转化
NSString * const kTransformScaleX = @"transform.scale.x";//宽的比例
NSString * const kTransformScaleY = @"transform.scale.y";//高的比例

NSString * const kTransformRotationZ = @"transform.rotation.z";
NSString * const kTransformRotationX = @"transform.rotation.x";
NSString * const kTransformRotationY = @"transform.rotation.y";

NSString * const kTransformSizW = @"contentsRect.size.width";//横向拉伸缩放 @(0.4)最好是0~1之间的
NSString * const kTransformPosition = @"position";//位置(中心点的改变) [NSValue valueWithCGPoint:CGPointMake(300, 300)];
NSString * const kTransformBounds = @"bounds";//大小，中心不变  [NSValue valueWithCGRect:CGRectMake(0, 0, 200, 200)];
NSString * const kTransformContents = @"contents";//内容,imageAnima.toValue = (id)[UIImage imageNamed:@"to"].CGImage;
NSString * const kTransformOpacity = @"opacity";//透明度
NSString * const kTransformCornerRadius = @"cornerRadius";//圆角
NSString * const kTransformBackgroundColor = @"backgroundColor";//背景

NSString * const kTransformPath = @"path";//
NSString * const kTransformStrokeEnd = @"strokeEnd";//背景

@implementation CABasicAnimation (Helper)

static NSArray *_functionNames = nil;

+ (NSArray *)functionNames{
    if (!_functionNames) {
        _functionNames = @[
                           kCAMediaTimingFunctionLinear,//匀速
                           kCAMediaTimingFunctionEaseIn,//先慢
                           kCAMediaTimingFunctionEaseOut,//后慢
                           kCAMediaTimingFunctionEaseInEaseOut,//先慢 后慢 中间快
                           kCAMediaTimingFunctionDefault//默认
                           ];
    }
    return _functionNames;
}

+(CABasicAnimation *)animKeyPath:(NSString *)keyPath duration:(CFTimeInterval)duration autoreverses:(BOOL)autoreverses repeatCount:(float)repeatCount fillMode:(NSString *)fillMode removedOnCompletion:(BOOL)removedOnCompletion functionName:(CAMediaTimingFunctionName)functionName{
    
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:keyPath];
    //默认是顺时针效果，若将fromValue和toValue的值互换，则为逆时针效果
    anim.duration = duration;
    anim.repeatCount = repeatCount; //如果这里想设置成一直自旋转，可以设置MAXFLOAT
    anim.autoreverses = autoreverses;
    
    anim.fillMode = fillMode;
    anim.removedOnCompletion = removedOnCompletion;
    
    NSString * name = [CABasicAnimation.functionNames containsObject:functionName] ? functionName : CABasicAnimation.functionNames.firstObject;
    anim.timingFunction = [CAMediaTimingFunction functionWithName:name];
    //    rotationAnim.cumulative = YES;
    anim.cumulative = [keyPath isEqualToString:kTransformRotationZ];
    return anim;
}

+(CABasicAnimation *)animKeyPath:(NSString *)keyPath duration:(CFTimeInterval)duration fromValue:(id)fromValue toValue:(id)toValue autoreverses:(BOOL)autoreverses repeatCount:(float)repeatCount fillMode:(NSString *)fillMode removedOnCompletion:(BOOL)removedOnCompletion functionName:(CAMediaTimingFunctionName)functionName{
    CABasicAnimation *anim = [CABasicAnimation animKeyPath:keyPath duration:duration autoreverses:autoreverses repeatCount:repeatCount fillMode:fillMode removedOnCompletion:removedOnCompletion functionName:functionName];
    //默认是顺时针效果，若将fromValue和toValue的值互换，则为逆时针效果
    anim.fromValue = fromValue;
    anim.toValue = toValue;
  
    return anim;
}

+(CABasicAnimation *)animKeyPath:(NSString *)keyPath duration:(CFTimeInterval)duration fromValue:(id)fromValue toValue:(id)toValue autoreverses:(BOOL)autoreverses repeatCount:(float)repeatCount{
    
    CABasicAnimation *anim = [CABasicAnimation animKeyPath:keyPath duration:duration autoreverses:autoreverses repeatCount:repeatCount fillMode:kCAFillModeForwards removedOnCompletion:false functionName:CABasicAnimation.functionNames.firstObject];
    //默认是顺时针效果，若将fromValue和toValue的值互换，则为逆时针效果
    anim.fromValue = fromValue;
    anim.toValue = toValue;
    return anim;
}


/**
 一次性动画
 */
+(CABasicAnimation *)animKeyPath:(NSString *)keyPath duration:(CFTimeInterval)duration fromValue:(id)fromValue toValue:(id)toValue{
    CABasicAnimation *anim = [CABasicAnimation animKeyPath:keyPath duration:duration autoreverses:false repeatCount:1 fillMode:kCAFillModeForwards removedOnCompletion:false functionName:CABasicAnimation.functionNames.firstObject];
    //默认是顺时针效果，若将fromValue和toValue的值互换，则为逆时针效果
    anim.fromValue = fromValue;
    anim.toValue = toValue;
    return anim;
}

@end
