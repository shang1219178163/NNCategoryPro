//
//  UINavigationBar+Helper.m
//  HuiZhuBang
//
//  Created by BIN on 2018/5/3.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//

#import "UINavigationBar+Helper.h"

#import "UIColor+Helper.h"

@implementation UINavigationBar (Helper)

+ (void)configureAppeare{
    
    UINavigationBar.appearance.barTintColor = UIColor.themeColor;
    UINavigationBar.appearance.tintColor = UIColor.whiteColor;
    UINavigationBar.appearance.shadowImage = [[UIImage alloc] init];
    UINavigationBar.appearance.backIndicatorImage = [UIImage imageNamed:@"nav_bar_back_icon_white"];
    UINavigationBar.appearance.backIndicatorTransitionMaskImage = [UIImage imageNamed:@"nav_bar_back_icon_white"];
    UINavigationBar.appearance.titleTextAttributes = @{
                                                         NSForegroundColorAttributeName : UIColor.whiteColor
                                                         
                                                         };
   
    
    NSShadow *clearShadow = [[NSShadow alloc] init];
    clearShadow.shadowColor = UIColor.clearColor;
    clearShadow.shadowOffset = CGSizeMake(0, 0);
    
    UIColor *titleColor_N = UIColor.whiteColor;
    UIColor *titleColor_H = UIColor.whiteColor;
    [UIBarButtonItem.appearance setTitleTextAttributes:@{
                                                           NSForegroundColorAttributeName : titleColor_N,
                                                           NSShadowAttributeName : clearShadow,
                                                           } forState:UIControlStateNormal];
    [UIBarButtonItem.appearance setTitleTextAttributes:@{
                                                           NSForegroundColorAttributeName : titleColor_H,
                                                           NSShadowAttributeName : clearShadow,
                                                           } forState:UIControlStateHighlighted];
    
    // hide title of back button
    [UIBarButtonItem.appearance setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)
                                                         forBarMetrics:UIBarMetricsDefault];
}


@end

