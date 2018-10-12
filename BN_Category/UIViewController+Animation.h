//
//  UIViewController+Animation.h
//  HuiZhuBang
//
//  Created by BIN on 2018/8/9.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BN_AnimationObject;

@interface UIViewController (Animation)<UIViewControllerTransitioningDelegate,UINavigationControllerDelegate,UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) UITableView *tableView;

+(BN_AnimationObject *)animation;

/**

 @param type 过度动画类型
 */
- (void)pushViewController:(id)controller rect:(CGRect)rect type:(NSNumber *)type;
/**
 
 @param type 过度动画类型
 */
- (void)presentViewController:(id)controller rect:(CGRect)rect type:(NSNumber *)type completion:(void (^ __nullable)(void))completion;

#pragma mark - -UINavigationControllerDelegate

- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController;


#pragma mark -- UIViewControllerTransitioningDelegate

//模态跳转时  从新赋予 动画对象
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)sourc;

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed;

@end



