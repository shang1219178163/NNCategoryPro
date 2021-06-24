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

- (void)setColor:(UIColor *)tintColor barTintColor:(UIColor *)barTintColor{
    self.tintColor = tintColor;
    self.barTintColor = barTintColor;
    self.backgroundColor = barTintColor;

    self.shadowImage = [UIImage new];
    self.translucent = CGColorEqualToColor(barTintColor.CGColor, UIColor.clearColor.CGColor);
    
    self.titleTextAttributes = @{NSForegroundColorAttributeName: tintColor};
}

@end

