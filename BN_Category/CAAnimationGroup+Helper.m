//
//  CAAnimationGroup+Helper.m
//  ProductTemplet
//
//  Created by hsf on 2018/9/29.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "CAAnimationGroup+Helper.h"

@implementation CAAnimationGroup (Helper)

+(CAAnimationGroup *)animDuration:(CFTimeInterval)duration autoreverses:(BOOL)autoreverses repeatCount:(float)repeatCount fillMode:(NSString *)fillMode removedOnCompletion:(BOOL)removedOnCompletion{
    
    CAAnimationGroup *anim = [CAAnimationGroup animation];
    anim.duration = duration;
    anim.repeatCount = repeatCount;
    anim.fillMode = fillMode;
    anim.removedOnCompletion = removedOnCompletion;
    
    return anim;
    
}

+(CAAnimationGroup *)animList:(NSArray<CAAnimation *> *)list duration:(CFTimeInterval)duration autoreverses:(BOOL)autoreverses repeatCount:(float)repeatCount fillMode:(NSString *)fillMode removedOnCompletion:(BOOL)removedOnCompletion{
    
    CAAnimationGroup *anim = [CAAnimationGroup animDuration:duration autoreverses:autoreverses repeatCount:repeatCount fillMode:fillMode removedOnCompletion:removedOnCompletion];
    anim.animations = list;
    
    return anim;
    
}

+(CAAnimationGroup *)animList:(NSArray<CAAnimation *> *)list duration:(CFTimeInterval)duration autoreverses:(BOOL)autoreverses repeatCount:(float)repeatCount{
    
    CAAnimationGroup *anim = [CAAnimationGroup animDuration:duration autoreverses:autoreverses repeatCount:repeatCount fillMode:kCAFillModeForwards removedOnCompletion:NO];
    anim.animations = list;
    return anim;
    
}

@end
