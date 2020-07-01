//
//  CATransition+Helper.h
//  
//
//  Created by BIN on 2018/9/12.
//  Copyright © 2018年 SHANG. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

NS_ASSUME_NONNULL_BEGIN
/// 立方体效果
FOUNDATION_EXPORT NSString * const kCATransitionCube ;
/// 阿拉神灯效果
FOUNDATION_EXPORT NSString * const kCATransitionSuckEffect ;
/// 上下左右翻转效果
FOUNDATION_EXPORT NSString * const kCATransitionOglFlip ;
/// 水滴效果
FOUNDATION_EXPORT NSString * const kCATransitionRippleEffect ;
/// 向上翻页效果
FOUNDATION_EXPORT NSString * const kCATransitionPageCurl ;
/// 向下翻页效果
FOUNDATION_EXPORT NSString * const kCATransitionPageUnCurl ;
/// 相机镜头打开效果
FOUNDATION_EXPORT NSString * const kCATransitionCameraIrisHollowOpen ;
/// 相机镜头关闭效果
FOUNDATION_EXPORT NSString * const kCATransitionCameraIrisHollowClose ;

@interface CATransition (Helper)

+ (CATransition *)animDuration:(CGFloat)duration
                  functionName:(CAMediaTimingFunctionName)name
                          type:(NSString *)type
                       subType:(CATransitionSubtype)subTyp;

@end

NS_ASSUME_NONNULL_END
