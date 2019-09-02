
//
//  CATransition+Helper.m
//  
//
//  Created by BIN on 2018/9/12.
//  Copyright © 2018年 SHANG. All rights reserved.
//

#import "CATransition+Helper.h"

#import "CABasicAnimation+Helper.h"

NSString * const kCATransitionCube = @"cube";
NSString * const kCATransitionSuckEffect = @"suckEffect";
NSString * const kCATransitionOglFlip = @"oglFlip";
NSString * const kCATransitionRippleEffect = @"rippleEffect";
NSString * const kCATransitionPageCurl = @"pageCurl";
NSString * const kCATransitionPageUnCurl = @"pageUnCurl";
NSString * const kCATransitionCameraIrisHollowOpen = @"cameraIrisHollowOpen";
NSString * const kCATransitionCameraIrisHollowClose = @"cameraIrisHollowClose";

@implementation CATransition (Helper)

/**
 [源]CATransition(可用于页面跳转)
 @param type 必须是CATransitionType类型/kCATransition开头的常量

 */
+ (CATransition *)animDuration:(CGFloat)duration functionName:(CAMediaTimingFunctionName)name type:(NSString *)type subType:(CATransitionSubtype)subType {
    
    CATransition *anim = [CATransition animation];
    //动画时间
    anim.duration = duration;
    //设置运动的速度轨迹
    anim.timingFunction = [CAMediaTimingFunction functionWithName:name];
    anim.type = type;//过渡效果
    anim.subtype = subType;//过渡方向[kCATransitionFromTop,kCATransitionFromLeft,kCATransitionFromBottom,kCATransitionFromRight,];
//    [self.view.layer addAnimation:animation forKey:nil];
//    [UIApplication.sharedApplication.keyWindow.layer addAnimation:anim forKey:nil];
    return anim;
}


@end
