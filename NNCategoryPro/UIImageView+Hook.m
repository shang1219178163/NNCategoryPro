//
//  UIImageView+Hook.m
//  NNCategoryPro
//
//  Created by Bin Shang on 2019/12/27.
//

#import "UIImageView+Hook.h"
#import "NSObject+Hook.h"

@implementation UIImageView (Hook)
 
+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        hookInstanceMethod(self.class, NSSelectorFromString(@"setTintColor:"), NSSelectorFromString(@"hook_setTintColor:"));
    });
    
}

- (void)hook_setTintColor:(UIColor *)color {
    [self hook_setTintColor:color];
    
    if ([self isKindOfClass:NSClassFromString(@"UITabBarSwappableImageView")]) {
        return;
    }
    
    if (self.image.renderingMode != UIImageRenderingModeAlwaysTemplate) {
        self.image = [self.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    }
}



@end
