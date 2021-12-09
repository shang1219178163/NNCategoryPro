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

@end


@interface UITabBar (Helper)

- (void)reloadItems:(NSArray<NSString *> *)titles images:(nullable NSArray<UIImage *> *)images selectedImages:(nullable NSArray<UIImage *> *)selectedImages;

- (void)reloadItems:(NSArray<NSString *> *)titles imageNames:(nullable NSArray<NSString *> *)imageNames selectedImageNames:(nullable NSArray<NSString *> *)selectedImageNames;

@end


@interface UITabBarItem (Helper)

@property(nonatomic, strong, readonly, class) NSString *KeyVC;
@property(nonatomic, strong, readonly, class) NSString *KeyTitle;
@property(nonatomic, strong, readonly, class) NSString *KeyImage;
@property(nonatomic, strong, readonly, class) NSString *KeyImageSelected;
@property(nonatomic, strong, readonly, class) NSString *KeyBadgeValue;

- (void)updateBadgeValue:(NSString *)value;

@end


@interface UITabBarAppearance (Ext)

+ (instancetype)create:(UIColor *)tintColor barTintColor:(UIColor *)barTintColor font:(nullable UIFont *)font;

@end


@interface UITabBarItemAppearance (Ext)

+ (instancetype)createWithNormal:(NSDictionary<NSAttributedStringKey, id> *)normalAttrs selected:(NSDictionary<NSAttributedStringKey, id> *)selectedAttrs;

@end



@interface UIViewController (TabBar)

- (void)reloadTabarItem:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName;

- (void)updateBadgeValue:(NSString *)value;

@end

NS_ASSUME_NONNULL_END
