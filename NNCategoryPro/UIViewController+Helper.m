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

UIViewController *UICtrFromString(NSString *obj){
    return [[NSClassFromString(obj) alloc]init];
}

UINavigationController *UINavCtrFromObj(id obj){
    if ([obj isKindOfClass:[UINavigationController class]]) {
        return obj;
    }
    else if ([obj isKindOfClass:[NSString class]]) {
        return [[UINavigationController alloc]initWithRootViewController:UICtrFromString(obj)];
    }
    else if ([obj isKindOfClass:[UIViewController class]]) {
        return [[UINavigationController alloc]initWithRootViewController:obj];
    }
    return nil;
}

#pragma make - -给控制器添加额外属性

-(UIViewController *)frontVC{
    UIViewController *viewController = nil;

    NSUInteger count = self.navigationController.viewControllers.count;
    if (count == 0) {
        return nil;
    }
    
    if (count == 1) {
        return self.navigationController.viewControllers.lastObject;
    }
    return self.navigationController.viewControllers[count - 2];
}

- (BOOL)isCurrentVisibleVC{
    return (self.isViewLoaded && self.view.window);
}

- (UIButton *)backBtn{
    UIButton *view = objc_getAssociatedObject(self, _cmd);
    if (!view) {
        view = [self createBackItem:[UIImage imageNamed:@"icon_arowLeft_black"]];
        objc_setAssociatedObject(self, _cmd, view, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return view;
}

- (void)setBackBtn:(UIButton *)backBtn{
    objc_setAssociatedObject(self, @selector(backBtn), backBtn, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
/**
 返回按钮专用
 */
- (UIButton *)createBackItem:(UIImage *)image{
    UIColor *tintColor = UINavigationBar.appearance.tintColor ? : UIColor.redColor;

    NSParameterAssert(image != nil);
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.adjustsImageWhenHighlighted = false;
    btn.frame = CGRectMake(0, 0, 30, 40);
    btn.imageEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);

    [btn setImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    btn.imageView.tintColor = tintColor;
    btn.highlighted = false;
    [btn addActionHandler:^(UIControl * _Nonnull control) {
        [self.navigationController popViewControllerAnimated:true];

    } forControlEvents:UIControlEventTouchUpInside];
//    [btn getViewLayer];
    return btn;
}

- (void)setupExtendedLayout{
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = UIColor.whiteColor;
    self.title = self.controllerName;
    
    if (@available(iOS 11.0, *)) {
        UIScrollView.appearance.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
        self.automaticallyAdjustsScrollViewInsets = false;
    }
}

- (void)setupContentInsetAdjustmentBehavior:(BOOL)isAutomatic{
    if (@available(iOS 11.0, *)) {
        UIScrollView.appearance.contentInsetAdjustmentBehavior = isAutomatic ? UIScrollViewContentInsetAdjustmentAutomatic : UIScrollViewContentInsetAdjustmentNever;
    }
}

- (void)present:(BOOL)animated completion:(void (^ __nullable)(void))completion{
    UIWindow *keyWindow = UIApplication.sharedApplication.delegate.window;
    dispatch_async(dispatch_get_main_queue(), ^{
        [keyWindow.rootViewController presentViewController:self animated:animated completion:completion];
    });
}

- (UISearchController *)createSearchVC:(UIViewController *)resultsController {
    self.definesPresentationContext = true;
    
    UISearchController *searchVC = [[UISearchController alloc]initWithSearchResultsController:resultsController];
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

/**
 [弃用]可隐藏的导航按钮
 */
- (UIButton *)createBarItemTitle:(NSString *)title
                         imgName:(NSString *)imgName
                          isLeft:(BOOL)isLeft
                        isHidden:(BOOL)isHidden
                         handler:(void(^)(id obj, UIButton * item, NSInteger idx))handler{
    UIButton *btn = nil;
    if (imgName) {
        NSParameterAssert([UIImage imageNamed:imgName]);
        btn = [UIButton buttonWithSize:CGSizeMake(32, 32)
                               image_N:imgName
                               image_H:nil
                       imageEdgeInsets:UIEdgeInsetsZero];
        
    }
    else{
        btn = [UIButton buttonWithSize:CGSizeMake(40, 40)
                                 title:title
                                  font:15
                          titleColor_N:nil
                          titleColor_H:nil
                       titleEdgeInsets:UIEdgeInsetsZero];
        btn.titleLabel.textColor = UINavigationBar.appearance.tintColor;
    }
    
    btn.tag = isLeft  ? kTAG_BTN_BackItem : kTAG_BTN_RightItem;
    btn.hidden = isHidden;
    //
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    view.hidden = isHidden;
    btn.center = view.center;
    [view addSubview:btn];
    
    //父视图调用子视图方法参数    
    [view addGestureTap:^(UIGestureRecognizer * _Nonnull reco) {
        if (btn.isHidden == 1) return ;
        handler(reco, btn, btn.tag);
    }];
    
    [btn addActionHandler:^(id obj, id item, NSInteger idx) {
        if (btn.isHidden == 1) return ;

        if (handler) {
            handler(obj, item, ((UIButton *)item).tag);
        }
    }];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:view];
    if (isLeft) {
        self.navigationItem.leftBarButtonItem = item;
    }
    else{
        self.navigationItem.rightBarButtonItem = item;
    }
    return btn;
}

/**
 可隐藏的导航栏按钮
 */
- (UIView *)createBarItem:(NSString *)obj isLeft:(BOOL)isLeft handler:(void(^)(id obj, UIView *item, NSInteger idx))handler{
    UIView * item = nil;
    if ([UIImage imageNamed:obj]) {
        item = [UIImageView createRect:CGRectMake(0, 0, 32, 32) type:@0];
        ((UIImageView *)item).image = [UIImage imageNamed:obj];
    }
    else{
        item = [UILabel createRect:CGRectMake(0, 0, 72, 20) type:@1];
        ((UILabel *)item).text = obj;
        ((UILabel *)item).font = [UIFont systemFontOfSize:kFontSize16];
        ((UILabel *)item).textAlignment = NSTextAlignmentCenter;
        ((UILabel *)item).textColor = UINavigationBar.appearance.tintColor;
    }
    
    item.tag = isLeft ? kTAG_BTN_BackItem : kTAG_BTN_RightItem;
    //
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    item.center = view.center;
    [view addSubview:item];
    
    [view addGestureTap:^(UIGestureRecognizer *sender) {
        if (view.isHidden == true) return;
        if (handler) {
            handler((UITapGestureRecognizer *)obj, item, item.tag);
        }
    }];
   
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc]initWithCustomView:view];
    if (isLeft) {
        self.navigationItem.leftBarButtonItem = barItem;
    }
    else{
        self.navigationItem.rightBarButtonItem = barItem;
    }
    return view;
}

- (void)pushVC:(NSString *)vcName
         title:(NSString *)title
      animated:(BOOL)animated
         block:(void(^)(__kindof UIViewController *vc))block{
    UIViewController *controller = [[NSClassFromString(vcName) alloc]init];
    return [self pushVCType:controller.class
                      title:title
                   animated:animated
                      block:block];
}

- (void)pushVCType:(Class)classVC
             title:(NSString *)title
          animated:(BOOL)animated
             block:(void(^)(__kindof UIViewController *vc))block{
    UIViewController *controller = [[classVC alloc]init];
    controller.title = [title stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (block) {
        block(controller);
    }
    [self.navigationController pushViewController:controller animated:animated];
}

- (void)presentVC:(NSString *)vcName
            title:(NSString *)title
         animated:(BOOL)animated
            block:(void(^)(__kindof UIViewController *vc))block{
    UIViewController *controller = [[NSClassFromString(vcName) alloc]init];
    return [self presentVC:controller.class
                     title:title
                  animated:animated
                     block:block];
}

- (void)presentVCType:(Class)classVC
                title:(NSString *)title
             animated:(BOOL)animated
                block:(void(^)(__kindof UIViewController *vc))block{
    UIViewController *controller = [[classVC alloc]init];
    controller.title = [title stringByReplacingOccurrencesOfString:@" " withString:@""];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:controller];
    if (block) {
        block(controller);
    }
    [self presentViewController:navController animated:animated completion:^{
        
    }];
}

-(NSString *)controllerName{
    NSString *className = NSStringFromClass(self.class);
    if ([className containsString:@"Controller"]) {
        NSRange range = NSMakeRange(0, 0);
        if ([className rangeOfString:@"ViewController"].location != NSNotFound) {
            range = [className rangeOfString:@"ViewController"];
        }
        else if ([className rangeOfString:@"Controller"].location != NSNotFound){
            range = [className rangeOfString:@"Controller"];
        }
        className = [className substringToIndex:range.location];
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
    
    if ([rootVC presentedViewController]) {
        // 视图是被presented出来的
        rootVC = [rootVC presentedViewController];
    }
    
    if ([rootVC isKindOfClass:[UITabBarController class]]) {
        // 根视图为UITabBarController
        currentVC = [self getCurrentVCFrom:[(UITabBarController *)rootVC selectedViewController]];
    }
    else if ([rootVC isKindOfClass:[UINavigationController class]]){
        // 根视图为UINavigationController
        currentVC = [self getCurrentVCFrom:[(UINavigationController *)rootVC visibleViewController]];
    }
    else {
        // 根视图为非导航类
        currentVC = rootVC;
    }
    return currentVC;
}

- (UIViewController *)addControllerName:(NSString *)className{
    UIViewController *controller = [NSClassFromString(className) new];
    [self addControllerVC:controller];
    return controller;
}

/// 添加子控制器(对应方法 removeControllerVC)
- (void)addControllerVC:(UIViewController *)controller{
    [self addChildViewController:controller];
    [self.view addSubview:controller.view];
    controller.view.frame = self.view.bounds;
    [controller didMoveToParentViewController:self];
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

/**
 设置导航栏背景色
 透明色与self.edgesForExtendedLayout = UIRectEdgeAll;搭配使用
 */
- (void)setupNavigationBarBackgroundImage:(UIImage *)image{
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:image];
}


@end


@implementation UINavigationController (Helper)

- (__kindof UIViewController * _Nullable)findController:(Class)classVC{
    __block UIViewController *controller = nil;
    [self.viewControllers enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass: classVC]) {
            controller = obj;
            *stop = YES;
        }
    }];
    return controller;
}

- (__kindof UIViewController * _Nullable)findControllerName:(NSString *)vcName{
    Class class = NSClassFromString(vcName);
    return [self findController:class];
}


@end
