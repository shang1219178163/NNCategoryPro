//
//  UIViewController+Animation.h
//  
//
//  Created by BIN on 2018/8/9.
//  Copyright © 2018年 SHANG. All rights reserved.
//
/*
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class NNAnimationObject;

@interface UIViewController (Animation)<UIViewControllerTransitioningDelegate, UINavigationControllerDelegate>

+(NNAnimationObject *)animation;

- (void)pushController:(id)controller
                 title:(NSString *)title
                  item:(UIView *)item
                  type:(NSNumber *)type;

///type 过度动画类型
- (void)pushController:(id)controller
                 title:(NSString *)title
                  rect:(CGRect)rect
                  type:(NSNumber *)type;
///type 过度动画类型
- (void)presentController:(id)controller
                    title:(NSString *)title
                     item:(UIView *)item
                     type:(NSNumber *)type
               completion:(void (^ _Nullable)(void))completion;

///type 过度动画类型
- (void)presentController:(id)controller
                    title:(NSString *)title
                     rect:(CGRect)rect
                     type:(NSNumber *)type
               completion:(void (^ _Nullable)(void))completion;

@end

NS_ASSUME_NONNULL_END
*/
