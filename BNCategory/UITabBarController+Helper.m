//
//  UITabBarController+Helper.m
//  ProductTemplet
//
//  Created by Bin Shang on 2018/12/29.
//  Copyright © 2018 BN. All rights reserved.
//

#import "UITabBarController+Helper.h"

NSString * const kUIBadgeView = @"_UIBadgeView";
NSString * const kUITabBarButton = @"UITabBarButton";
NSString * const kUITabBarSwappableImageView = @"UITabBarSwappableImageView";

@implementation UITabBarController (Helper)

- (NSArray *)getSubviewsForName:(NSString *)name{
    NSMutableArray * marr = [NSMutableArray array];
    for (UIView *view in self.tabBar.subviews){
        if ([view isKindOfClass:NSClassFromString(name)]){
            [marr addObject:view];
        }
    }
    return marr.copy;
    
}

/**
 用特定数据源刷新tabBar
 @param list 参照HomeViewController数据源
 */
- (void)reloadTabarItems:(NSArray *)list{
    [self.viewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSArray * itemlist = list[idx];
        NSString * title = itemlist[itemlist.count - 4];
        UIImage * img = [UIImage imageNamed:itemlist[itemlist.count - 3]];
        UIImage * imgH = [UIImage imageNamed:itemlist[itemlist.count - 2]];

        obj.tabBarItem = [[UITabBarItem alloc]initWithTitle:title image:img selectedImage:imgH];;
    }];
}

@end
