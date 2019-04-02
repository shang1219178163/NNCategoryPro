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

#define kJPush_type          @"into_page_type"
#define kJPush_extras        @"extras"

@interface UIApplication (Helper)

@property (class, nonnull) UIWindow *keyWindow;
@property (class, nonnull) UIViewController *rootController;
@property (class, readonly, nullable) UITabBarController *tabBarController;

@property (class, readonly, nullable) NSString *appName;
@property (class, readonly, nullable) NSString *appIcon;
@property (class, readonly, nullable) NSString *appVer;
@property (class, readonly, nullable) NSString *appBuild;
@property (class, readonly, nullable) NSString *phoneSystemVer;
@property (class, readonly, nullable) NSString *phoneSystemName;
@property (class, readonly, nullable) NSString *phoneName;
@property (class, readonly, nullable) NSString *phoneModel;
@property (class, readonly, nullable) NSString *phoneLocalizedModel;

+ (void)setupRootController:(id _Nonnull)controller;
+ (void)setupRootController:(id _Nonnull)controller isAdjust:(BOOL)isAdjust;

+ (void)setupAppearanceDefault:(BOOL)isDefault;

+ (void)setupAppearanceScrollView;

+ (void)setupAppearanceOthers;

+ (void)setupAppearanceNavigationBar:(UIColor *)barTintColor;

+ (void)setupAppearanceNavigationBar;

+ (BOOL)openURL:(NSString *)urlStr tips:(NSString *)tips;

@end

