
//
//  UIApplication+Helper.m
//  HuiZhuBang
//
//  Created by BIN on 2017/12/28.
//  Copyright © 2017年 WeiHouKeJi. All rights reserved.
//

#import "UIApplication+Helper.h"
#import <objc/runtime.h>


@implementation UIApplication (Helper)

+ (UIWindow *)keyWindow{
    UIWindow *window = UIApplication.sharedApplication.delegate.window;
    if (window == nil) {
        window = [[UIWindow alloc]initWithFrame:UIScreen.mainScreen.bounds];
        window.backgroundColor = UIColor.whiteColor;
        [window makeKeyAndVisible];
        UIApplication.sharedApplication.delegate.window = window;
        
    }
    return window;
    
}

+(void)setKeyWindow:(UIWindow *)keyWindow{
    if (keyWindow == nil) return;
    UIApplication.sharedApplication.delegate.window = keyWindow;
    
}

+ (UIViewController *)rootController{
    UIViewController *rootVC = UIApplication.keyWindow.rootViewController;
    return rootVC;
}

+(void)setRootController:(UIViewController *)rootVC{
    if (rootVC == nil) return;
    UIApplication.keyWindow.rootViewController = rootVC;
    
}

+ (UITabBarController *)tabBarController{
    if ([UIApplication.rootController isKindOfClass:[UITabBarController class]]) {
        return (UITabBarController *)UIApplication.rootController;
    }
    return nil;
}

+(NSString *)appName{
    NSDictionary *infoDict = NSBundle.mainBundle.infoDictionary;
    return  infoDict[@"CFBundleDisplayName"] ? : infoDict[@"CFBundleName"];
}

+(UIImage *)appIcon{
    NSDictionary *infoDict = NSBundle.mainBundle.infoDictionary;
    
    NSString *icon = [[infoDict valueForKeyPath:@"CFBundleIcons.CFBundlePrimaryIcon.CFBundleIconFiles"] lastObject];
    UIImage * image = [UIImage imageNamed:icon];
    return image;
    
}

+(NSString *)appVer{
    NSDictionary *infoDict = NSBundle.mainBundle.infoDictionary;
    return  infoDict[@"CFBundleShortVersionString"];
}

+(NSString *)appBuild{
    NSDictionary *infoDict = NSBundle.mainBundle.infoDictionary;
    return  infoDict[@"CFBundleVersion"];
}

+(NSString *)phoneSystemVer{
    return UIDevice.currentDevice.systemVersion;
    
}

+(NSString *)phoneSystemName{
    return UIDevice.currentDevice.systemName;
    
}

+(NSString *)phoneName{
    if (UIDevice.currentDevice) {
        return UIDevice.currentDevice.name;
    }
    return @"";
}

+(NSString *)phoneModel{
    return UIDevice.currentDevice.model;
    
}

+(NSString *)phoneLocalizedModel{
    return UIDevice.currentDevice.localizedModel;
    
}

+ (void)setupRootController:(id)controller isAdjust:(BOOL)isAdjust{
    if (isAdjust == NO) {
        UIApplication.rootController = controller;
        return;
    }
    
    if ([controller isKindOfClass:[NSString class]]) controller = [[NSClassFromString(controller) alloc] init];
    if ([controller isKindOfClass:[UINavigationController class]] || [controller isKindOfClass:[UITabBarController class]]) {
        UIApplication.rootController = controller;
        
    }
    else{
        UINavigationController * navController = [[UINavigationController alloc] initWithRootViewController:controller];
        UIApplication.rootController = navController;
        
    }
}

+ (void)setupRootController:(id)controller{
    [UIApplication setupRootController:controller isAdjust:YES];
    
}

//+ (void)setupRootController:(id)controller{
//    if ([controller isKindOfClass:[NSString class]]) controller = [NSClassFromString(controller) new];
//
//    UIApplication * app = UIApplication.sharedApplication;
//    app.delegate.window = [[UIWindow alloc]initWithFrame:UIScreen.mainScreen.bounds];
//    app.delegate.window.backgroundColor = UIColor.whiteColor;
//
//    if ([controller isKindOfClass:[UINavigationController class]] || [controller isKindOfClass:[UITabBarController class]]) {
//        app.delegate.window.rootViewController = controller;
//
//    }else{
//        UINavigationController * navController = [[UINavigationController alloc] initWithRootViewController:controller];
//        app.delegate.window.rootViewController = navController;
//
//    }
//    [app.delegate.window makeKeyAndVisible];
//}

+ (void)setupAppearance{
    [self setupNavigationbar];
    [self setupTableView];
    
    if (@available(iOS 11.0, *)) {
        UICollectionView.appearance.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        UIScrollView.appearance.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        UIScrollView.appearance.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;

    }
}

+ (void)setupNavigationbar{
    [UINavigationBar.appearance setBarTintColor:UIColor.themeColor];
    [UINavigationBar.appearance setTintColor:UIColor.whiteColor];
    [UINavigationBar.appearance setTitleTextAttributes:@{
                                                         NSForegroundColorAttributeName  :   UIColor.whiteColor,
                                            
                                                         }];

    //    [bar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
    //    [navigationBar setTitleTextAttributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:20]}];
    
    if (iOSVersion(11)) {
//        UIImage *origImage = [UIImage imageNamed:@"img_btnBack.png"];
//        //系统返回按钮处的title偏移到可视范围之外
//        //iOS11 和 iOS11以下分别处理
//        UIOffset offset = iOSVersion(11) ? UIOffsetMake(-200, 0) : UIOffsetMake(0, -80);
//
//        [UIBarButtonItem.appearance setBackButtonTitlePositionAdjustment:offset forBarMetrics:UIBarMetricsDefault];
//        [UIBarButtonItem.appearance setBackButtonTitlePositionAdjustment:offset forBarMetrics:UIBarMetricsCompact];
//
//        [UINavigationBar.appearance setBackIndicatorImage:origImage];
//        [UINavigationBar.appearance setBackIndicatorTransitionMaskImage:origImage];
        
    }
    else{

    }
}

+ (void)setupTableView{
    if (@available(iOS 11.0, *)) {
        UITableView.appearance.estimatedRowHeight = 0.0;
        UITableView.appearance.estimatedSectionHeaderHeight = 0.0;
        UITableView.appearance.estimatedSectionFooterHeight = 0.0;

    }
}


+ (void)setupTabBarSelectedIndex:(NSUInteger)selectedIndex{
    UIViewController *rootController = UIApplication.sharedApplication.delegate.window.rootViewController;
    if ([rootController isKindOfClass:[UITabBarController class]]) {
        ((UITabBarController *)rootController).selectedIndex = selectedIndex;
    }else{
        NSParameterAssert([rootController isKindOfClass:[UITabBarController class]]);
        
    }
    
}

+(BOOL)openURL:(NSString *)urlStr tips:(NSString *)tips{
    UIApplication * app = UIApplication.sharedApplication;
    NSURL *url = [NSURL URLWithString:urlStr];
    BOOL isOpenUrl = [app canOpenURL:url];
    if (isOpenUrl == YES) {
        if (iOSVersion(10)) {
            [app openURL:url options:@{} completionHandler:nil];
            
        }else{
            [app openURL:url];
        }
    }
    else{
        [UIApplication.rootController showAlertTitle:tips msg:tips];
        
    }
    return isOpenUrl;
    
}



@end
