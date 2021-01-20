//
//  UITabBarController+Helper.h
//  ProductTemplet
//
//  Created by Bin Shang on 2018/12/29.
//  Copyright © 2018 BN. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

UIKIT_EXTERN NSString * const kUIBadgeView;
UIKIT_EXTERN NSString * const kUITabBarButton;
UIKIT_EXTERN NSString * const kUITabBarSwappableImageView;

@interface UITabBarController (Helper)

/// list 类名,title,imgN,imgH,badgeValue
FOUNDATION_EXPORT NSArray<UITabBarItem *> * UITabBarItemsFromList(NSArray<NSArray *> *list);
/// 数组->__kindof UIViewController (子数组示例:@[@"标题",@"图片",@"图片高亮",@"badgeValue",])
FOUNDATION_EXPORT NSArray<__kindof UIViewController *> * UICtlrListFromList(NSArray<NSArray *> *list, BOOL isNavController);
/// 数组->UINavigationController(子数组示例:@[@"标题",@"图片",@"图片高亮",@"badgeValue",])
FOUNDATION_EXPORT NSArray<UINavigationController *> * UINavListFromList(NSArray<NSArray *> *list);
/// 数组->UITabBarController(子数组示例:@[@"标题",@"图片",@"图片高亮",@"badgeValue",])
FOUNDATION_EXPORT UITabBarController * UITarBarCtrFromList(NSArray<NSArray *> *list);

- (void)reloadTabarItems:(NSArray *)list;

@end

NS_ASSUME_NONNULL_END
