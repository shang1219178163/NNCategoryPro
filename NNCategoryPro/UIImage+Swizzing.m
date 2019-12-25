//
//  UIImage+Swizzing.m
//  BNKit
//
//  Created by dev on 2018/12/6.
//

#import "UIImage+Swizzing.h"
#import <objc/runtime.h>
#import "NSBundle+Helper.h"
#import "NSObject+swizzling.h"

@implementation UIImage (Swizzing)

+ (void)initialize{
    if (self == self.class) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            SwizzleMethodClass(@"UIImage", @selector(imageNamed:), @selector(hook_imageNamed:));

        });
    }
}

+ (UIImage *)hook_imageNamed:(NSString *)name{
    UIImage *image = [UIImage hook_imageNamed:name];
    if (image) {
//        image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        return image;
    }
    NSBundle *resource_bundle = NSBundleFromParams(self, @"NNGloble");
    image = [UIImage imageNamed:name inBundle:resource_bundle compatibleWithTraitCollection:nil];
    return image;
}

@end
