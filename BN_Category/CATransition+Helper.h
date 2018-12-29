//
//  CATransition+Helper.h
//  
//
//  Created by BIN on 2018/9/12.
//  Copyright © 2018年 SHANG. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

FOUNDATION_EXPORT NSString * const kCATransitionCube ;
FOUNDATION_EXPORT NSString * const kCATransitionSuckEffect ;
FOUNDATION_EXPORT NSString * const kCATransitionOglFlip ;
FOUNDATION_EXPORT NSString * const kCATransitionRippleEffect ;
FOUNDATION_EXPORT NSString * const kCATransitionPageCurl ;
FOUNDATION_EXPORT NSString * const kCATransitionPageUnCurl ;
FOUNDATION_EXPORT NSString * const kCATransitionCameraIrisHollowOpen ;
FOUNDATION_EXPORT NSString * const kCATransitionCameraIrisHollowClose ;

@interface CATransition (Helper)

+ (CATransition *)animDuration:(CGFloat)duration functionName:(NSString *)name type:(NSString *)type subType:(id)subTyp;

@end
