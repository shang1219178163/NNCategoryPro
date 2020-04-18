//
//  UIImage+Hook.m
//  NNCategoryPro
//
//  Created by Bin Shang on 2019/12/27.
//

#import "UIImage+Hook.h"
#import <objc/runtime.h>
#import "NSBundle+Helper.h"
#import "NSObject+Hook.h"

@implementation UIImage (Hook)

+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SwizzleMethodClass(self.class, @selector(imageNamed:), @selector(hook_imageNamed:));

    });
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
