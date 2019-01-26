//
//  NSBundle+Helper.h
//  ProductTemplet
//
//  Created by BIN on 2018/11/28.
//  Copyright © 2018年 BN. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSBundle (Helper)

FOUNDATION_EXPORT NSBundle *NSBundleFromParams(Class aClass, NSString *bundleName);
FOUNDATION_EXPORT NSBundle *NSBundleFromPodName(NSString *podName);
FOUNDATION_EXPORT NSBundle *NSBundleFromName(NSString *bundleName, NSString *podName);

+ (NSString *)pathBundle:(NSString *)bundleName resource:(NSString *)resource type:(NSString *)type;

@end

NS_ASSUME_NONNULL_END
