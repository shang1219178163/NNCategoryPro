//
//  NSBundle+Helper.h
//  ProductTemplet
//
//  Created by hsf on 2018/11/28.
//  Copyright © 2018年 BN. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSBundle (Helper)

FOUNDATION_EXPORT NSBundle *NSBundleFromString(NSString *string);

+ (NSString *)pathBundle:(NSString *)bundleName resource:(NSString *)resource type:(NSString *)type;

@end

NS_ASSUME_NONNULL_END
