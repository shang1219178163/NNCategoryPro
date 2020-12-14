//
//  NSURLComponents+Helper.m
//  ProductTemplet
//
//  Created by Bin Shang on 2020/12/14.
//  Copyright © 2020 BN. All rights reserved.
//

#import "NSURLComponents+Helper.h"

@implementation NSURLComponents (Helper)

- (NSDictionary *)queryParameters{
    __block NSMutableDictionary *mdic = [NSMutableDictionary dictionary];
    [self.queryItems enumerateObjectsUsingBlock:^(NSURLQueryItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        mdic[obj.name] = obj.value;
    }];
    return mdic;
}

- (NSURL *)appendingQueryParameters:(NSDictionary<NSString *, NSString *> *)parameters {
    __block NSMutableArray *marr = [NSMutableArray arrayWithArray:self.queryItems];
    [parameters enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, NSString * _Nonnull obj, BOOL * _Nonnull stop) {
        NSURLQueryItem *item = [[NSURLQueryItem alloc]initWithName:key value:obj];
        [marr addObject:item];
    }];
    self.queryItems = marr.copy;
    return self.URL;
}

- (nullable NSString *)queryValue:(NSString *)key {
    __block NSString *result;
    [self.queryItems enumerateObjectsUsingBlock:^(NSURLQueryItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj.name isEqualToString:key]) {
            result = obj.value;
            *stop = true;
        }
    }];
    return result;
}


@end
