//
//  UINavigationBar+Helper.m
//  
//
//  Created by BIN on 2018/5/3.
//  Copyright © 2018年 SHANG. All rights reserved.
//

#import "UINavigationBar+Helper.h"

#import "UIColor+Helper.h"
#import "UIImage+Helper.h"

@implementation UINavigationBar (Helper)

- (void)setColor:(UIColor *)tintColor barTintColor:(UIColor *)barTintColor shadowColor:(nullable UIColor *)shadowColor{
    self.tintColor = tintColor;
    self.barTintColor = barTintColor;
    self.backgroundColor = barTintColor;

    self.shadowImage = [UIImage new];
    self.translucent = CGColorEqualToColor(barTintColor.CGColor, UIColor.clearColor.CGColor);
    
    self.titleTextAttributes = @{NSForegroundColorAttributeName: tintColor};
    
    
    [self setBackgroundImage:[UIImage imageWithColor:barTintColor] forBarMetrics:UIBarMetricsDefault];
    if (@available(iOS 13.0, *)) {
        UINavigationBarAppearance *barAppearance = [UINavigationBarAppearance create:tintColor barTintColor:barTintColor shadowColor:shadowColor font:nil];
        self.standardAppearance = barAppearance;
        self.scrollEdgeAppearance = barAppearance;
    }
}

@end


@implementation UINavigationBarAppearance (Ext)

+ (instancetype)create:(UIColor *)tintColor
          barTintColor:(UIColor *)barTintColor
           shadowColor:(nullable UIColor *)shadowColor
                  font:(nullable UIFont *)font{

    UINavigationBarAppearance *barAppearance = [[UINavigationBarAppearance alloc]init];
    [barAppearance configureWithOpaqueBackground];
    barAppearance.backgroundColor = barTintColor;

    barAppearance.titleTextAttributes = @{
        NSForegroundColorAttributeName: tintColor,
    };
    
    UIBarButtonItemStateAppearance *itemNormal = barAppearance.buttonAppearance.normal;
    itemNormal.titleTextAttributes = @{NSForegroundColorAttributeName: tintColor,
//                                       NSBackgroundColorAttributeName: barTintColor,
                                       NSFontAttributeName: font ? : [UIFont systemFontOfSize:15]
    };

    UIBarButtonItemStateAppearance *itemDoneNomal = barAppearance.doneButtonAppearance.normal;
    itemDoneNomal.titleTextAttributes = @{NSForegroundColorAttributeName: tintColor,
//                                          NSBackgroundColorAttributeName: barTintColor,
                                          NSFontAttributeName: font ? : [UIFont systemFontOfSize:15]
    };
    
    
    if (shadowColor != nil) {
        barAppearance.shadowColor = shadowColor;
    }
    return barAppearance;
}

@end
