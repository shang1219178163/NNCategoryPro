
//
//  UIApplication+Helper.m
//  
//
//  Created by BIN on 2017/12/28.
//  Copyright © 2017年 SHANG. All rights reserved.
//

#import "UIApplication+Helper.h"
#import <objc/runtime.h>
#import "UIImage+Helper.h"

@implementation UIApplication (Helper)

+ (UIWindow *)keyWindow{
    UIWindow *window = UIApplication.sharedApplication.delegate.window;
    if (!window) {
        window = [[UIWindow alloc]initWithFrame:UIScreen.mainScreen.bounds];
        window.backgroundColor = UIColor.whiteColor;
        [window makeKeyAndVisible];
        UIApplication.sharedApplication.delegate.window = window;
        
    }
    return window;
}

+(void)setKeyWindow:(UIWindow *)keyWindow{
    if (!keyWindow) return;
    UIApplication.sharedApplication.delegate.window = keyWindow;
}

+ (UIViewController *)rootController{
    UIViewController *rootVC = UIApplication.keyWindow.rootViewController;
    return rootVC;
}

+(void)setRootController:(UIViewController *)rootVC{
    if (!rootVC) return;
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
    if ([controller isKindOfClass:[NSString class]]) controller = [[NSClassFromString(controller) alloc] init];
    if (!isAdjust) {
        UIApplication.rootController = controller;
        return;
    }
    
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


/**
 导航栏默认白色主题色
 */
+ (void)setupAppearanceDefault:(BOOL)isDefault{
    UIColor *barTintColor = isDefault ? UIColor.whiteColor : UIColor.themeColor;
    [UIApplication setupAppearanceNavigationBar:barTintColor];
    [UIApplication setupAppearanceScrollView];
    [UIApplication setupAppearanceOthers];
}

+ (void)setupAppearanceScrollView{
    UITableViewCell.appearance.separatorInset = UIEdgeInsetsZero;
    UITableViewCell.appearance.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UIScrollView.appearance.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    
    if (@available(iOS 11.0, *)) {
        UITableView.appearance.estimatedRowHeight = 0.0;
        UITableView.appearance.estimatedSectionHeaderHeight = 0.0;
        UITableView.appearance.estimatedSectionFooterHeight = 0.0;
        
        UICollectionView.appearance.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        UIScrollView.appearance.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        
    }
}

+ (void)setupAppearanceOthers{
    UIButton.appearance.exclusiveTouch = NO;

    UITabBar.appearance.tintColor = UIColor.themeColor;
    UITabBar.appearance.barTintColor = UIColor.whiteColor;
    UITabBar.appearance.translucent = NO;

    if (@available(iOS 10.0, *)) {
        UITabBar.appearance.unselectedItemTintColor = UIColor.grayColor;
    } else {
        // Fallback on earlier versions
    }
    
    UITabBarItem.appearance.titlePositionAdjustment = UIOffsetMake(0, -5.0);

    //    UITabBarItem *selectedItem = UITabBar.appearance.selectedItem;
    //    selectedItem.image = [selectedItem.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    //
    //    NSArray *items = UITabBar.appearance.items;
    //    for (UITabBarItem * item in items) {
    //        item.image = [item.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    //    }
    
    //    UITabBarItem.appearance setTitleTextAttributes:<#(nullable NSDictionary<NSAttributedStringKey,id> *)#> forState:<#(UIControlState)#>
}

/**
 定义导航栏背景色
 */
+ (void)setupAppearanceNavigationBar:(UIColor *)barTintColor{
    BOOL isDefault = CGColorEqualToColor(UIColor.whiteColor.CGColor, barTintColor.CGColor);
    UIColor *tintColor = isDefault ? UIColor.blackColor : UIColor.whiteColor;
//    UIColor *barTintColor = isDefault ? UIColor.whiteColor : UIColor.themeColor;
    
    UINavigationBar.appearance.tintColor = tintColor;
    UINavigationBar.appearance.barTintColor = barTintColor;
    [UINavigationBar.appearance setBackgroundImage:UIImageColor(barTintColor) forBarMetrics:UIBarMetricsDefault];
    [UINavigationBar.appearance setShadowImage:UIImageColor(barTintColor)];
    
    NSDictionary * dic = @{
                           NSForegroundColorAttributeName   :   tintColor,
                           };
    UINavigationBar.appearance.titleTextAttributes = dic;
    if (iOSVer(11)) {
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

+ (BOOL)openURL:(NSString *)urlStr tips:(NSString *)tips{
    UIApplication * app = UIApplication.sharedApplication;
    NSURL *url = [NSURL URLWithString:urlStr];
    BOOL isOpenUrl = [app canOpenURL:url];
    if (isOpenUrl) {
        if (iOSVer(10)) {
            [app openURL:url options:@{} completionHandler:nil];
            
        } else {
            [app openURL:url];
        }
    }
    else{
        [UIApplication.rootController showAlertTitle:tips msg:tips];
        
    }
    return isOpenUrl;
    
}



@end
