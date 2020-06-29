//
//  UIWindow+Helper.h
//  ProductTemplet
//
//  Created by BIN on 2018/9/30.
//  Copyright © 2018年 BN. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIWindow (Helper)

/**
 展示截屏反馈视图（UIImageView *imgView = [btn.superview viewWithTag:991];）
 */
- (UIButton *)showFeedbackView:(UIImage *)image title:(NSString *)title;

@end

NS_ASSUME_NONNULL_END
