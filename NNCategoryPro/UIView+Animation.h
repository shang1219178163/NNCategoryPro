//
//  UIView+Animation.h
//  
//
//  Created by BIN on 2018/5/9.
//  Copyright © 2018年 SHANG. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Animation)

/// [源] 往返旋转图像
- (void)transformRotationCycle:(CGFloat)duration angle:(CGFloat)angle;
/// 往返旋转图像(默认180°)
- (void)transformRotationCycle:(CGFloat)duration;

- (void)aimationBigValues:(NSArray *)values;

- (CAAnimationGroup *)addAnimationBigShapeWithColor:(UIColor *)color;

- (void)animationWithTransition:(UIViewAnimationTransition)transition duration:(CGFloat)duration;

- (UIColor *)noClearColor;

#pragma mark - -Login

- (void)addAnimLoginHandler:(void(^)(void))handler;

#pragma mark - -ShopingCart

@property (nonatomic, strong) NSMutableArray *keepList;
@property (nonatomic, strong) NSMutableArray *cacheList;

- (CAAnimationGroup *)addAnimCartWithSender:(UIView *)sender pointEnd:(CGPoint)pointEnd;

@end

NS_ASSUME_NONNULL_END
