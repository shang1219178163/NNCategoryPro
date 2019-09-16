
//
//  UIApplication+Helper.m
//  
//
//  Created by BIN on 2017/12/28.
//  Copyright © 2017年 SHANG. All rights reserved.
//

#import "UIApplication+Helper.h"
#import <objc/runtime.h>
#import <sys/utsname.h>

#import "UIImage+Helper.h"

NSString * const kJPush_type = @"into_page_type";
NSString * const kJPush_extras = @"extras";

@implementation UIApplication (Helper)

static NSDictionary *_phoneTypeDic = nil;

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

static NSDictionary *_infoDic = nil;
+ (NSDictionary *)infoDic{
    if(!_infoDic){
        _infoDic = NSBundle.mainBundle.infoDictionary;
    }
    return _infoDic;
}

+(NSString *)appName{
    return self.infoDic[@"CFBundleDisplayName"] ? : self.infoDic[@"CFBundleName"];
}

+(NSString *)appBundleName{
    return self.infoDic[@"CFBundleExecutable"];
}

+(UIImage *)appIcon{
    NSString *icon = [[self.infoDic valueForKeyPath:@"CFBundleIcons.CFBundlePrimaryIcon.CFBundleIconFiles"] lastObject];
    UIImage *image = [UIImage imageNamed:icon];
    return image;
}

+(NSString *)appVer{
    return self.infoDic[@"CFBundleShortVersionString"];
}

+(NSString *)appBuild{
    return self.infoDic[@"CFBundleVersion"];
}

+(NSString *)phoneSystemVer{
    return UIDevice.currentDevice.systemVersion ? : @"";
}

+(NSString *)phoneSystemName{
    return UIDevice.currentDevice.systemName ? : @"";
}

+(NSString *)phoneName{
    return UIDevice.currentDevice.name ? : @"";
}

+(NSString *)phoneModel{
    return UIDevice.currentDevice.model ? : @"";
}

+(NSString *)phoneLocalizedModel{
    return UIDevice.currentDevice.localizedModel ?  : @"";
}

+ (NSString *)phoneType{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *identifier = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    return [UIApplication phoneTypeDic][identifier];
}

+ (NSDictionary *)phoneTypeDic{
    if (!_phoneTypeDic) {
        _phoneTypeDic = @{
                        @"iPhone3,1": @"iPhone 4",
                        @"iPhone3,2": @"iPhone 4",
                        @"iPhone3,3": @"iPhone 4",
                        @"iPhone4,1": @"iPhone 4S",
                        @"iPhone5,1": @"iPhone 5",
                        @"iPhone5,2": @"iPhone 5 (GSM+CDMA)",
                        @"iPhone5,3": @"iPhone 5c (GSM)",
                        @"iPhone5,4": @"iPhone 5c (GSM+CDMA)",
                        @"iPhone6,1": @"iPhone 5s (GSM)",
                        @"iPhone6,2": @"iPhone 5s (GSM+CDMA)",
                        @"iPhone7,1": @"iPhone 6 Plus",
                        @"iPhone7,2": @"iPhone 6",
                        @"iPhone8,1": @"iPhone 6s",
                        @"iPhone8,2": @"iPhone 6s Plus",
                        @"iPhone8,4": @"iPhone SE",
                        // 日行两款手机型号均为日本独占，可能使用索尼FeliCa支付方案而不是苹果支付
                        @"iPhone9,1": @"国行、日版、港行iPhone 7",
                        @"iPhone9,2": @"港行、国行iPhone 7 Plus",
                        @"iPhone9,3": @"美版、台版iPhone 7",
                        @"iPhone9,4": @"美版、台版iPhone 7 Plus",
                        @"iPhone10,1": @"iPhone_8",
                        @"iPhone10,4": @"iPhone_8",
                        @"iPhone10,2": @"iPhone_8_Plus",
                        @"iPhone10,5": @"iPhone_8_Plus",
                        @"iPhone10,3": @"iPhone_X",
                        @"iPhone10,6": @"iPhone_X",
                        @"iPod1,1": @"iPod Touch 1G",
                        @"iPod2,1": @"iPod Touch 2G",
                        @"iPod3,1": @"iPod Touch 3G",
                        @"iPod4,1": @"iPod Touch 4G",
                        @"iPod5,1": @"iPod Touch (5 Gen)",
                        @"iPad1,1": @"iPad",
                        @"iPad1,2": @"iPad 3G",
                        @"iPad2,1": @"iPad 2 (WiFi)",
                        @"iPad2,2": @"iPad 2",
                        @"iPad2,3": @"iPad 2 (CDMA)",
                        @"iPad2,4": @"iPad 2",
                        @"iPad2,5": @"iPad Mini (WiFi)",
                        @"iPad2,6": @"iPad Mini",
                        @"iPad2,7": @"iPad Mini (GSM+CDMA)",
                        @"iPad3,1": @"iPad 3 (WiFi)",
                        @"iPad3,2": @"iPad 3 (GSM+CDMA)",
                        @"iPad3,3": @"iPad 3",
                        @"iPad3,4": @"iPad 4 (WiFi)",
                        @"iPad3,5": @"iPad 4",
                        @"iPad3,6": @"iPad 4 (GSM+CDMA)",
                        @"iPad4,1": @"iPad Air (WiFi)",
                        @"iPad4,2": @"iPad Air (Cellular)",
                        @"iPad4,4": @"iPad Mini 2 (WiFi)",
                        @"iPad4,5": @"iPad Mini 2 (Cellular)",
                        @"iPad4,6": @"iPad Mini 2",
                        @"iPad4,7": @"iPad Mini 3",
                        @"iPad4,8": @"iPad Mini 3",
                        @"iPad4,9": @"iPad Mini 3",
                        @"iPad5,1": @"iPad Mini 4 (WiFi)",
                        @"iPad5,2": @"iPad Mini 4 (LTE)",
                        @"iPad5,3": @"iPad Air 2",
                        @"iPad5,4": @"iPad Air 2",
                        @"iPad6,3": @"iPad Pro 9.7",
                        @"iPad6,4": @"iPad Pro 9.7",
                        @"iPad6,7": @"iPad Pro 12.9",
                        @"iPad6,8": @"iPad Pro 12.9",
                        
                        @"AppleTV2,1": @"Apple TV 2",
                        @"AppleTV3,1": @"Apple TV 3",
                        @"AppleTV3,2": @"Apple TV 3",
                        @"AppleTV5,3": @"Apple TV 4",
                        
                        @"i386": @"Simulator",
                        @"x86_64": @"Simulator",
                        };
    }
    return _phoneTypeDic;
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
    UITableView.appearance.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    UITableView.appearance.separatorInset = UIEdgeInsetsZero;
    UITableView.appearance.rowHeight = 60;

    UITableViewCell.appearance.layoutMargins = UIEdgeInsetsZero;
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
    UITextField.appearance.font = [UIFont systemFontOfSize:12];
    UITextView.appearance.font = [UIFont systemFontOfSize:12];
    
    UIButton.appearance.titleLabel.textColor = UIColor.blackColor;
    UIButton.appearance.titleLabel.font = [UIFont systemFontOfSize:12];
    UIButton.appearance.exclusiveTouch = NO;
    
    UISwitch.appearance.onTintColor = UIColor.themeColor;

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
                           NSForegroundColorAttributeName:   tintColor,
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

+ (BOOL)openURL:(NSString *)urlStr{
    UIApplication * app = UIApplication.sharedApplication;
    NSURL *url = [NSURL URLWithString:urlStr];
    BOOL isOpenUrl = [app canOpenURL:url];
    if (isOpenUrl) {
        if (@available(iOS 10.0, *)) {
            [app openURL:url options:@{} completionHandler:nil];
        } else {
            [app openURL:url];
        }
    }
    else{
        NSString *tips = [urlStr stringByAppendingString:@"打开失败"];
        [UIApplication.rootController showAlertTitle:tips msg:nil actionTitles:nil handler:nil];
        
    }
    return isOpenUrl;
}


@end
