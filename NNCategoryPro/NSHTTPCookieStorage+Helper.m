//
//  NSHTTPCookieStorage+Helper.m
//  ProductTemplet
//
//  Created by BIN on 2018/9/28.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "NSHTTPCookieStorage+Helper.h"
#import "NSDate+Helper.h"

@implementation NSHTTPCookieStorage (Helper)
/**
 *  cookies存储
 */
+ (void)saveCookie {
    NSMutableArray *cookieData = [NSMutableArray array];
    
    NSHTTPCookieStorage *cookieStorage = NSHTTPCookieStorage.sharedHTTPCookieStorage;
    for (NSHTTPCookie *cookie in cookieStorage.cookies) {
        NSMutableDictionary *cookieDic = [NSMutableDictionary dictionary];
        cookieDic[NSHTTPCookieName] = cookie.name;
        cookieDic[NSHTTPCookieValue] = cookie.value;
        cookieDic[NSHTTPCookieDomain] = cookie.domain;
        cookieDic[NSHTTPCookiePath] = cookie.path;
        cookieDic[NSHTTPCookieSecure] = (cookie.isSecure ? @"YES" : @"NO");
        cookieDic[NSHTTPCookieVersion] = [NSString stringWithFormat:@"%zd", cookie.version];
        if (cookie.expiresDate) cookieDic[NSHTTPCookieExpires] = cookie.expiresDate;
        
        [cookieData addObject:cookieDic];
    }
    
    [cookieData writeToFile:self.storagePath atomically:TRUE];
}
/**
 *  @brief  cookies加载
 */
+ (void)loadCookie{
    NSMutableArray *cookies = [NSMutableArray arrayWithContentsOfFile:self.storagePath];
    NSHTTPCookieStorage *cookieStorage = NSHTTPCookieStorage.sharedHTTPCookieStorage;
    
    for (NSDictionary *cookieData in cookies) {
        [cookieStorage setCookie:[NSHTTPCookie cookieWithProperties:cookieData]];
    }
}

+ (NSString *)storagePath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    return [NSString stringWithFormat:@"%@/Cookies.data", paths[0]];
}


+ (NSString *)cookieDesWithToken:(NSString *)token timeout:(NSNumber *)tokenTimeout{
//    NSArray *cookies = NSHTTPCookieStorage.sharedHTTPCookieStorage.cookies;

    NSDate *expiresDate = [NSDate dateWithTimeIntervalSinceNow:tokenTimeout.integerValue];
    NSString *expires = [NSDateFormatter stringFromDate:expiresDate fmt:kDateFormatSix];
    
    NSString *cookieStr = @"";
//    for (NSHTTPCookie *cookie in cookies) {
//        cookieStr = [cookieStr stringByAppendingFormat:@"%@=%@;", cookie.name, cookie.value];
//    }
    cookieStr = [cookieStr stringByAppendingFormat:@"token=%@;", token];
    cookieStr = [cookieStr stringByAppendingFormat:@"Path=%@;", @"/"];
    //    cookieStr = [cookieStr stringByAppendingFormat:@"Expires=%@;", expiresDate];
    cookieStr = [cookieStr stringByAppendingFormat:@"Expires=%@;", expires];
    cookieStr = [cookieStr stringByAppendingFormat:@"Max-Age=%@;", tokenTimeout.stringValue];
    cookieStr = [cookieStr stringByAppendingFormat:@"httpOnly=%@;",@"true"];
    return cookieStr;
}

@end
