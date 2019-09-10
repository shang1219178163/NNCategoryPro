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
 gift
 */
+ (void)showHUDAddedToView:(UIView *)view animated:(BOOL)animated;

/**
 推荐
 */
+ (void)showHUDinView:(UIView *)inView animated:(BOOL)animated;

/**
 推荐
 */
+ (void)showToastWithTips:(NSString *)tips place:(id)place;

+ (void)showToastWithTips:(NSString *)tips place:(id)place completion:(void(^)(BOOL didTap))completion;

+ (void)showToastWithTips:(NSString *)tips success:(NSNumber *)success place:(id)place completion:(void(^)(BOOL didTap))completion;

+ (void)showToastWithTips:(NSString *)tips image:(nullable id)image place:(id)place completion:(void(^)(BOOL didTap))completion;

/**
 展示截屏反馈视图（UIImageView *imgView = [btn.superview viewWithTag:991];）
 */
- (UIButton *)showFeedbackView:(UIImage *)image title:(NSString *)title;

@end

NS_ASSUME_NONNULL_END
