//
//  UIApplication+Helper.h
//  
//
//  Created by BIN on 2017/12/28.
//  Copyright © 2017年 SHANG. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "NSObject+Helper.h"
#import "UIApplication+Other.h"
#import "UIViewController+Helper.h"

NS_ASSUME_NONNULL_BEGIN

FOUNDATION_EXPORT NSString * const kJPush_type;
FOUNDATION_EXPORT NSString * const kJPush_extras;

@interface UIApplication (Helper)

@property (class, nonnull) UIWindow *keyWindow;
@property (class, nonnull) UIViewController *rootController;
@property (class, readonly, nullable) UITabBarController *tabBarController;

@property (class, readonly) NSDictionary *infoDic;
@property (class, readonly, nullable) NSString *appName;
@property (class, readonly, nullable) NSString *appBundleName;
@property (class, readonly, nullable) UIImage *appIcon;
@property (class, readonly, nullable) NSString *appVer;
@property (class, readonly, nullable) NSString *appBuild;
@property (class, readonly, nullable) NSString *phoneSystemVer;
@property (class, readonly, nullable) NSString *phoneSystemName;
@property (class, readonly, nullable) NSString *phoneName;
@property (class, readonly, nullable) NSString *phoneModel;
@property (class, readonly, nullable) NSString *phoneLocalizedModel;
@property (class, readonly, nullable) NSString *phoneType;

+ (void)setupRootController:(id _Nonnull)controller;
+ (void)setupRootController:(id _Nonnull)controller isAdjust:(BOOL)isAdjust;

+ (void)setupAppearanceDefault:(BOOL)isDefault;

+ (void)setupAppearanceScrollView;

+ (void)setupAppearanceOthers;

+ (void)setupAppearanceNavigationBar:(UIColor *)barTintColor;

+ (void)setupAppearanceNavigationBar;

+ (BOOL)openURLStr:(NSString *)urlStr prefix:(NSString *)prefix;

+ (NSString *)deviceTokenStringWithDeviceToken:(NSData *)deviceToken;

@end

NS_ASSUME_NONNULL_END
