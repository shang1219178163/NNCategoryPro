//
//  UIViewController+Helper.m
//  
//
//  Created by BIN on 2017/8/14.
//  Copyright © 2017年 SHANG. All rights reserved.
//

#import "UIViewController+Helper.h"
#import <objc/runtime.h>
#import <StoreKit/StoreKit.h>
#import <NNGloble/NNGloble.h>

#import "NSObject+Helper.h"
#import "UIApplication+Helper.h"
#import "UIAlertController+Helper.h"

#import "UIView+Helper.h"
#import "UIBarButtonItem+Helper.h"
#import "UIButton+Helper.h"
#import "UIControl+Helper.h"
#import "UIImageView+Helper.h"
#import "UILabel+Helper.h"
#import "UIScreen+Helper.h"

@implementation UIViewController (Helper)

UIViewController *UIControllerFromString(NSString *value){
    return [[NSClassFromString(value) alloc]init];
}

UINavigationController * _Nullable UINavCtrFromObj(NSString *value){
    UIViewController *vc = [[NSClassFromString(value) alloc]init];;
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return (UINavigationController *)vc;
    }
    
    if ([vc isKindOfClass:[UIViewController class]]) {
        return [[UINavigationController alloc]initWithRootViewController:vc];
    }
    return nil;
}

- (BOOL)isCurrentVisibleVC{
    return (self.isViewLoaded && self.view.window);
}

/// 返回按钮专用
- (UIButton *)createBackItem:(UIImage *)image{
    UIColor *tintColor = UINavigationBar.appearance.tintColor ? : UIColor.blackColor;

//    NSParameterAssert(image != nil);
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.adjustsImageWhenHighlighted = false;
    btn.frame = CGRectMake(0, 0, 30, 40);
    btn.imageEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);

    [btn setImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    btn.imageView.tintColor = tintColor;
    btn.highlighted = false;
    [btn addActionHandler:^(UIButton * _Nonnull sender) {
        [self.navigationController popViewControllerAnimated:true];

    } forControlEvents:UIControlEventTouchUpInside];
//    [btn getViewLayer];
    return btn;
}

- (void)setupContentInsetAdjustmentBehavior:(BOOL)isAutomatic{
    if (@available(iOS 11.0, *)) {
//        UIScrollView.appearance.contentInsetAdjustmentBehavior = isAutomatic ? UIScrollViewContentInsetAdjustmentAutomatic : UIScrollViewContentInsetAdjustmentNever;
        UIScrollView *scrollView = [self.view findSubviewType:UIScrollView.class].firstObject;
        scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = false;
    }
}

- (void)present:(BOOL)animated completion:(void (^ __nullable)(void))completion{
    UIWindow *keyWindow = UIApplication.sharedApplication.keyWindow ? : UIApplication.sharedApplication.windows.firstObject;
    self.modalPresentationStyle = UIModalPresentationOverFullScreen;
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([self isKindOfClass:UIAlertController.class]) {
            UIAlertController *alertVC = (UIAlertController *)self;
            if (alertVC.preferredStyle == UIAlertControllerStyleAlert) {
                if (alertVC.actions.count == 0) {
                    [keyWindow.rootViewController presentViewController:alertVC animated:animated completion:^{
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(kDurationToast * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            [alertVC dismissViewControllerAnimated:animated completion:completion];
                        });
                    }];
                } else {
                    [keyWindow.rootViewController presentViewController:alertVC animated:animated completion:completion];
                }
            } else {
                //防止 ipad 下 sheet 会崩溃的问题
                if (UIDevice.currentDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad) {
                    UIPopoverPresentationController *popoverPresentationController = alertVC.popoverPresentationController;
                    if (popoverPresentationController) {
                        popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionAny;
                        popoverPresentationController.sourceView = keyWindow;
                        CGRect sourceRect = popoverPresentationController.sourceRect;
                        if (CGRectIsEmpty(sourceRect) || CGRectEqualToRect(sourceRect, CGRectZero)) {
                            popoverPresentationController.sourceRect = CGRectMake(CGRectGetMidX(keyWindow.bounds), 64, 1, 1);
                        }
                    }
                }
                [keyWindow.rootViewController presentViewController:alertVC animated:animated completion:completion];
            }

        } else {
            [keyWindow.rootViewController presentViewController:self animated:animated completion:completion];
        }
    });
}

- (BOOL)pushFromVC:(Class)cls{    
    NSArray *viewControllers = self.navigationController.viewControllers;
    if (viewControllers.count <= 1) {
        return false;
    }
    
    NSInteger index = [viewControllers indexOfObject:self];
    BOOL result = [viewControllers[index - 1] isMemberOfClass:cls];
    return result;
}

- (UISearchController *)createSearchVC:(UIViewController *)resultsVC {
    self.definesPresentationContext = true;
    
    UISearchController *searchVC = [[UISearchController alloc]initWithSearchResultsController:resultsVC];
//    searchVC.view.backgroundColor = [UIColor.whiteColor colorWithAlphaComponent:1];
    
    //是否添加半透明覆盖层
    searchVC.dimsBackgroundDuringPresentation = true;
    if (@available(iOS 9.1, *)) {
        searchVC.obscuresBackgroundDuringPresentation = true;
    }
//    //是否隐藏导航栏
//    searchVC.hidesNavigationBarDuringPresentation = YES;
    
    searchVC.searchBar.barStyle = UIBarStyleDefault;
    searchVC.searchBar.translucent = YES;
    if (@available(iOS 13.0, *)) {
        
    } else {
        [searchVC.searchBar setValue:@"取消" forKey:@"_cancelButtonText"];
    }
//    searchVC.searchBar.barTintColor = UIColor.brownColor;
//    searchVC.searchBar.tintColor = UIColor.redColor;
    // searchController.searchBar.layer.borderColor = [UIColor redColor].CGColor;
    //searchController.searchResultsUpdater = result;
    
    searchVC.searchBar.placeholder = @"搜索";
    return searchVC;
}

-(NSString *)vcName{
    NSString *className = NSStringFromClass(self.class);
    if (![className hasSuffix:@"Controller"]) {
        return className;
    }
    if ([className hasSuffix:@"ViewController"]) {
        return [className stringByReplacingOccurrencesOfString:@"ViewController" withString:@""];
    }
    return className;
}

//当前屏幕显示的viewcontroller
-(UIViewController *)currentVC{
    UIViewController *rootViewController = UIApplication.sharedApplication.keyWindow.rootViewController;
    UIViewController *controller = [self getCurrentVCFrom:rootViewController];
    if ([controller isKindOfClass:[UISearchController class]]) controller = self;
    
    return controller;
}

//查找Window当前显示的ViewController
- (UIViewController *)getCurrentVCFrom:(UIViewController *)rootVC{
    UIViewController *currentVC;
    
    if ([rootVC presentedViewController]) { // 视图是被presented出来的
        rootVC = [rootVC presentedViewController];
    }
    
    if ([rootVC isKindOfClass:[UITabBarController class]]) { // 根视图为UITabBarController
        currentVC = [self getCurrentVCFrom:[(UITabBarController *)rootVC selectedViewController]];
    }
    else if ([rootVC isKindOfClass:[UINavigationController class]]){ // 根视图为UINavigationController
        currentVC = [self getCurrentVCFrom:[(UINavigationController *)rootVC visibleViewController]];
    }
    else { // 根视图为非导航类
        currentVC = rootVC;
    }
    return currentVC;
}

- (UIViewController *)addControllerName:(NSString *)vcName{
    UIViewController *vc = [NSClassFromString(vcName) new];
    [self addControllerVC:vc];
    return vc;
}

/// 添加子控制器(对应方法 removeControllerVC)
- (void)addControllerVC:(UIViewController *)vc{
    [self addChildViewController:vc];
    [self.view addSubview:vc.view];
    vc.view.frame = self.view.bounds;
    vc.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [vc didMoveToParentViewController:self];
}

/// 移除添加的子控制器(对应方法 addControllerVC)
- (void)removeFromSuperVC{
    [self willMoveToParentViewController:nil];//子控制器被通知即将解除父子关系
    [self.view removeFromSuperview];//把子控制器的 view 从到父控制器的 view 上面移除
    [self removeFromParentViewController];//真正的解除关系,会自己调用 [self.vc1 didMoveToParentViewController:nil]
}

/// 显示controller(手动调用viewWillAppear和viewDidAppear,viewWillDisappear)
- (void)transitionToVC:(UIViewController *)controller {
    [self beginAppearanceTransition:NO animated:YES];  //调用self的 viewWillDisappear:
    [controller beginAppearanceTransition:YES animated:YES];  //调用VC的 viewWillAppear:
    [self endAppearanceTransition]; //调用self的viewDidDisappear:
    [controller endAppearanceTransition]; //调用VC的viewDidAppear:
    /*
     isAppearing 设置为 true : 触发 viewWillAppear:;
     isAppearing 设置为 false : 触发 viewWillDisappear:;
     endAppearanceTransition方法会基于我们传入的isAppearing来调用viewDidAppear:以及viewDidDisappear:方法
     */
}

- (void)popGestureClose{
    // 禁用侧滑返回手势
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        //这里对添加到右滑视图上的所有手势禁用
        for (UIGestureRecognizer *popGesture in self.navigationController.interactivePopGestureRecognizer.view.gestureRecognizers) {
            popGesture.enabled = NO;
        }
        //若开启全屏右滑，不能再使用下面方法，请对数组进行处理
        //self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}

- (void)popGestureOpen{
    // 启用侧滑返回手势
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
    //这里对添加到右滑视图上的所有手势启用
        for (UIGestureRecognizer *gesture in self.navigationController.interactivePopGestureRecognizer.view.gestureRecognizers) {
            gesture.enabled = YES;
        }
        //若开启全屏右滑，不能再使用下面方法，请对数组进行处理
        //self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
}


@end


@implementation UINavigationController (Helper)

- (__kindof UIViewController * _Nullable)findVC:(Class)classVC{
    __block UIViewController *controller = nil;
    [self.viewControllers enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass: classVC]) {
            controller = obj;
            *stop = YES;
        }
    }];
    return controller;
}

- (__kindof UIViewController * _Nullable)findVCName:(NSString *)vcName{
    Class class = NSClassFromString(vcName);
    return [self findVC:class];
}


@end
