//
//  NSBundle+Helper.m
//  ProductTemplet
//
//  Created by BIN on 2018/11/28.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "NSBundle+Helper.h"

@implementation NSBundle (Helper)

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
    // CocoaPods resource_bundles：主工程内的 xxx.bundle
    NSURL *assBundleURL = [NSBundle.mainBundle URLForResource:bundleName withExtension:@"bundle"];
    NSBundle *moduleBundle = nil;
    if (!assBundleURL) {
        // CocoaPods use_frameworks：Frameworks/PodName.framework/xxx.bundle
        NSURL *frameworksURL = [NSBundle.mainBundle URLForResource:@"Frameworks" withExtension:nil];
        NSURL *frameworkURL = [[frameworksURL URLByAppendingPathComponent:podName] URLByAppendingPathExtension:@"framework"];
        moduleBundle = frameworkURL ? [NSBundle bundleWithURL:frameworkURL] : nil;
        assBundleURL = [moduleBundle URLForResource:bundleName withExtension:@"bundle"];
        // SPM 资源包命名：PodName_BundleName.bundle
        if (!assBundleURL && moduleBundle) {
            NSString *spmName = [NSString stringWithFormat:@"%@_%@", podName, bundleName];
            assBundleURL = [moduleBundle URLForResource:spmName withExtension:@"bundle"];
        }
    }
    // SPM：.process 资源直接打进 module/framework bundle
    if (!assBundleURL && moduleBundle) {
        return moduleBundle;
    }
    // 静态链接 / 找不到 Frameworks 目录时，通过已知类定位 module bundle
    if (!assBundleURL) {
        Class cls = NSClassFromString(@"NNButton");
        if (cls != Nil) {
            moduleBundle = [NSBundle bundleForClass:cls];
            assBundleURL = [moduleBundle URLForResource:bundleName withExtension:@"bundle"];
            if (!assBundleURL) {
                NSString *spmName = [NSString stringWithFormat:@"%@_%@", podName, bundleName];
                assBundleURL = [moduleBundle URLForResource:spmName withExtension:@"bundle"];
            }
            if (!assBundleURL) {
                return moduleBundle;
            }
        }
    }
    NSCAssert(assBundleURL, @"取不到关联bundle");
    return assBundleURL ? [NSBundle bundleWithURL:assBundleURL] : nil;
}

+ (NSString *)pathBundle:(NSString *)bundleName resource:(NSString *)resource type:(NSString *_Nullable)type{
    NSBundle *bundle = NSBundleFromName(bundleName, bundleName);
    NSString *path = [bundle pathForResource:resource ofType:type];
    return path;
}

//+ (NSString *)mj_localizedStringForKey:(NSString *)key{
//    return [self mj_localizedStringForKey:key value:nil];
//}

//+ (NSString *)mj_localizedStringForKey:(NSString *)key value:(NSString *)value{
//    static NSBundle *bundle = nil;
//    if (!bundle) {
//        NSString *language = MJRefreshConfig.defaultConfig.languageCode;
//        // 如果配置中没有配置语言
//        if (!language) {
//            // （iOS获取的语言字符串比较不稳定）目前框架只处理en、zh-Hans、zh-Hant三种情况，其他按照系统默认处理
//            language = [NSLocale preferredLanguages].firstObject;
//        }
//
//        if ([language hasPrefix:@"en"]) {
//            language = @"en";
//        } else if ([language hasPrefix:@"zh"]) {
//            if ([language rangeOfString:@"Hans"].location != NSNotFound) {
//                language = @"zh-Hans"; // 简体中文
//            } else { // zh-Hant\zh-HK\zh-TW
//                language = @"zh-Hant"; // 繁體中文
//            }
//        } else if ([language hasPrefix:@"ko"]) {
//            language = @"ko";
//        } else if ([language hasPrefix:@"ru"]) {
//            language = @"ru";
//        } else if ([language hasPrefix:@"uk"]) {
//            language = @"uk";
//        } else {
//            language = @"en";
//        }
//
//        // 从MJRefresh.bundle中查找资源
//        bundle = [NSBundle bundleWithPath:[[NSBundle mj_refreshBundle] pathForResource:language ofType:@"lproj"]];
//    }
//    value = [bundle localizedStringForKey:key value:value table:nil];
//    return [[NSBundle mainBundle] localizedStringForKey:key value:value table:nil];
//}

@end
