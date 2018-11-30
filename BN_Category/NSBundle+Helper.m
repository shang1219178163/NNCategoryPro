//
//  NSBundle+Helper.m
//  ProductTemplet
//
//  Created by hsf on 2018/11/28.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "NSBundle+Helper.h"

@implementation NSBundle (Helper)

NSBundle *NSBundleFromParams(Class aClass, NSString *bundleName){
    NSString *path = [NSBundle bundleForClass:aClass].resourcePath;
    NSString *key = [[path componentsSeparatedByString:@"/"].lastObject componentsSeparatedByString:@"."].firstObject;
    
    path = [path stringByReplacingOccurrencesOfString:key withString:bundleName];
    NSString *bundlePath = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"/%@.bundle",bundleName]];
    NSLog(@"\n%@",bundlePath);
    NSBundle *resource_bundle = [NSBundle bundleWithPath:bundlePath];
    return resource_bundle;
}

NSBundle *NSBundleFromString(NSString *string){
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
