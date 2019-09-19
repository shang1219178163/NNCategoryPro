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

#import "NNGloble.h"

#import "NSObject+Helper.h"
#import "UIApplication+Helper.h"
#import "UIAlertController+Helper.h"

#import "UIView+Helper.h"
#import "UIButton+Helper.h"
#import "UIScreen+Helper.h"
#import "UIControl+Helper.h"

@implementation UIViewController (Helper)

@dynamic delegate;

UIViewController * UICtrFromString(NSString *obj){
    return [[NSClassFromString(obj) alloc]init];
}

UINavigationController * UINavCtrFromObj(id obj){
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

#pragma make - - 给控制器添加额外属性

-(UIViewController *)frontVC{
    return objc_getAssociatedObject(self, _cmd);
}

-(void)setFrontVC:(UIViewController *)frontVC{
    objc_setAssociatedObject(self, @selector(frontVC), frontVC, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(id)obj{
    return objc_getAssociatedObject(self, _cmd);
}

-(void)setObj:(id)obj{
    objc_setAssociatedObject(self, @selector(obj), obj, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(id)objModel{
    return objc_getAssociatedObject(self, _cmd);
}

-(void)setObjModel:(id)objModel{
    objc_setAssociatedObject(self, @selector(objModel), objModel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(id)objOne{
    return objc_getAssociatedObject(self, _cmd);
}

-(void)setObjOne:(id)objOne{
    objc_setAssociatedObject(self, @selector(objOne), objOne, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(NSTimeInterval)timeInterval{
    return [objc_getAssociatedObject(self, _cmd) doubleValue];
}

-(void)setTimeInterval:(NSTimeInterval)timeInterval{
    objc_setAssociatedObject(self, @selector(timeInterval), @(timeInterval), OBJC_ASSOCIATION_ASSIGN);
}


#pragma make - - 声明代码块

-(BlockAlertController)blockAlertController{
    return objc_getAssociatedObject(self, _cmd);
}

-(void)setBlockAlertController:(BlockAlertController)blockAlertController{
    objc_setAssociatedObject(self, @selector(blockAlertController), blockAlertController, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

#pragma make - -网络请求失败加载图

- (void)addFailRefreshViewWithTitle:(NSString *)title{
    UIView * view = [self refreshViewWithTitle:title type:@0 inView:self.view];
    [self.view addSubview:view];
    [self.view bringSubviewToFront:view];
}

- (void)removeFailRefreshView:(UIView *)inView{
    inView = inView ? : self.view;
    
    if ([inView viewWithTag:20178015] && [inView viewWithTag:20181019]) {
        UIView *view = [inView viewWithTag:20178015];
        UIView *viewNoData = [inView viewWithTag:20181019];
        view.hidden = YES;
        viewNoData.hidden = YES;
        return;
    }
    
    UIView *view = [inView viewWithTag:20178015];
    if (view) {
        view.hidden = YES;
    }
    
    UIView *viewNoData = [inView viewWithTag:20181019];
    if (viewNoData){
        viewNoData.hidden = YES;
    }
}

- (void)removeFailRefreshView{
    if ([self.view viewWithTag:20178015] && [self.view viewWithTag:20181019]) {
        UIView *view = [self.view viewWithTag:20178015];
        UIView *viewNoData = [self.view viewWithTag:20181019];
        view.hidden = YES;
        viewNoData.hidden = YES;
        return;
    }
        
    UIView *view = [self.view viewWithTag:20178015];
    if (view) {
        view.hidden = YES;
    }
    
    UIView *viewNoData = [self.view viewWithTag:20181019];
    if (viewNoData){
         viewNoData.hidden = YES;
    }
    
}

- (void)addNoDataRefreshViewWithTitle:(NSString *)title{
    UIView * view = [self refreshViewWithTitle:title type:@1 inView:self.view];
    [self.view addSubview:view];
    [self.view bringSubviewToFront:view];
    
}

- (void)addNoDataRefreshViewWithTitle:(NSString *)title inView:(UIView *)inView{
    inView = inView ? : self.view;
    UIView * view = [self refreshViewWithTitle:title type:@1 inView:inView];
    [inView addSubview:view];
    [inView bringSubviewToFront:view];
    
}

- (UIView *)refreshViewWithTitle:(NSString *)title type:(NSNumber *)type inView:(UIView *)inView{
    NSDictionary * dic  = @{
                            @0: @"img_request_Failed",
                            @1: @"img_NoData",
                            };
    
    UIView *view = [inView viewWithTag:20181019];
    if (view) {
        view.hidden = NO;
        return view;
    }
    
    view = [[UIView alloc] initWithFrame:inView.bounds];
    view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    view.tag = 20181019;
    view.backgroundColor = UIColor.whiteColor;
    
    UIImage * image = [UIImage imageNamed:dic[type]];
    CGSize imgSize = CGSizeMake(65, 75);
    if (image.size.width > imgSize.width) {
        if (image.scale < 2) {
            imgSize = CGSizeMake(image.size.width*0.5, image.size.height*0.5);
            
        }
    }
    
    
    CGRect imgViewRect = CGRectMake((CGRectGetWidth(inView.bounds) - imgSize.width)/2.0, (CGRectGetHeight(inView.bounds) - imgSize.height)/2.0, imgSize.width, imgSize.height);
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:imgViewRect];
    imageView.image = image;
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.userInteractionEnabled = YES;
    
    UILabel * tipLabel = [[UILabel alloc]initWithFrame:CGRectMake(kX_GAP, CGRectGetMaxY(imgViewRect)+5, CGRectGetWidth(inView.bounds) - 2*kX_GAP, 30)];
    tipLabel.text = title ? : @"";
    tipLabel.font = [UIFont systemFontOfSize:15];
    tipLabel.textAlignment = NSTextAlignmentCenter;
    tipLabel.backgroundColor = UIColor.whiteColor;
    tipLabel.userInteractionEnabled = YES;
    
    //    tipLabel.backgroundColor = UIColor.yellowColor;
    //    imageView.backgroundColor = UIColor.greenColor;
    
    [view addSubview:tipLabel];
    [view addSubview:imageView];
    
    if ([self respondsToSelector:@selector(failRefresh)]) {
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(failRefresh)];
        
        tapGesture.numberOfTouchesRequired = 1;
        
        tapGesture.cancelsTouchesInView = NO;
        tapGesture.delaysTouchesEnded = NO;
        [view addGestureRecognizer:tapGesture];
    }
    return view;
}


/**
 [弃用]可隐藏的导航按钮
 */
- (UIButton *)createBarItemTitle:(NSString *)title imgName:(NSString *)imgName isLeft:(BOOL)isLeft isHidden:(BOOL)isHidden handler:(void(^)(id obj, UIButton * item, NSInteger idx))handler{
    UIButton * btn = nil;
    if (imgName) {
        NSParameterAssert([UIImage imageNamed:imgName]);
        btn = [UIButton buttonWithSize:CGSizeMake(32, 32) image_N:imgName image_H:nil imageEdgeInsets:UIEdgeInsetsZero];
        
    }
    else{
        btn = [UIButton buttonWithSize:CGSizeMake(40, 40) title:title font:15 titleColor_N:nil titleColor_H:nil titleEdgeInsets:UIEdgeInsetsZero];
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
        
        if (NSDate.date.timeIntervalSince1970 - self.timeInterval < 1) return;
        if (self.timeInterval > 0) self.timeInterval = NSDate.date.timeIntervalSince1970;
        
        handler(reco, btn, btn.tag);
    }];
    
    [btn addActionHandler:^(id obj, id item, NSInteger idx) {
        if (btn.isHidden == 1) return ;

        if (NSDate.date.timeIntervalSince1970 - self.timeInterval < 1) return;
        if (self.timeInterval > 0) self.timeInterval = NSDate.date.timeIntervalSince1970;

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
        item = [UIImageView createImgViewRect:CGRectMake(0, 0, 32, 32) type:@0];
        ((UIImageView *)item).image = [UIImage imageNamed:obj];
    }
    else{
        item = [UILabel createLabelRect:CGRectMake(0, 0, 72, 20) type:@1];
        ((UILabel *)item).text = obj;
        ((UILabel *)item).font = [UIFont systemFontOfSize:kFontSize16];
        ((UILabel *)item).textAlignment = NSTextAlignmentCenter;
        ((UILabel *)item).textColor = UINavigationBar.appearance.tintColor;
    }
    
    item.tag = isLeft ? kTAG_BTN_BackItem : kTAG_BTN_RightItem;
    //
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
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

- (UITableViewCell *)cellByClickView:(UIView *)view{
    UIView * supView = [view superview];
    while (![supView isKindOfClass:[UITableViewCell class]]) {
        
        supView = [supView superview];
    }
    UITableViewCell * tableViewCell = (UITableViewCell *)supView;
    return tableViewCell;
}

- (NSIndexPath *)indexPathByClickView:(UIView *)view tableView:(UITableView *)tableView{
    UITableViewCell * cell = [self cellByClickView:view];
    NSIndexPath * indexPath = [tableView indexPathForRowAtPoint:cell.center];
//    DDLog(@"%@",indexPath);
    return indexPath;
}

- (BOOL)isCurrentVisibleViewController{
    return (self.isViewLoaded && self.view.window);
}

- (id)findController:(NSString *)contollerName navController:(UINavigationController *)navController{
    if (!navController) {
        navController = self.currentVC.navigationController;
        
    }
    
    __block UIViewController * controller = nil;
    [navController.viewControllers enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[NSClassFromString(contollerName) class]]) {
            controller = obj;
            *stop = YES;
        }
    }];
    return controller;
}

- (void)goController:(NSString *)contollerName title:(NSString *)title navController:(UINavigationController *)navController obj:(id)obj objOne:(id)objOne{
    
    NSParameterAssert(![contollerName isEqualToString:@""]);
    if (!navController) {
        navController = self.currentVC.navigationController;
    }
    
    if ([self findController:contollerName navController:navController]) {
        UIViewController * controller = [self findController:contollerName navController:navController];
        controller.frontVC = self;
        controller.title = title;
        controller.obj = obj;
        controller.objOne = objOne;

        [navController popToViewController:controller animated:YES];
    }
    else{
        UIViewController * controller = [NSClassFromString(contollerName) new];
        controller.frontVC = self;
        controller.title = [title stringByReplacingOccurrencesOfString:@" " withString:@""];
        controller.obj = obj;
        controller.objOne = objOne;

        [navController pushViewController:controller animated:YES];
        
    }
}

- (void)goController:(NSString *)contollerName title:(NSString *)title{
    [self goController:contollerName title:title navController:self.navigationController obj:nil objOne:nil];
}

- (void)goController:(NSString *)contollerName title:(NSString *)title obj:(id)obj{
    [self goController:contollerName title:title navController:self.navigationController obj:obj objOne:nil];
}

- (void)goController:(NSString *)contollerName title:(NSString *)title obj:(id)obj objOne:(id)objOne{
    [self goController:contollerName title:title navController:self.navigationController obj:obj objOne:objOne];
}

- (void)presentController:(NSString *_Nonnull)contollerName title:(NSString *)title{
    [self presentController:contollerName title:title obj:nil objOne:nil animated:true];
}

- (void)presentController:(NSString *_Nonnull)contollerName title:(NSString *)title animated:(BOOL)animated{
    [self presentController:contollerName title:title obj:nil objOne:nil animated:animated];
}

- (void)presentController:(NSString *_Nonnull)contollerName title:(NSString *)title obj:(id)obj{
    [self presentController:contollerName title:title obj:obj objOne:nil animated:true];
}

- (void)presentController:(NSString *_Nonnull)contollerName title:(NSString *)title obj:(id)obj objOne:(id)objOne{
    [self presentController:contollerName title:title obj:obj objOne:nil animated:true];
}

- (void)presentController:(NSString *_Nonnull)contollerName title:(NSString *)title obj:(id)obj objOne:(id)objOne animated:(BOOL)animated{
    UIViewController * controller = [NSClassFromString(contollerName) new];
    controller.title = title;
    controller.obj = obj;
    controller.objOne = objOne;
    
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:controller];
    [self presentViewController:navController animated:animated completion:^{
        
    }];
}


- (UIViewController *)getController:(NSString *)contollerName navController:(UINavigationController *)navController{
    if (!navController) {
//        navController = (UINavigationController *)[UIApplication.sharedApplication.keyWindow.rootViewController];
        navController = self.currentVC.navigationController;
    }
    
    UIViewController * viewController  = [NSClassFromString(contollerName) new];
    if ([self findController:contollerName navController:navController]) {
        viewController = [self findController:contollerName navController:navController];
    }
    return viewController;
}

- (UIViewController *)getController:(NSString *)contollerName{
    UIViewController * viewController = [self getController:contollerName navController:self.currentVC.navigationController];
    return viewController;
}

-(NSString *)controllerName{
    NSString * className = NSStringFromClass(self.class);
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

- (id _Nullable )frontViewController:(UINavigationController *_Nonnull)navContoller{

    UIViewController * viewController = nil;

    NSUInteger count = navContoller.viewControllers.count;
    if (count >= 2) {
        viewController = navContoller.viewControllers[count - 2];
    }
    else{
        viewController = UIApplication.rootController;
        
    }
//    self.frontController = viewController;//初始化
    return viewController;
    
}

- (UIViewController *)addControllerName:(NSString *)className{
    UIViewController * controller = [NSClassFromString(className) new];
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

#pragma mark -------------alert升级方法-------------------

- (void)showAlertTitle:(NSString *_Nullable)title msg:(NSString *_Nullable)msg{
    [UIAlertController createAlertTitle:title msg:msg placeholders:nil actionTitles:nil handler:nil];
}

- (void)showAlertTitle:(NSString *_Nullable)title msg:(NSString *_Nullable)msg handler:(void(^)(UIAlertController * _Nonnull alertVC, UIAlertAction * _Nullable action))handler{
    [UIAlertController createAlertTitle:title msg:msg placeholders:nil actionTitles:@[kActionTitle_Cancell,kActionTitle_Sure] handler:handler];
}

- (void)showAlertTitle:(NSString *_Nullable)title msg:(NSString *_Nullable)msg actionTitles:(NSArray *_Nullable)actionTitleList handler:(void(^)(UIAlertController * _Nonnull alertVC, UIAlertAction * _Nullable action))handler{
    UIAlertController *alertController = [UIAlertController createAlertTitle:title msg:msg placeholders:nil actionTitles:actionTitleList handler:handler];
    UIWindow * keyWindow = UIApplication.sharedApplication.delegate.window;
    [keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
}

- (void)callPhone:(NSString *)phoneNumber{
    
    NSArray * titleList = @[@"取消",@"呼叫"];
    [self showAlertTitle:nil msg:phoneNumber actionTitles:titleList handler:^(UIAlertController * _Nonnull alertController, UIAlertAction * _Nullable action) {
        if ([action.title isEqualToString:[titleList lastObject]]) {
            
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                NSString * phoneStr = [NSString stringWithFormat:@"tel:%@",phoneNumber];
                if (iOSVer(10)) {
                    [UIApplication.sharedApplication openURL:[NSURL URLWithString:phoneStr] options:@{} completionHandler:nil];
                    
                } else {
                    [UIApplication.sharedApplication openURL:[NSURL URLWithString:phoneStr]];
                    
                }
            });
        }
    }];
}

/**
 设置导航栏背景色
 透明色与self.edgesForExtendedLayout = UIRectEdgeAll;搭配使用
 */
- (void)setupNavigationBarBackgroundImage:(UIImage *)image{
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:image];
}
/**
 返回按钮专用
 */
- (UIButton *)createBackItem:(UIImage *)image{
    UIColor *tintColor = UINavigationBar.appearance.tintColor != nil ? UINavigationBar.appearance.tintColor : UIColor.redColor;
    return [self createBackItem:image tintColor:tintColor];
}

- (UIButton *)createBackItem:(UIImage *)image tintColor:(UIColor *)tintColor {
    NSParameterAssert(image != nil);
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.adjustsImageWhenHighlighted = false;
    btn.frame = CGRectMake(0, 0, 30, 40);
    btn.imageEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    
    [btn setImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    btn.imageView.tintColor = tintColor;
    btn.highlighted = false;
    [btn addActionHandler:^(UIControl * _Nonnull control) {
        [self.navigationController popViewControllerAnimated:true];
        
    } forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem * backItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem = backItem;
    return btn;
}


@end


