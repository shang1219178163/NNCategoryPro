
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

+(NSString *)app_Name{
    NSDictionary *infoDict = [NSBundle.mainBundle infoDictionary];
    return  infoDict[@"CFBundleDisplayName"] ? : infoDict[@"CFBundleName"];
}

+(UIImage *)app_Icon{
    NSDictionary *infoDict = [NSBundle.mainBundle infoDictionary];
    
    NSString *icon = [[infoDict valueForKeyPath:@"CFBundleIcons.CFBundlePrimaryIcon.CFBundleIconFiles"] lastObject];
    UIImage * image = [UIImage imageNamed:icon];
    return image;
    
}

+(NSString *)app_Version{
    NSDictionary *infoDict = [NSBundle.mainBundle infoDictionary];
    return  infoDict[@"CFBundleShortVersionString"];
}

+(NSString *)app_build{
    NSDictionary *infoDict = [NSBundle.mainBundle infoDictionary];
    return  infoDict[@"CFBundleVersion"];
}

+(NSString *)phone_SystemVersion{
    return  [UIDevice.currentDevice systemVersion];
    
}

+(NSString *)phone_SystemName{
    return  [UIDevice.currentDevice systemName];
    
}

+(NSString *)phone_Name{
    if (UIDevice.currentDevice) {
        UIDevice * device = UIDevice.currentDevice;
        return device.name;
    }
    return @"";
}

+(NSString *)phone_Model{
    return  [UIDevice.currentDevice model];
    
}

+(NSString *)phone_localizedModel{
    return  [UIDevice.currentDevice localizedModel];
    
}

+ (void)setupRootController:(id)controller{
    if ([controller isKindOfClass:[NSString class]]) controller = [NSClassFromString(controller) new];
    
    if ([controller isKindOfClass:[UINavigationController class]] || [controller isKindOfClass:[UITabBarController class]]) {
        UIApplication.rootController = controller;
        
    }
    else{
        UINavigationController * navController = [[UINavigationController alloc] initWithRootViewController:controller];
        UIApplication.rootController = navController;
        
    }
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

    }
}

+ (void)setupNavigationbar{
    
    UINavigationBar * navigationBar = UINavigationBar.appearance;
    [navigationBar setBarTintColor:UIColor.themeColor];
    [navigationBar setTintColor:UIColor.whiteColor];
    [navigationBar setTitleTextAttributes:@{
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


@end
