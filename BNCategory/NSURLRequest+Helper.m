//
//  NSURLRequest+Helper.m
//  ProductTemplet
//
//  Created by Bin Shang on 2019/5/17.
//  Copyright © 2019 BN. All rights reserved.
//

#import "NSURLRequest+Helper.h"

@implementation NSURLRequest (Helper)

+ (NSMutableURLRequest *)request:(NSString *)urlStr httpMethod:(NSString *)httpMethod httpBody:(NSData * _Nullable)httpBody{
    NSURL *url = [NSURL URLWithString:urlStr];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:6];
    request.HTTPMethod = httpMethod;
    request.HTTPBody = httpBody;
    return request;
}

@end
