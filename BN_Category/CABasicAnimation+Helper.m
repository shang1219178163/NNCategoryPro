//
//  CABasicAnimation+Helper.m
//  HuiZhuBang
//
//  Created by hsf on 2018/9/18.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//

#import "CABasicAnimation+Helper.h"

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

+(CABasicAnimation *)animKeyPath:(NSString *)keyPath duration:(CFTimeInterval)duration autoreverses:(BOOL)autoreverses repeatCount:(float)repeatCount fillMode:(NSString *)fillMode removedOnCompletion:(BOOL)removedOnCompletion functionName:(NSString *)functionName{
    
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
    anim.cumulative = [keyPath isEqualToString:kTransformRotationZ] == YES ? YES : NO;
    return anim;
}

+(CABasicAnimation *)animKeyPath:(NSString *)keyPath duration:(CFTimeInterval)duration fromValue:(id)fromValue toValue:(id)toValue autoreverses:(BOOL)autoreverses repeatCount:(float)repeatCount fillMode:(NSString *)fillMode removedOnCompletion:(BOOL)removedOnCompletion functionName:(NSString *)functionName{
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



@end
