//
//  UIApplication+Helper.h
//  HuiZhuBang
//
//  Created by BIN on 2017/12/28.
//  Copyright © 2017年 WeiHouKeJi. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "NSObject+Helper.h"
#import "UIApplication+Other.h"
#import "UIViewController+Helper.h"

#define kJPushKey_type          @"into_page_type"
#define kJPushKey_extras        @"extras"

@interface UIApplication (Helper)

@property (class, nonnull) UIWindow *keyWindow;
@property (class, nonnull) UIViewController *rootController;

@property (class, readonly, nullable) NSString *app_Name;
@property (class, readonly, nullable) NSString *app_Icon;
@property (class, readonly, nullable) NSString *app_Version;
@property (class, readonly, nullable) NSString *app_build;
@property (class, readonly, nullable) NSString *phone_SystemVersion;
@property (class, readonly, nullable) NSString *phone_SystemName;
@property (class, readonly, nullable) NSString *phone_Name;
@property (class, readonly, nullable) NSString *phone_Model;
@property (class, readonly, nullable) NSString *phone_localizedModel;

+ (void)setupRootController:(id _Nonnull)controller;

+ (void)setupAppearance;

+ (void)setupNavigationbar;

+ (void)setupTabBarSelectedIndex:(NSUInteger)selectedIndex;

@end

