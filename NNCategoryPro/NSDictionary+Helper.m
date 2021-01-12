//
//  NSDictionary+Helper.m
//  
//
//  Created by BIN on 2017/8/24.
//  Copyright © 2017年 SHANG. All rights reserved.
//

#import "NSDictionary+Helper.h"

#import "NSString+Helper.h"
#import "NSArray+Helper.h"
#import "NSMutableArray+Helper.h"

@implementation NSDictionary (Helper)

-(NSData *)jsonData{
    NSError *error;
    NSData *data = [NSJSONSerialization dataWithJSONObject:self options:kNilOptions error:&error];
    if (error) {
        return nil;
    }
    return data;
}

-(NSString *)jsonString{
    NSString *result = [[NSString alloc]initWithData:self.jsonData encoding:NSUTF8StringEncoding];
    return result;
}

- (NSDictionary *)invert{
    __block NSMutableDictionary *mdic = [NSMutableDictionary dictionary];
    [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if (obj) {
            [mdic setObject:key forKey:obj];
        }
    }];
    return mdic.copy;
}

#pragma mark -高阶函数
- (NSDictionary *)map:(NSDictionary *(NS_NOESCAPE ^)(id key, id obj))transform{
    if (!transform) {
        NSParameterAssert(transform != nil);
        return self;
    }
    
    __block NSMutableDictionary *mdic = [NSMutableDictionary dictionary];
    [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        NSDictionary *value = transform(key, obj);
        if (value) {
            [mdic addEntriesFromDictionary:value];
        }
    }];
    return mdic.copy;
}

- (NSDictionary *)filter:(BOOL (NS_NOESCAPE ^)(id key, id obj))transform{
    if (!transform) {
        NSParameterAssert(transform != nil);
        return self;
    }
    
    __block NSMutableDictionary *mdic = [NSMutableDictionary dictionary];
    [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if (transform(key, obj) == true) {
            mdic[key] = obj;
        }
    }];
    return mdic.copy;
}

- (NSDictionary *)compactMapValues:(id (NS_NOESCAPE ^)(id obj))transform{
    if (!transform) {
        NSParameterAssert(transform != nil);
        return self;
    }
    
    __block NSMutableDictionary *mdic = [NSMutableDictionary dictionary];
    [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        id value = transform(obj);
        if (value) {
            mdic[key] = value;
        }
    }];
    return mdic.copy;
}

#pragma mark -其他方法

+ (NSDictionary *)dictionaryFromPlist:(NSString *)plistName {
    if ([plistName containsString:@".plist"]) {
        NSArray *list = [plistName componentsSeparatedByString:@"."];
        NSString *plistPath = [NSBundle.mainBundle pathForResource:list.firstObject ofType:list.lastObject];
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithContentsOfFile:plistPath];
        return dic.copy;
    }
    
    NSString *plistPath = [NSBundle.mainBundle pathForResource:plistName ofType:@"plist"];
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithContentsOfFile:plistPath];
    //    NSLog(@"plistPath_%@",plistPath);
    //    NSLog(@"dic_%@",dic);
    return dic.copy;
}

/**
根据key对字典values排序,区分大小写(按照ASCII排序)
 */
- (NSArray *)sortedValuesByKey{
    NSArray *sortKeyList = [self.allKeys sortedArrayUsingSelector:@selector(compare:)];
    //通过排列的key值获取value
    NSMutableArray *valueArray = [NSMutableArray array];
    for (NSString *key in sortKeyList) {
        if (self[key]) {
            [valueArray addObject:self[key]];
        }
    }
//    DDLog(@"valueArray:%@",valueArray);
    return valueArray.copy;
}

/**
 *  @brief  将NSDictionary转换成url 参数字符串
 *  @return url 参数字符串
 */
- (NSString *)toURLQueryString{
    NSMutableString *string = [NSMutableString string];
    for (NSString *key in [self allKeys]) {
        if ([string length]) {
            [string appendString:@"&"];
        }
        NSString *tmp = [[self objectForKey:key] stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet];
        [string appendFormat:@"%@=%@", key, tmp];
    }
    return string;
}

/**
 *  @brief  将NSDictionary转换成XML 字符串
 *  @return XML 字符串
 */
- (NSString *)XMLString {
    return [self XMLStringWithRootElement:nil declaration:nil];
}

- (NSString *)XMLStringDefaultDeclarationWithRootElement:(NSString*)rootElement{
    return [self XMLStringWithRootElement:rootElement declaration:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>"];
}

- (NSString *)XMLStringWithRootElement:(NSString *)rootElement declaration:(NSString *)declaration{
    NSMutableString *xml = [[NSMutableString alloc] initWithString:@""];
    if (declaration) {
        [xml appendString:declaration];
    }
    if (rootElement) {
        [xml appendString:[NSString stringWithFormat:@"<%@>",rootElement]];
    }
    [self convertNode:self withString:xml andTag:nil];
    if (rootElement) {
        [xml appendString:[NSString stringWithFormat:@"</%@>",rootElement]];
    }
    NSString *finalXML=[xml stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"];
    return finalXML;
}

- (void)convertNode:(id)node withString:(NSMutableString *)xml andTag:(NSString *)tag{
    if ([node isKindOfClass:[NSDictionary class]] && !tag) {
        NSArray *keys = [node allKeys];
        for (NSString *key in keys) {
            [self convertNode:[node objectForKey:key] withString:xml andTag:key];
        }
    } else if ([node isKindOfClass:[NSArray class]]) {
        for (id value in node) {
            [self convertNode:value withString:xml andTag:tag];
        }
    } else {
        [xml appendString:[NSString stringWithFormat:@"<%@>", tag]];
        if ([node isKindOfClass:[NSString class]]) {
            [xml appendString:node];
        } else if ([node isKindOfClass:[NSDictionary class]]) {
            [self convertNode:node withString:xml andTag:nil];
        }
        [xml appendString:[NSString stringWithFormat:@"</%@>", tag]];
    }
}

- (NSString *)plistString{
    NSString *result = [[NSString alloc] initWithData:[self plistData] encoding:NSUTF8StringEncoding];
    return result;
}

- (NSData *)plistData{
    NSError *error = nil;
    return [NSPropertyListSerialization dataWithPropertyList:self format:NSPropertyListXMLFormat_v1_0 options:0 error:&error];
}

@end
