//
//  UIFont+Hook.m
//  NNCategoryPro
//
//  Created by Bin Shang on 2019/12/27.
//

#import "UIFont+Hook.h"
#import "NSObject+Hook.h"

NSString * const kPingFang           = @"PingFang SC";
NSString * const kPingFangMedium     = @"PingFangSC-Medium";
NSString * const kPingFangSemibold   = @"PingFangSC-Semibold";
NSString * const kPingFangLight      = @"PingFangSC-Light";
NSString * const kPingFangUltralight = @"PingFangSC-Ultralight";
NSString * const kPingFangRegular    = @"PingFangSC-Regular";
NSString * const kPingFangThin       = @"PingFangSC-Thin";

@implementation UIFont (Hook)
 
//+ (void)load{
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        hookInstanceMethod(self.class, NSSelectorFromString(@"systemFont:"), NSSelectorFromString(@"hook_systemFont:"));
//    });
//}
//
//- (UIFont *)hook_systemFont:(UIFont *)fontSize{
//    return [UIFont fontWithName:kPingFangRegular size:fontSize];
//}

@end

