//
//  CABasicAnimation+Helper.m
//  
//
//  Created by BIN on 2018/9/18.
//  Copyright © 2018年 SHANG. All rights reserved.
//

#import "CABasicAnimation+Helper.h"

NSString * const kTransformMoveX = @"transform.translation.x";
NSString * const kTransformMoveY = @"transform.translation.y";

NSString * const kTransformScale = @"transform.scale";
NSString * const kTransformScaleX = @"transform.scale.x";
NSString * const kTransformScaleY = @"transform.scale.y";

NSString * const kTransformRotationZ = @"transform.rotation.z";
NSString * const kTransformRotationX = @"transform.rotation.x";
NSString * const kTransformRotationY = @"transform.rotation.y";

NSString * const kTransformSizW = @"contentsRect.size.width";
NSString * const kTransformPosition = @"position";
NSString * const kTransformBounds = @"bounds";
NSString * const kTransformContents = @"contents";
NSString * const kTransformOpacity = @"opacity";
NSString * const kTransformCornerRadius = @"cornerRadius";
NSString * const kTransformBackgroundColor = @"backgroundColor";

NSString * const kTransformPath = @"path";
NSString * const kTransformStrokeEnd = @"strokeEnd";

@implementation CABasicAnimation (Helper)

static NSArray *_functionNames = nil;

+ (NSArray *)functionNames{
    if (!_functionNames) {
        _functionNames = @[kCAMediaTimingFunctionLinear,//匀速
                           kCAMediaTimingFunctionEaseIn,//先慢
                           kCAMediaTimingFunctionEaseOut,//后慢
                           kCAMediaTimingFunctionEaseInEaseOut,//先慢 后慢 中间快
                           kCAMediaTimingFunctionDefault//默认
                           ];
    }
    return _functionNames;
}

+(CABasicAnimation *)animKeyPath:(NSString *)keyPath
                        duration:(CFTimeInterval)duration
                    autoreverses:(BOOL)autoreverses
                     repeatCount:(float)repeatCount
                        fillMode:(NSString *)fillMode
             removedOnCompletion:(BOOL)removedOnCompletion
                    functionName:(CAMediaTimingFunctionName)functionName{
    
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

+(CABasicAnimation *)animKeyPath:(NSString *)keyPath
                        duration:(CFTimeInterval)duration
                       fromValue:(id)fromValue
                         toValue:(id)toValue
                    autoreverses:(BOOL)autoreverses
                     repeatCount:(float)repeatCount
                        fillMode:(NSString *)fillMode
             removedOnCompletion:(BOOL)removedOnCompletion
                    functionName:(CAMediaTimingFunctionName)functionName{
    
    CABasicAnimation *anim = [CABasicAnimation
                              animKeyPath:keyPath
                              duration:duration
                              autoreverses:autoreverses
                              repeatCount:repeatCount
                              fillMode:fillMode
                              removedOnCompletion:removedOnCompletion
                              functionName:functionName];
    //默认是顺时针效果，若将fromValue和toValue的值互换，则为逆时针效果
    anim.fromValue = fromValue;
    anim.toValue = toValue;
  
    return anim;
}

+(CABasicAnimation *)animKeyPath:(NSString *)keyPath
                        duration:(CFTimeInterval)duration
                       fromValue:(id)fromValue
                         toValue:(id)toValue
                    autoreverses:(BOOL)autoreverses
                     repeatCount:(float)repeatCount{
    
    CABasicAnimation *anim = [CABasicAnimation
                              animKeyPath:keyPath
                              duration:duration
                              autoreverses:autoreverses
                              repeatCount:repeatCount
                              fillMode:kCAFillModeForwards
                              removedOnCompletion:false
                              functionName:CABasicAnimation.functionNames.firstObject];
    //默认是顺时针效果，若将fromValue和toValue的值互换，则为逆时针效果
    anim.fromValue = fromValue;
    anim.toValue = toValue;
    return anim;
}

/**
 一次性动画
 */
+(CABasicAnimation *)animKeyPath:(NSString *)keyPath
                        duration:(CFTimeInterval)duration
                       fromValue:(id)fromValue
                         toValue:(id)toValue{
    
    CABasicAnimation *anim = [CABasicAnimation
                              animKeyPath:keyPath
                              duration:duration
                              autoreverses:false
                              repeatCount:1
                              fillMode:kCAFillModeForwards
                              removedOnCompletion:false
                              functionName:CABasicAnimation.functionNames.firstObject];
    //默认是顺时针效果，若将fromValue和toValue的值互换，则为逆时针效果
    anim.fromValue = fromValue;
    anim.toValue = toValue;
    return anim;
}

@end
