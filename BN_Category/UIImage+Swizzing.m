//
//  UIImage+Swizzing.m
//  BN_Kit
//
//  Created by dev on 2018/12/6.
//

#import "UIImage+Swizzing.h"
#import <objc/runtime.h>
#import "NSBundle+Helper.h"

@implementation UIImage (Swizzing)

+ (void)initialize{
    if (self == [self class]) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            Method otherMehtod = class_getClassMethod(self, @selector(swz_imageNamed:));
            Method originMehtod = class_getClassMethod(self, @selector(imageNamed:));
            // 交换2个方法的实现
            method_exchangeImplementations(otherMehtod, originMehtod);
        });
    }
}

+ (UIImage *)swz_imageNamed:(NSString *)name{
    UIImage *image = [UIImage swz_imageNamed:name];
    if (image) {
        return image;
    }
    NSBundle *resource_bundle = NSBundleFromParams(self, @"BN_Globle");
    image = [UIImage imageNamed:name inBundle:resource_bundle compatibleWithTraitCollection:nil];
    return image;
}

@end
