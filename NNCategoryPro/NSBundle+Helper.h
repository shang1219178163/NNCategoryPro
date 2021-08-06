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

/// 获取第三方库bundle资源
FOUNDATION_EXPORT NSBundle *NSBundleFromName(NSString *bundleName, NSString *podName);

/// 获取第三方库bundle资源文件路径
+ (NSString *)pathBundle:(NSString *)bundleName resource:(NSString *)resource type:(NSString *_Nullable)type;

@end

NS_ASSUME_NONNULL_END
