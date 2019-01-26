//
//  NSBundle+Helper.m
//  ProductTemplet
//
//  Created by BIN on 2018/11/28.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "NSBundle+Helper.h"

@implementation NSBundle (Helper)

NSBundle *NSBundleFromParams(Class aClass, NSString *bundleName){
    return NSBundleFromName(bundleName, bundleName);
    //    NSString *path = [NSBundle bundleForClass:aClass].resourcePath;
    //    NSString *key = [[path componentsSeparatedByString:@"/"].lastObject componentsSeparatedByString:@"."].firstObject;
    //
    //    path = [path stringByReplacingOccurrencesOfString:key withString:bundleName];
    //    NSString *bundlePath = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"/%@.bundle",bundleName]];
    //    NSLog(@"NSBundleFromParams\n%@",bundlePath);
    //    NSBundle *resource_bundle = [NSBundle bundleWithPath:bundlePath];
    //    return resource_bundle;
}

NSBundle *NSBundleFromPodName(NSString *podName){
    return NSBundleFromName(podName, podName);
}

NSBundle *NSBundleFromName(NSString *bundleName, NSString *podName){
    if (!bundleName && !podName) {
        @throw @"bundleName和podName不能同时为空";
    } else if (!bundleName) {
        bundleName = podName;
    } else if (!podName) {
        podName = bundleName;
    }
    
    if ([bundleName containsString:@".bundle"]) {
        bundleName = [bundleName componentsSeparatedByString:@".bundle"].firstObject;
    }
    //没使用framwork的情况下
    NSURL *assBundleURL = [NSBundle.mainBundle URLForResource:bundleName withExtension:@"bundle"];
    //使用framework形式
    if (!assBundleURL) {
        assBundleURL = [NSBundle.mainBundle URLForResource:@"Frameworks" withExtension:nil];
        assBundleURL = [assBundleURL URLByAppendingPathComponent:podName];
        assBundleURL = [assBundleURL URLByAppendingPathExtension:@"framework"];
        NSBundle *associateBunle = [NSBundle bundleWithURL:assBundleURL];
        assBundleURL = [associateBunle URLForResource:bundleName withExtension:@"bundle"];
    }
    
    NSCAssert(assBundleURL, @"取不到关联bundle");
    //生产环境直接返回空
    return assBundleURL ? [NSBundle bundleWithURL:assBundleURL] : nil;
}

+ (NSString *)pathBundle:(NSString *)bundleName resource:(NSString *)resource type:(NSString *)type{
    NSBundle *bundle = NSBundleFromName(bundleName, bundleName);
    NSString *path = [bundle pathForResource:resource ofType:type];
    return path;
}


@end
