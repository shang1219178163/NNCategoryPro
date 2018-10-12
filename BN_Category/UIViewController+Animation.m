//
//  UIViewController+Animation.m
//  HuiZhuBang
//
//  Created by BIN on 2018/8/9.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//

#import "UIViewController+Animation.h"

#import <objc/runtime.h>
#import "BN_AnimationObject.h"


@interface UIViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation UIViewController (Animation)

@dynamic tableView;

+(BN_AnimationObject *)animation{
    BN_AnimationObject * ani = objc_getAssociatedObject(self, _cmd);
    if (!ani) {
        ani = [[BN_AnimationObject alloc]init];
        objc_setAssociatedObject(self, _cmd, ani, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return ani;
}

- (UITableView *)tableView {
    UITableView* table = objc_getAssociatedObject(self, _cmd);
    if (table == nil) {
        table = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        [table registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
        table.layer.borderColor = UIColor.grayColor.CGColor;
        table.layer.borderWidth = 1;
        table.delegate = self;
        table.dataSource = self;
        objc_setAssociatedObject(self, _cmd, table, OBJC_ASSOCIATION_RETAIN);
    }
    return table;
}

- (void)pushViewController:(id)controller rect:(CGRect)rect type:(NSNumber *)type{
    if ([controller isKindOfClass:[NSString class]]) {
        controller = [NSClassFromString(controller) new];
    }
    
    UIViewController.animation.circleCenterRect = rect;
    self.navigationController.delegate = self;
    [self.navigationController pushViewController:controller animated:YES];
    
}

- (void)presentViewController:(id)controller rect:(CGRect)rect type:(NSNumber *)type completion:(void (^ __nullable)(void))completion{
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


