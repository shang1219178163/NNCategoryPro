//
//  UIImageView+Animation.h
//  BNAnimation
//
//  Created by BIN on 2018/9/26.
//  Copyright © 2018年 whkj. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (Animation)
///持续翻转动画
- (void)addFlipAnimtion:(UIImage *)image backImage:(UIImage *)backImage;

@end

NS_ASSUME_NONNULL_END
