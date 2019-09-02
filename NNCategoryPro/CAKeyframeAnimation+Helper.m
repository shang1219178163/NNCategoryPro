
//
//  CAKeyframeAnimation+Helper.m
//  
//
//  Created by BIN on 2018/9/19.
//  Copyright © 2018年 SHANG. All rights reserved.
//

#import "CAKeyframeAnimation+Helper.h"

#import "CABasicAnimation+Helper.h"

@implementation CAKeyframeAnimation (Helper)

+(CAKeyframeAnimation *)animDuration:(CFTimeInterval)duration autoreverses:(BOOL)autoreverses repeatCount:(float)repeatCount fillMode:(NSString *)fillMode removedOnCompletion:(BOOL)removedOnCompletion functionName:(CAMediaTimingFunctionName)functionName{
    
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:kTransformPosition];

    anim.duration = duration;
    anim.autoreverses = autoreverses;
    anim.repeatCount = repeatCount; //如果这里想设置成一直自旋转，可以设置MAXFLOAT
    
    anim.fillMode = fillMode;
    anim.removedOnCompletion = removedOnCompletion;
    
    NSString * name = [CABasicAnimation.functionNames containsObject: functionName] ? functionName : CABasicAnimation.functionNames.firstObject;
    anim.timingFunction = [CAMediaTimingFunction functionWithName:name];
    
    return anim;
}

+(CAKeyframeAnimation *)animPath:(CGPathRef)pathRef duration:(CFTimeInterval)duration autoreverses:(BOOL)autoreverses repeatCount:(float)repeatCount fillMode:(NSString *)fillMode removedOnCompletion:(BOOL)removedOnCompletion functionName:(CAMediaTimingFunctionName)functionName{
    
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animDuration:duration autoreverses:autoreverses repeatCount:repeatCount fillMode:fillMode removedOnCompletion:removedOnCompletion functionName:functionName];
    anim.path = pathRef;
    CGPathRelease(pathRef);
    
    return anim;
}

+(CAKeyframeAnimation *)animPath:(CGPathRef)pathRef duration:(CFTimeInterval)duration autoreverses:(BOOL)autoreverses repeatCount:(float)repeatCount{
    
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animDuration:duration autoreverses:autoreverses repeatCount:repeatCount fillMode:kCAFillModeForwards removedOnCompletion:NO functionName:kCAMediaTimingFunctionDefault];
    anim.path = pathRef;
    CGPathRelease(pathRef);
    
    return anim;
}


+(CAKeyframeAnimation *)animValues:(NSArray<NSValue *>*)values duration:(CFTimeInterval)duration autoreverses:(BOOL)autoreverses repeatCount:(float)repeatCount fillMode:(NSString *)fillMode removedOnCompletion:(BOOL)removedOnCompletion functionName:(CAMediaTimingFunctionName)functionName{
    
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animDuration:duration autoreverses:autoreverses repeatCount:repeatCount fillMode:fillMode removedOnCompletion:removedOnCompletion functionName:functionName];
    anim.values = values;
    
    return anim;
}

+(CAKeyframeAnimation *)animValues:(NSArray<NSValue *>*)values duration:(CFTimeInterval)duration autoreverses:(BOOL)autoreverses repeatCount:(float)repeatCount{
    
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animDuration:duration autoreverses:autoreverses repeatCount:repeatCount fillMode:kCAFillModeForwards removedOnCompletion:NO functionName:kCAMediaTimingFunctionDefault];
    anim.values = values;
    
    return anim;
}

@end
