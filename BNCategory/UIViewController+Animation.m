//
//  UIViewController+Animation.m
//  
//
//  Created by BIN on 2018/8/9.
//  Copyright © 2018年 SHANG. All rights reserved.
//

#import "UIViewController+Animation.h"

#import <objc/runtime.h>
#import "BNAnimationObject.h"

@implementation UIViewController (Animation)

+(BNAnimationObject *)animation{
    BNAnimationObject * ani = objc_getAssociatedObject(self, _cmd);
    if (!ani) {
        ani = [[BNAnimationObject alloc]init];
        objc_setAssociatedObject(self, _cmd, ani, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return ani;
}


- (void)pushController:(id)controller item:(UIView *)item type:(NSNumber *)type{
    CGRect rect = [item convertRect:item.bounds toView:nil];
    [self pushController:controller rect:rect type:type];
    
}

- (void)pushController:(id)controller rect:(CGRect)rect type:(NSNumber *)type{
    if ([controller isKindOfClass:[NSString class]]) {
        controller = [NSClassFromString(controller) new];
    }
    
    UIViewController.animation.circleCenterRect = rect;
    self.navigationController.delegate = self;
    [self.navigationController pushViewController:controller animated:YES];
    
}

- (void)presentController:(id)controller item:(UIView *)item type:(NSNumber *)type completion:(void (^ __nullable)(void))completion{
    CGRect rect = [item convertRect:item.bounds toView:nil];
    [self presentController:controller rect:rect type:type completion:completion];
   
}

- (void)presentController:(id)controller rect:(CGRect)rect type:(NSNumber *)type completion:(void (^ __nullable)(void))completion{
    if ([controller isKindOfClass:[NSString class]]) {
        controller = [NSClassFromString(controller) new];
    }
    
    UIViewController.animation.circleCenterRect = rect;
    ((UIViewController *)controller).transitioningDelegate = self;//是否调用动画
    [self presentViewController:controller animated:YES completion:completion];
    
}

#pragma mark == 修改页面跳转效果 ==

- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                            animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC{
    
    UIViewController.animation.type = operation;
    return UIViewController.animation;
}

#pragma mark -- UIViewControllerTransitioningDelegate
//模态跳转时  从新赋予 动画对象
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    
    UIViewController.animation.type = UINavigationControllerOperationPush;
    return UIViewController.animation;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    
    UIViewController.animation.type = UINavigationControllerOperationPop;
    return UIViewController.animation;
}


@end


