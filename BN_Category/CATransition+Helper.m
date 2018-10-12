
//
//  CATransition+Helper.m
//  HuiZhuBang
//
//  Created by BIN on 2018/9/12.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//

#import "CATransition+Helper.h"

#import "CABasicAnimation+Helper.h"

@implementation CATransition (Helper)

+ (CATransition *)animDuration:(CGFloat)duration functionName:(NSString *)name type:(NSString *)type subType:(id)subType {
    
    NSArray * array = @[kCATransitionFromTop,kCATransitionFromLeft,kCATransitionFromBottom,kCATransitionFromRight,];
    NSAssert([subType isKindOfClass:[NSString class]] && [array containsObject:subType] || [subType isKindOfClass:[NSNumber class]] && array.count > [subType integerValue], @"动画方向错误!");
    
    if ([subType isKindOfClass:[NSNumber class]] && array.count > [subType integerValue]) {
        subType = array[[subType integerValue]];
        
    }
    
    CATransition *anim = [CATransition animation];
    //动画时间
    anim.duration = duration;
    name = [CABasicAnimation.functionNames containsObject:name] ? name : CABasicAnimation.functionNames.firstObject;
    anim.timingFunction = [CAMediaTimingFunction functionWithName:name];
    
    anim.type = type;//过渡效果
    anim.subtype = subType;//过渡方向
    //    [self.view.layer addAnimation:animation forKey:nil];
    return anim;
}

@end
