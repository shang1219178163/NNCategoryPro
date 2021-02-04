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


@implementation CAAnimationGroup (Helper)

+(CAAnimationGroup *)animWithDuration:(CFTimeInterval)duration
                         autoreverses:(BOOL)autoreverses
                          repeatCount:(float)repeatCount
                             fillMode:(NSString *)fillMode
                  removedOnCompletion:(BOOL)removedOnCompletion{
    
    CAAnimationGroup *anim = [CAAnimationGroup animation];
    anim.duration = duration;
    anim.repeatCount = repeatCount;
    anim.fillMode = fillMode;
    anim.removedOnCompletion = removedOnCompletion;
    
    return anim;
}

+(CAAnimationGroup *)animList:(NSArray<CAAnimation *> *)list
                     duration:(CFTimeInterval)duration
                 autoreverses:(BOOL)autoreverses
                  repeatCount:(float)repeatCount
                     fillMode:(NSString *)fillMode
          removedOnCompletion:(BOOL)removedOnCompletion{
    
    CAAnimationGroup *anim = [CAAnimationGroup animWithDuration:duration
                                                   autoreverses:autoreverses
                                                    repeatCount:repeatCount
                                                       fillMode:fillMode
                                            removedOnCompletion:removedOnCompletion];
    anim.animations = list;
    return anim;
}

+(CAAnimationGroup *)animList:(NSArray<CAAnimation *> *)list
                     duration:(CFTimeInterval)duration
                 autoreverses:(BOOL)autoreverses
                  repeatCount:(float)repeatCount{
    
    CAAnimationGroup *anim = [CAAnimationGroup animWithDuration:duration
                                                   autoreverses:autoreverses
                                                    repeatCount:repeatCount
                                                       fillMode:kCAFillModeForwards
                                            removedOnCompletion:NO];
    anim.animations = list;
    return anim;
}

@end


@implementation CAKeyframeAnimation (Helper)

+(CAKeyframeAnimation *)animWithDuration:(CFTimeInterval)duration
                            autoreverses:(BOOL)autoreverses
                             repeatCount:(float)repeatCount
                                fillMode:(NSString *)fillMode
                     removedOnCompletion:(BOOL)removedOnCompletion
                            functionName:(CAMediaTimingFunctionName)functionName{
    
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:kTransformPosition];

    anim.duration = duration;
    anim.autoreverses = autoreverses;
    anim.repeatCount = repeatCount; //如果这里想设置成一直自旋转，可以设置MAXFLOAT
    
    anim.fillMode = fillMode;
    anim.removedOnCompletion = removedOnCompletion;
    
    NSString *name = [CABasicAnimation.functionNames containsObject: functionName] ? functionName : CABasicAnimation.functionNames.firstObject;
    anim.timingFunction = [CAMediaTimingFunction functionWithName:name];
    return anim;
}

+(CAKeyframeAnimation *)animWithPath:(CGPathRef)pathRef
                            duration:(CFTimeInterval)duration
                        autoreverses:(BOOL)autoreverses
                         repeatCount:(float)repeatCount
                            fillMode:(NSString *)fillMode
                 removedOnCompletion:(BOOL)removedOnCompletion
                        functionName:(CAMediaTimingFunctionName)functionName{
    
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animWithDuration:duration
                                                         autoreverses:autoreverses
                                                          repeatCount:repeatCount
                                                             fillMode:fillMode
                                                  removedOnCompletion:removedOnCompletion
                                                         functionName:functionName];
    anim.path = pathRef;
    CGPathRelease(pathRef);
    return anim;
}

+(CAKeyframeAnimation *)animWithPath:(CGPathRef)pathRef
                            duration:(CFTimeInterval)duration
                        autoreverses:(BOOL)autoreverses
                         repeatCount:(float)repeatCount{
    
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animWithDuration:duration
                                                          autoreverses:autoreverses
                                                          repeatCount:repeatCount
                                                             fillMode:kCAFillModeForwards
                                                  removedOnCompletion:false
                                                         functionName:kCAMediaTimingFunctionDefault];
    anim.path = pathRef;
    CGPathRelease(pathRef);
    return anim;
}


+(CAKeyframeAnimation *)animWithValues:(NSArray<NSValue *>*)values
                              duration:(CFTimeInterval)duration
                          autoreverses:(BOOL)autoreverses
                           repeatCount:(float)repeatCount
                              fillMode:(NSString *)fillMode
                   removedOnCompletion:(BOOL)removedOnCompletion
                          functionName:(CAMediaTimingFunctionName)functionName{
    
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animWithDuration:duration
                                                            autoreverses:autoreverses
                                                             repeatCount:repeatCount
                                                                fillMode:fillMode
                                                     removedOnCompletion:removedOnCompletion
                                                            functionName:functionName];
    anim.values = values;
    return anim;
}

+(CAKeyframeAnimation *)animWithValues:(NSArray<NSValue *>*)values
                              duration:(CFTimeInterval)duration
                          autoreverses:(BOOL)autoreverses
                           repeatCount:(float)repeatCount{
    
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animWithDuration:duration
                                                            autoreverses:autoreverses
                                                             repeatCount:repeatCount
                                                                fillMode:kCAFillModeForwards
                                                     removedOnCompletion:false
                                                            functionName:kCAMediaTimingFunctionDefault];
    anim.values = values;
    return anim;
}

@end


@implementation CASpringAnimation (Helper)


//+(CASpringAnimation *)animKeyPath:(NSString *)keyPath duration:(CFTimeInterval)duration fromValue:(id)fromValue toValue:(id)toValue autoreverses:(BOOL)autoreverses repeatCount:(float)repeatCount fillMode:(NSString *)fillMode removedOnCompletion:(BOOL)removedOnCompletion{
//
//    // 位置移动
//    CASpringAnimation *anim = [CASpringAnimation animKeyPath:@"position"];
//    // 1秒后执行
//    anim.beginTime = CACurrentMediaTime() + 1;
//    // 阻尼系数（此值越大弹框效果越不明显）
//    anim.damping = 2;
//    // 刚度系数（此值越大弹框效果越明显）
//    anim.stiffness = 50;
//    // 质量大小（越大惯性越大）
//    anim.mass = 1;
//    // 初始速度
//    anim.initialVelocity = 10;
//    // 开始位置
//    anim.fromValue = fromValue;
//    anim.toValue = toValue;
//    // 终止位置
//    // 持续时间
//    anim.duration = anim.settlingDuration;
//    // 添加动画
//    [_springView.layer addAnimation:anim forKey:@"spring"];
//    return anim;
//}


@end
