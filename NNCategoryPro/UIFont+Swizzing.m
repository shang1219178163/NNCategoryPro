//
//  UIFont+Helper.m
//  ProductTemplet
//
//  Created by Bin Shang on 2019/8/23.
//  Copyright © 2019 BN. All rights reserved.
//

#import "UIFont+Swizzing.h"
#import "NSObject+swizzling.h"

NSString * const kPingFang           = @"PingFang SC";
NSString * const kPingFangMedium     = @"PingFangSC-Medium";
NSString * const kPingFangSemibold   = @"PingFangSC-Semibold";
NSString * const kPingFangLight      = @"PingFangSC-Light";
NSString * const kPingFangUltralight = @"PingFangSC-Ultralight";
NSString * const kPingFangRegular    = @"PingFangSC-Regular";
NSString * const kPingFangThin       = @"PingFangSC-Thin";

@implementation UIFont (Swizzing)

+ (void)initialize{
    if (self == self.class) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            SwizzleMethodInstance(@"UIImageView", NSSelectorFromString(@"systemFont:"), NSSelectorFromString(@"hook_systemFont:"));
            
        });
    }
}

- (UIFont *)hook_systemFont:(CGFloat)fontSize{
    return [UIFont fontWithName:kPingFangRegular size:fontSize];
}



@end

