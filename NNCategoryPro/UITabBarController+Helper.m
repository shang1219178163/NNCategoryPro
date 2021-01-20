//
//  UITabBarController+Helper.m
//  ProductTemplet
//
//  Created by Bin Shang on 2018/12/29.
//  Copyright © 2018 BN. All rights reserved.
//

#import "UITabBarController+Helper.h"
#import "UIViewController+Helper.h"

NSString * const kUIBadgeView = @"_UIBadgeView";
NSString * const kUITabBarButton = @"UITabBarButton";
NSString * const kUITabBarSwappableImageView = @"UITabBarSwappableImageView";

@implementation UITabBarController (Helper)

NSArray<UITabBarItem *> * UITabBarItemsFromList(NSArray<NSArray *> * list){
    //list 类名,title,imgN,imgH,badgeValue
    
    __block NSMutableArray * marr = [NSMutableArray array];
    [list enumerateObjectsUsingBlock:^(NSArray * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSArray * itemList = (NSArray *)obj;//类名,title,img_N,img_H,badgeValue
        
        NSString * title = itemList.count > 1 ? itemList[1] :   @"";
        NSString * img_N = itemList.count > 2 ? itemList[2] :   @"";
        NSString * img_H = itemList.count > 3 ? itemList[3] :   @"";
        NSString * badgeValue = itemList.count > 4 ? itemList[4] :   @"";
        //
        UIImage *imageN = [[UIImage imageNamed:img_N] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIImage *imageH = [[UIImage imageNamed:img_H] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        UITabBarItem *tabBarItem = [[UITabBarItem alloc]initWithTitle:title image:imageN selectedImage:imageH];
        tabBarItem.badgeValue = badgeValue;
        
        if (@available(iOS 10.0, *)) {
            tabBarItem.badgeColor = badgeValue.integerValue <= 0 ? UIColor.clearColor:UIColor.redColor;
        } else {
            // Fallback on earlier versions
        }
        
        if (tabBarItem.title == nil || [tabBarItem.title isEqualToString:@""]) {
            tabBarItem.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0);
        }
        
        [marr addObject:tabBarItem];
    }];
    return marr.copy;
}

NSArray<__kindof UIViewController *> * UICtlrListFromList(NSArray<NSArray *> *list, BOOL isNavController){
    NSArray *tabItems = UITabBarItemsFromList(list);
    
    __block NSMutableArray *marr = [NSMutableArray array];
    [list enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[NSString class]]) {
            UINavigationController *navController = UINavCtrFromObj(obj);
            [marr addObject:navController];
            
        }
        else if([obj isKindOfClass:[NSArray class]]) {
            NSArray *itemList = (NSArray *)obj;//类名,title,img_N,img_H,badgeValue
            
            UIViewController * controller = UICtrFromString(itemList.firstObject);
            controller.title = itemList[1];
            controller.tabBarItem = tabItems[idx];
            //时候是导航控制器
            controller = isNavController ? UINavCtrFromObj(controller) : controller;
            [marr addObject:controller];
        }
        else{
            assert([obj isKindOfClass:[NSString class]] || [obj isKindOfClass:[NSArray class]]);
        }
    }];
    NSArray *viewControllers = marr.copy;
    return viewControllers;
}

NSArray<UINavigationController *> * UINavListFromList(NSArray<NSArray *> *list){
    return UICtlrListFromList(list, true);
}

UITabBarController * UITarBarCtrFromList(NSArray<NSArray *> *list){
    UITabBarController * tabBarVC = [[UITabBarController alloc]init];
    tabBarVC.viewControllers = UINavListFromList(list);
//    tabBarVC.tabBar.barTintColor = UIColor.themeColor;
//    tabBarVC.tabBar.tintColor = UIColor.themeColor;
    return tabBarVC;
}

/**
 用特定数据源刷新tabBar
 @param list 参照HomeViewController数据源
 */
- (void)reloadTabarItems:(NSArray *)list{
    [self.viewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSArray *itemlist = list[idx];
        NSString *title = itemlist[itemlist.count - 4];
        UIImage *img = [UIImage imageNamed:itemlist[itemlist.count - 3]];
        UIImage *imgH = [UIImage imageNamed:itemlist[itemlist.count - 2]];

        obj.tabBarItem = [[UITabBarItem alloc]initWithTitle:title image:img selectedImage:imgH];;
    }];
}

@end
