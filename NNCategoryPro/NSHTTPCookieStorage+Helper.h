//
//  NSHTTPCookieStorage+Helper.h
//  ProductTemplet
//
//  Created by BIN on 2018/9/28.
//  Copyright © 2018年 BN. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSHTTPCookieStorage (Helper)

+ (void)saveCookie;

+ (void)loadCookie;

+ (NSString *)storagePath;

+ (NSString *)cookieDesWithToken:(NSString *)token timeout:(NSNumber *)tokenTimeout;

@end

NS_ASSUME_NONNULL_END
