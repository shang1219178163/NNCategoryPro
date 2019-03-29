
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

+(void)animDuration:(CGFloat)duration animations:(void(^)(void))animations completion:(nullable void (^)(void))completion{
    
    [CATransaction begin];
    [CATransaction setAnimationDuration:duration];
    animations();
    [CATransaction setCompletionBlock:completion];
    [CATransaction commit];
}

@end
