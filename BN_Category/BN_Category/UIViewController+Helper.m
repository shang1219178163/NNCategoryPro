//
//  UIViewController+Helper.m
//  HuiZhuBang
//
//  Created by BIN on 2017/8/14.
//  Copyright © 2017年 WeiHouKeJi. All rights reserved.
//

#import "UIViewController+Helper.h"

#import <objc/runtime.h>
#import <StoreKit/StoreKit.h>

#import "BN_Globle.h"

#import "NSObject+Helper.h"
#import "UIApplication+Helper.h"

#import "UIView+Helper.h"
#import "UIButton+Helper.h"
#import "UIScreen+Helper.h"


@implementation UIViewController (Helper)

@dynamic delegate;

- (void)configureDefault{
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = UIColor.whiteColor;
    self.title = self.controllerName;
    
}

#pragma make - - 给控制器添加额外属性
-(UIViewController *)frontController{
    return [self frontViewController:self.currentVC.navigationController];

}

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
                            @0    :   @"img_request_Failed",
                            @1    :   @"img_NoData",
                          
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

-(NSTimeInterval)timeInterval{
    return [objc_getAssociatedObject(self, _cmd) doubleValue];
}

-(void)setTimeInterval:(NSTimeInterval)timeInterval{
    objc_setAssociatedObject(self, @selector(timeInterval), @(timeInterval), OBJC_ASSOCIATION_ASSIGN);
}

#pragma make - -通用
- (UIButton *)createBarBtnItemWithTitle:(NSString *)title imageName:(NSString *)imageName isLeft:(BOOL)isLeft target:(id)target aSelector:(SEL)aSelector isHidden:(BOOL)isHidden{
    
    UIButton * btn = nil;
    if (imageName) {
        btn = [UIButton buttonWithSize:CGSizeMake(40, 40) image_N:imageName image_H:nil imageEdgeInsets:UIEdgeInsetsZero];
    }else{
        btn = [UIButton buttonWithSize:CGSizeMake(40, 40) title:title font:15 titleColor_N:nil titleColor_H:nil titleEdgeInsets:UIEdgeInsetsZero];
       
    }
    btn.tag = isLeft == YES ? kTAG_BTN_BackItem : kTAG_BTN_RightItem;
    
    [btn addTarget:target action:aSelector forControlEvents:UIControlEventTouchUpInside];
    btn.hidden = isHidden;

    //
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    btn.center = view.center;
    [view addSubview:btn];

    //统一走父视图方法
    [btn removeTarget:target action:aSelector forControlEvents:UIControlEventTouchUpInside];
    //父视图调用子视图方法参数
    [view addActionHandler:^(id obj, id item, NSInteger idx) {
        if (btn.hidden == YES) return ;
        if (NSDate.date.timeIntervalSince1970 - self.timeInterval < 1) return;
        if (self.timeInterval > 0) self.timeInterval = NSDate.date.timeIntervalSince1970;

        [target performSelectorOnMainThread:aSelector withObject:btn waitUntilDone:YES];
    }];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:view];
    if (isLeft == YES) {
        self.navigationItem.leftBarButtonItem = item;
        
    }else{
        self.navigationItem.rightBarButtonItem = item;
        
    }
    return btn;
}

- (void)BN_handleActionBtn:(UIButton *)sender{
    if (self.blockObject) self.blockObject(sender, nil, 0);
    
}

- (UIButton *)createBarBtnItemWithTitle:(NSString *)title imageName:(NSString *)imageName isLeft:(BOOL)isLeft isHidden:(BOOL)isHidden handler:(void(^)(id obj, id item, NSInteger idx))handler{
    
    UIButton * btn = nil;
    if (imageName) {
        btn = [UIButton buttonWithSize:CGSizeMake(32, 32) image_N:imageName image_H:nil imageEdgeInsets:UIEdgeInsetsZero];
    }else{
        btn = [UIButton buttonWithSize:CGSizeMake(40, 40) title:title font:15 titleColor_N:nil titleColor_H:nil titleEdgeInsets:UIEdgeInsetsZero];
        
    }
    btn.tag = isLeft == YES ? kTAG_BTN_BackItem : kTAG_BTN_RightItem;
    
    btn.hidden = isHidden;
    //
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    view.hidden = isHidden;
    btn.center = view.center;
    [view addSubview:btn];
    
    
    //父视图调用子视图方法参数
    [view addActionHandler:^(id obj, id item, NSInteger idx) {
        if (btn.isHidden == 1) return ;
        
        if (NSDate.date.timeIntervalSince1970 - self.timeInterval < 1) return;
        if (self.timeInterval > 0) self.timeInterval = NSDate.date.timeIntervalSince1970;
        
        handler(obj, item, 0);

    }];
    
    [btn addActionHandler:^(id obj, id item, NSInteger idx) {
        if (btn.isHidden == 1) return ;

        if (NSDate.date.timeIntervalSince1970 - self.timeInterval < 1) return;
        if (self.timeInterval > 0) self.timeInterval = NSDate.date.timeIntervalSince1970;
        
        handler(obj, item, 0);
        
    }];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:view];
    if (isLeft == YES) {
        self.navigationItem.leftBarButtonItem = item;
        
    }else{
        self.navigationItem.rightBarButtonItem = item;
        
    }
    return btn;
}


- (UITableViewCell *)getCellByClickView:(UIView *)view{
    UIView * supView = [view superview];
    while (![supView isKindOfClass:[UITableViewCell class]]) {
        
        supView = [supView superview];
    }
    UITableViewCell * tableViewCell = (UITableViewCell *)supView;
    return tableViewCell;
}

- (NSIndexPath *)getCellIndexPathByClickView:(UIView *)view tableView:(UITableView *)tableView{
    UITableViewCell * cell = [self getCellByClickView:view];
    NSIndexPath * indexPath = [tableView indexPathForRowAtPoint:cell.center];
    
//    DDLog(@"%@",indexPath);
    return indexPath;
}

- (BOOL)isCurrentVisibleViewController{
    return (self.isViewLoaded && self.view.window);
}

- (id)findController:(NSString *)contollerName navController:(UINavigationController *)navController{
    if (navController == nil) {
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
        UIViewController * controller  = [NSClassFromString(contollerName) new];
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
    [self presentController:contollerName title:title obj:nil objOne:nil];
}

- (void)presentController:(NSString *_Nonnull)contollerName title:(NSString *)title obj:(id)obj{
    [self presentController:contollerName title:title obj:obj objOne:nil];

}

- (void)presentController:(NSString *_Nonnull)contollerName title:(NSString *)title obj:(id)obj objOne:(id)objOne{
    UIViewController * controller = [NSClassFromString(contollerName) new];
    controller.title = title;
    controller.obj = obj;
    controller.objOne = objOne;

    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:controller];
    [self presentViewController:navController animated:YES completion:^{
        
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
    NSString * className = NSStringFromClass([self class]);
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

- (UIViewController *)BN_AddChildControllerView:(NSString *)className{
    UIViewController * controller = [NSClassFromString(className) new];
    [self addChildViewController:controller];
    [controller didMoveToParentViewController:self];

    [self.view addSubview:controller.view];
    
    self.navigationItem.leftBarButtonItem = controller.navigationItem.leftBarButtonItem;
    self.navigationItem.rightBarButtonItem = controller.navigationItem.rightBarButtonItem;
    return controller;
}

#pragma mark -------------alert升级方法-------------------
- (void)showAlertWithTitle:(nullable NSString *)title msg:(nullable NSString *)msg{
    [self showAlertWithTitle:title placeholderList:nil msg:msg actionTitleList:@[kActionTitle_Know] handler:nil];
    
}

- (void)showAlertWithTitle:(nullable NSString *)title msg:(nullable NSString *)msg handler:(void(^)(UIAlertController * _Nonnull alertVC, UIAlertAction * _Nullable action))handler{
    [self showAlertWithTitle:title placeholderList:nil msg:msg actionTitleList:@[kActionTitle_Cancell,kActionTitle_Sure] handler:handler];
    
}

- (void)showAlertWithTitle:(nullable NSString *)title msg:(nullable NSString *)msg actionTitleList:(NSArray *_Nonnull)actionTitleList handler:(void(^)(UIAlertController * _Nonnull alertVC, UIAlertAction * _Nullable action))handler{
    [self showAlertWithTitle:title placeholderList:nil msg:msg actionTitleList:actionTitleList handler:handler];
    
}

- (void)showAlertWithTitle:(nullable NSString *)title placeholderList:(NSArray *)placeholderList msg:(NSString *)msg actionTitleList:(NSArray *_Nonnull)actionTitleList handler:(void(^)(UIAlertController * _Nonnull alertVC, UIAlertAction * _Nullable action))handler{

    UIWindow * keyWindow = UIApplication.sharedApplication.delegate.window;
//    [keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
    
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
    for (NSString * placeholder in placeholderList) {
        [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.placeholder = placeholder;
            textField.textAlignment = NSTextAlignmentCenter;
            
        }];
    }
    
    
    switch (actionTitleList.count) {
        case 0:
        {
            [keyWindow.rootViewController presentViewController:alertController animated:YES completion:^{
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(kAnimationDuration_Toast * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [keyWindow.rootViewController dismissViewControllerAnimated:YES completion:nil];
                });
                
            }];
        }
            break;
        case 1:
        {
            [alertController addAction:[UIAlertAction actionWithTitle:[actionTitleList firstObject]
                                                                style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction *action){
                                                                  if (handler) handler(alertController,action);

                                                              }]];
            [keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
            
        }
            break;
        case 2:
        {
            [alertController addAction:[UIAlertAction actionWithTitle:[actionTitleList firstObject] style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                if (handler) handler(alertController,action);

            }]];
            
            [alertController addAction:[UIAlertAction actionWithTitle:[actionTitleList lastObject] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                if (handler) handler(alertController,action);

            }]];
            [keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
            
        }
            break;
        default:
        {
            for (NSInteger i = 0; i < actionTitleList.count; i++) {
                [alertController addAction:[UIAlertAction actionWithTitle:actionTitleList[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    if (handler) handler(alertController,action);

                }]];
            }
            [keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];

        }
            break;
    }
}


- (void)showSheetWithTitle:(nullable NSString *)title msgList:(NSArray * _Nonnull)msgList handler:(void(^)(UIAlertController * _Nonnull alertVC, UIAlertAction * _Nullable action))handler{
    
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    for (NSInteger i = 0; i < msgList.count; i++) {
        [alertController addAction:[UIAlertAction actionWithTitle:msgList[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (handler) handler(alertController,action);

        }]];
    }
    [alertController addAction:[UIAlertAction actionWithTitle:kActionTitle_Cancell style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        if (handler) handler(alertController,action);

    }]];
    [self presentViewController:alertController animated:YES completion:nil];
    
}

#pragma mark -------------alert升级方法-------------------

- (void)dispalyAppEvalutionStarLevelAppID:(NSString *)appID{
    
    if([SKStoreReviewController respondsToSelector:@selector(requestReview)]){
        [UIApplication.sharedApplication.keyWindow endEditing:YES];//防止键盘遮挡
        [SKStoreReviewController requestReview];
        
    }
    else{
        NSString *reviewURL = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=%@&onlyLatestVersion=true&pageNumber=0&sortOrdering=1&type=Purple+Software",appID];
        if (iOSVersion(11)) {
            reviewURL = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/app/id%@?action=write-review",appID];//替换为对应的APPID
        }
//        [UIApplication.sharedApplication openURL:[NSURL URLWithString:appEvaluationUrl]];
        
        NSDictionary * options = @{
                                   UIApplicationOpenURLOptionUniversalLinksOnly : @YES
                                   };
        
        [UIApplication.sharedApplication openURL:[NSURL URLWithString:reviewURL] options:options completionHandler:^(BOOL success) {
            
        }];
    }
}

- (id)getTextFieldRightView:(NSString *)unitString{
    //    NSArray * unitList = @[@"元",@"公斤"];
    if (unitString != nil && ![unitString isEqualToString:@""]) {
        if ([unitString containsString:@".png"]) {
            CGSize size = CGSizeMake(20, 20);
            UIImageView * imgView = [UIView createImgViewWithRect:CGRectMake(0, 0, size.width, size.height) image:unitString tag:kTAG_IMGVIEW patternType:@"0"];
            return imgView;
        }
        else{
            CGSize size = [self sizeWithText:unitString font:@(KFZ_Third) width:UIScreen.width];
        
            UILabel * label = [UIView createLabelWithRect:CGRectMake(0, 0, size.width+2, 25) text:unitString textColor:UIColor.blackColor tag:kTAG_LABEL patternType:@"2" font:KFZ_Third backgroudColor:UIColor.clearColor alignment:NSTextAlignmentCenter];
            return label;
        }
    }
    return nil;
}

- (void)callPhone:(NSString *)phoneNumber{
    
    NSArray * titleList = @[@"取消",@"呼叫"];
    [self showAlertWithTitle:nil msg:phoneNumber actionTitleList:titleList handler:^(UIAlertController * _Nonnull alertController, UIAlertAction * _Nullable action) {
        if ([action.title isEqualToString:[titleList lastObject]]) {
            
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                NSString * phoneStr = [NSString stringWithFormat:@"tel:%@",phoneNumber];
                if (iOSVersion(10)) {
                    [UIApplication.sharedApplication openURL:[NSURL URLWithString:phoneStr] options:@{} completionHandler:nil];
                    
                }else{
                    [UIApplication.sharedApplication openURL:[NSURL URLWithString:phoneStr]];
                    
                }
            });
        }
    }];
}

- (void)showFriendAdd:(NSString *)msg{
    
    [self showAlertWithTitle:@"发送成功" msg:msg actionTitleList:@[kActionTitle_Sure] handler:^(UIAlertController * _Nonnull alertController, UIAlertAction * _Nullable action) {
        if ([action.title isEqualToString:kActionTitle_Sure]) {
            
        }
    }];

}

@end


