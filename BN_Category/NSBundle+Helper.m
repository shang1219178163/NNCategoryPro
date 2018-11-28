//
//  NSBundle+Helper.m
//  ProductTemplet
//
//  Created by hsf on 2018/11/28.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "NSBundle+Helper.h"

@implementation NSBundle (Helper)

FOUNDATION_EXPORT NSBundle *NSBundleFromString(NSString *string){
    NSBundle *bundle = [NSBundle bundleForClass:[NSClassFromString(string) class]];
    NSURL *url = [bundle URLForResource:string withExtension:@"bundle"];
    bundle = [NSBundle bundleWithURL:url];
    return bundle;
}

+ (NSString *)pathBundle:(NSString *)bundleName resource:(NSString *)resource type:(NSString *)type{
    NSBundle *bundle = NSBundleFromString(bundleName);
    NSString *path = [bundle pathForResource:resource ofType:type];
    return path;
}


@end
