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

+(NSBundle *)bundleWithPodName:(NSString *)podName bundleName:(NSString *)bundleName{
    return NSBundleFromName(bundleName, podName);
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
