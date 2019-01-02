//
//  UITabBarController+Helper.h
//  ProductTemplet
//
//  Created by Bin Shang on 2018/12/29.
//  Copyright © 2018 BN. All rights reserved.
//

#import <UIKit/UIKit.h>

UIKIT_EXTERN NSString * const kUITabBarButton;
UIKIT_EXTERN NSString * const kUITabBarSwappableImageView;

NS_ASSUME_NONNULL_BEGIN

@interface UITabBarController (Helper)

- (NSArray *)getSubviewsForName:(NSString *)name;

@end

NS_ASSUME_NONNULL_END
