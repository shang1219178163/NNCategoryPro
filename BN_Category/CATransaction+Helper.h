//
//  CATransaction+Helper.h
//  VCTransitioning
//
//  Created by BIN on 2018/8/10.
//  Copyright © 2018年 Baymax. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface CATransaction (Helper)


+(void)animDuration:(CGFloat)duration animations:(void(^)(void))animations completion:(nullable void (^)(void))completion;

+ (CATransition *)animDuration:(CGFloat)duration functionName:(NSString *)name type:(NSString *)type subType:(id)subType;


@end
