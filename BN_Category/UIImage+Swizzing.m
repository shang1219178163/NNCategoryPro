//
//  UIImage+Swizzing.m
//  BN_Kit
//
//  Created by dev on 2018/12/6.
//

#import "UIImage+Swizzing.h"
#import <objc/runtime.h>
#import "NSBundle+Helper.h"
#import "NSObject+swizzling.h"

@implementation UIImage (Swizzing)

+ (void)initialize{
    if (self == [self class]) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
//            NSLog(@"%@,%@,%@",self,self.class,NSClassFromString(@"UIImage"));
            SwizzleMethodClass(@"UIImage", @selector(imageNamed:), @selector(swz_imageNamed:));

        });
    }
}

+ (UIImage *)swz_imageNamed:(NSString *)name{
    UIImage *image = [UIImage swz_imageNamed:name];
    if (image) {
//        image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        return image;
    }
    NSBundle *resource_bundle = NSBundleFromParams(self, @"BN_Globle");
    image = [UIImage imageNamed:name inBundle:resource_bundle compatibleWithTraitCollection:nil];
    return image;
}

@end
