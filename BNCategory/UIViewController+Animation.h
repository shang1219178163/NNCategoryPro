//
//  UIViewController+Animation.h
//  
//
//  Created by BIN on 2018/8/9.
//  Copyright © 2018年 SHANG. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BNAnimationObject;

@interface UIViewController (Animation)<UIViewControllerTransitioningDelegate,UINavigationControllerDelegate>

+(BNAnimationObject *)animation;

- (void)pushController:(id)controller item:(UIView *)item type:(NSNumber *)type;

/**

 @param type 过度动画类型
 */
- (void)pushController:(id)controller rect:(CGRect)rect type:(NSNumber *)type;

- (void)presentController:(id)controller item:(UIView *)item type:(NSNumber *)type completion:(void (^ __nullable)(void))completion;

/**
 @param type 过度动画类型
 */
- (void)presentController:(id)controller rect:(CGRect)rect type:(NSNumber *)type completion:(void (^ __nullable)(void))completion;

@end



