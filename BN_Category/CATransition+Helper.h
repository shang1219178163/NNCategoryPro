//
//  CATransition+Helper.h
//  HuiZhuBang
//
//  Created by BIN on 2018/9/12.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

static NSString * const kCATransitionCube = @"cube";
static NSString * const kCATransitionSuckEffect = @"suckEffect";
static NSString * const kCATransitionOglFlip = @"oglFlip";
static NSString * const kCATransitionRippleEffect = @"rippleEffect";
static NSString * const kCATransitionPageCurl = @"pageCurl";
static NSString * const kCATransitionPageUnCurl = @"pageUnCurl";
static NSString * const kCATransitionCameraIrisHollowOpen = @"cameraIrisHollowOpen";
static NSString * const kCATransitionCameraIrisHollowClose = @"cameraIrisHollowClose";

@interface CATransition (Helper)

+ (CATransition *)animDuration:(CGFloat)duration functionName:(NSString *)name type:(NSString *)type subType:(id)subTyp;

@end
