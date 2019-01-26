//
//  UITabBarController+Helper.m
//  ProductTemplet
//
//  Created by Bin Shang on 2018/12/29.
//  Copyright © 2018 BN. All rights reserved.
//

#import "UITabBarController+Helper.h"

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

@end
