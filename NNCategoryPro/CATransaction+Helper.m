
//
//  CATransaction+Helper.m
//  VCTransitioning
//
//  Created by BIN on 2018/8/10.
//  Copyright © 2018年 Baymax. All rights reserved.
//

#import "CATransaction+Helper.h"

#import "CABasicAnimation+Helper.h"


@implementation CATransaction (Helper)

+(void)animDuration:(CGFloat)duration animation:(void(^)(void))animation completion:(void (^_Nullable)(void))completion{
    
    [CATransaction begin];
    [CATransaction setAnimationDuration:duration];
    animation();
    [CATransaction setCompletionBlock:completion];
    [CATransaction commit];
}

@end
