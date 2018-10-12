//
//  UIView+Animation.h
//  HuiZhuBang
//
//  Created by BIN on 2018/5/9.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Animation)

- (void)BN_aimationBigValues:(NSArray *)values;

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
