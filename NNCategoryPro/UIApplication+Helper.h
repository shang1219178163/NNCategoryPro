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

@property (class, nonatomic, strong) UIWindow *mainWindow;
@property (class, nonatomic, strong, nullable) UIViewController *rootController;
@property (class, nonatomic, readonly, nullable) UITabBarController *tabBarController;
@property (class, nonatomic, readonly, nullable) UINavigationController *navController;

//@property (nullable, readonly) UIWindow *currentKeyWindow;

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
///设置根视图控制器 （isAdjust：是够添加 UINavigationController）
+ (void)setupRootController:(UIViewController *_Nonnull)controller isAdjust:(BOOL)isAdjust;

+ (void)setupAppearanceDefault:(BOOL)isDefault;

+ (void)setupAppearanceScrollView;

+ (void)setupAppearanceOthers;

+ (void)setupAppearanceNavigationBar:(UIColor *)barTintColor;

+ (void)setupAppearanceSearchbarCancellButton;

+ (void)openURLString:(NSString *)string prefix:(NSString *)prefix completion:(void (^ __nullable)(BOOL success))completion;

+ (void)openURL:(NSURL *)url completion:(void (^ __nullable)(BOOL success))completion;

+ (NSString *)deviceTokenStringWithDeviceToken:(NSData *)deviceToken;

+ (void)didEnterBackgroundBlock:(void (^_Nullable)(void))block;

+ (void)setAppIconWithName:(NSString *)iconName;

@end

NS_ASSUME_NONNULL_END
