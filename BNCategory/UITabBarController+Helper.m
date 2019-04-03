//
//  UITabBarController+Helper.m
//  ProductTemplet
//
//  Created by Bin Shang on 2018/12/29.
//  Copyright © 2018 BN. All rights reserved.
//

#import "UITabBarController+Helper.h"
#import "UIViewController+Helper.h"
#import "UINavigationController+Helper.h"

NSString * const kUIBadgeView = @"_UIBadgeView";
NSString * const kUITabBarButton = @"UITabBarButton";
NSString * const kUITabBarSwappableImageView = @"UITabBarSwappableImageView";

@implementation UITabBarController (Helper)

/**
 数组->UINavigationController(子数组示例:@[@"标题",@"图片",@"图片高亮",@"badgeValue",])
 */
NSArray * UINavListFromList(NSArray *list){
    __block NSMutableArray * marr = [NSMutableArray array];
    [list enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[NSString class]]) {
            UINavigationController *navController = UINavCtrFromObj(obj);
            [marr addObject:navController];

        }
        else if([obj isKindOfClass:[NSArray class]]) {
            NSArray * itemList = (NSArray *)obj;//类名,title,img_N,img_H,badgeValue

            NSString * title = itemList.count > 1 ? itemList[1] :   @"";
            NSString * img_N = itemList.count > 2 ? itemList[2] :   @"";
            NSString * img_H = itemList.count > 3 ? itemList[3] :   @"";
            NSString * badgeValue = itemList.count > 4 ? itemList[4] :   @"";

            UIViewController * controller = UICtrFromString(itemList.firstObject);
            controller.title = itemList[1];

            UITabBarItem *tabBarItem = [[UITabBarItem alloc]initWithTitle:title image:[UIImage imageNamed:img_N] selectedImage:[UIImage imageNamed:img_H]];
            tabBarItem.badgeValue = badgeValue;

            controller.tabBarItem = tabBarItem;
            if (@available(iOS 10.0, *)) {
                controller.tabBarItem.badgeColor = badgeValue.integerValue <= 0 ? UIColor.clearColor:UIColor.redColor;
            } else {
                // Fallback on earlier versions
            }

            UINavigationController *navController = UINavCtrFromObj(controller);
            [marr addObject:navController];
        }
        else{
            assert([obj isKindOfClass:[NSString class]] || [obj isKindOfClass:[NSArray class]]);
        }
    }];
    NSArray *viewControllers = marr.copy;
    return viewControllers;
}

/**
 数组->UITabBarController(子数组示例:@[@"标题",@"图片",@"图片高亮",@"badgeValue",])
 */
UITabBarController * UITarBarCtrFromList(NSArray *list){
    UITabBarController * tabBarVC = [[UITabBarController alloc]init];
    tabBarVC.viewControllers = UINavListFromList(list);
    //    tabBarVC.tabBar.barTintColor = UIColor.themeColor;
    //    tabBarVC.tabBar.tintColor = UIColor.themeColor;
    return tabBarVC;
}

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
