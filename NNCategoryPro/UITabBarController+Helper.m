//
//  UITabBarController+Helper.m
//  ProductTemplet
//
//  Created by Bin Shang on 2018/12/29.
//  Copyright © 2018 BN. All rights reserved.
//

#import "UITabBarController+Helper.h"
#import "UIViewController+Helper.h"
#import "NSArray+Helper.h"

NSString * const kUIBadgeView = @"_UIBadgeView";
NSString * const kUITabBarButton = @"UITabBarButton";
NSString * const kUITabBarSwappableImageView = @"UITabBarSwappableImageView";

@implementation UITabBarController (Helper)


@end


@implementation UITabBar (Helper)

- (void)reloadItems:(NSArray<NSString *> *)titles images:(nullable NSArray<UIImage *> *)images selectedImages:(nullable NSArray<UIImage *> *)selectedImages{
    assert(titles.count == images.count == selectedImages.count);
    self.items = [titles map:^id _Nonnull(NSString * _Nonnull obj, NSUInteger idx) {
        return [[UITabBarItem alloc]initWithTitle:obj image:images[idx] selectedImage:selectedImages[idx]];
    }];
}


- (void)reloadItems:(NSArray<NSString *> *)titles imageNames:(nullable NSArray<NSString *> *)imageNames selectedImageNames:(nullable NSArray<NSString *> *)selectedImageNames{
    assert(titles.count == imageNames.count == selectedImageNames.count);

    NSArray *images = [imageNames map:^id _Nonnull(NSString * _Nonnull obj, NSUInteger idx) {
        return [[UIImage imageNamed: imageNames[idx]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }];
    
    NSArray *selectedImages = [imageNames map:^id _Nonnull(NSString * _Nonnull obj, NSUInteger idx) {
        return [[UIImage imageNamed: selectedImageNames[idx]] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    }];
    
    [self reloadItems:titles images:images selectedImages:selectedImages];
}

@end


@implementation UITabBarItem (Helper)

+ (NSString *)KeyVC{
    return NSStringFromSelector(_cmd);
}

+ (NSString *)KeyTitle{
    return NSStringFromSelector(_cmd);
}

+ (NSString *)KeyImage{
    return NSStringFromSelector(_cmd);
}

+ (NSString *)KeyImageSelected{
    return NSStringFromSelector(_cmd);
}

+ (NSString *)KeyBadgeValue{
    return NSStringFromSelector(_cmd);
}


- (void)updateBadgeValue:(NSString *)value{
    self.badgeValue = value;
    self.badgeColor = self.badgeValue > 0 ? UIColor.redColor : UIColor.clearColor;
}


@end



@implementation UITabBarAppearance (Ext)

+ (instancetype)create:(UIColor *)tintColor barTintColor:(UIColor *)barTintColor font:(nullable UIFont *)font{
    UITabBarAppearance *barAppearance = [[UITabBarAppearance alloc]init];
    [barAppearance configureWithOpaqueBackground];
    barAppearance.backgroundColor = barTintColor;
    barAppearance.selectionIndicatorTintColor = tintColor;

    
    barAppearance.stackedLayoutAppearance = [UITabBarItemAppearance createWithNormal:@{
                                                NSForegroundColorAttributeName: tintColor,
                                                NSFontAttributeName: font ? : [UIFont systemFontOfSize:15]
                                            } selected:@{
                                                NSForegroundColorAttributeName: tintColor,
                                                NSFontAttributeName: font ? : [UIFont systemFontOfSize:15]
                                            }];
    return barAppearance;
}

@end


@implementation UITabBarItemAppearance (Ext)

+ (instancetype)createWithNormal:(NSDictionary<NSAttributedStringKey, id> *)normalAttrs selected:(NSDictionary<NSAttributedStringKey, id> *)selectedAttrs{

    UITabBarItemAppearance *itemAppearance = [[UITabBarItemAppearance alloc]init];
    itemAppearance.normal.titleTextAttributes = normalAttrs;
    itemAppearance.selected.titleTextAttributes = selectedAttrs;
    return itemAppearance;
}

@end



@implementation UIViewController (TabBar)

- (void)reloadTabarItem:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName{
    assert([UIImage imageNamed: imageName] && [UIImage imageNamed: selectedImageName]);
    self.tabBarItem = [[UITabBarItem alloc]initWithTitle: title
                                                   image: [[UIImage imageNamed: imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                           selectedImage: [[UIImage imageNamed: selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]
                       ];
}

- (void)updateBadgeValue:(NSString *)value{
    [self.tabBarItem updateBadgeValue:value];
}


@end
