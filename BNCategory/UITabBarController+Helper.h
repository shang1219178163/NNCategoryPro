//
//  UITabBarController+Helper.h
//  ProductTemplet
//
//  Created by Bin Shang on 2018/12/29.
//  Copyright © 2018 BN. All rights reserved.
//

#import <UIKit/UIKit.h>

UIKIT_EXTERN NSString * const kUIBadgeView;
UIKIT_EXTERN NSString * const kUITabBarButton;
UIKIT_EXTERN NSString * const kUITabBarSwappableImageView;

NS_ASSUME_NONNULL_BEGIN

@interface UITabBarController (Helper)

FOUNDATION_EXPORT NSArray<UITabBarItem *> * UITabBarItemsFromList(NSArray<NSArray *> *list);
FOUNDATION_EXPORT NSArray<__kindof UIViewController *> * UICtlrListFromList(NSArray<NSArray *> *list, BOOL isNavController);
FOUNDATION_EXPORT NSArray<UINavigationController *> * UINavListFromList(NSArray<NSArray *> *list);

FOUNDATION_EXPORT UITabBarController * UITarBarCtrFromList(NSArray<NSArray *> *list);

- (NSArray *)getSubviewsForName:(NSString *)name;

- (void)reloadTabarItems:(NSArray *)list;

@end

NS_ASSUME_NONNULL_END
