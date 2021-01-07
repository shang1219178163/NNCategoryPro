//
//  NSArray+Helper.m
//  
//
//  Created by BIN on 2018/3/24.
//  Copyright © 2018年 SHANG. All rights reserved.
//

//enum{
//    NSCaseInsensitiveSearch = 1,//不区分大小写比较
//    NSLiteralSearch = 2,//区分大小写比较
//    NSBackwardsSearch = 4,//从字符串末尾开始搜索
//    NSAnchoredSearch = 8,//搜索限制范围的字符串
//    NSNumbericSearch = 64//按照字符串里的数字为依据，算出顺序。例如 Foo2.txt < Foo7.txt < Foo25.txt
//    //以下定义高于 mac os 10.5 或者高于 iphone 2.0 可用
//    ,
//    NSDiacriticInsensitiveSearch = 128,//忽略 "-" 符号的比较
//    NSWidthInsensitiveSearch = 256,//忽略字符串的长度，比较出结果
//    NSForcedOrderingSearch = 512//忽略不区分大小写比较的选项，并强制返回 NSOrderedAscending 或者 NSOrderedDescending
//    //以下定义高于 iphone 3.2 可用
//    ,
//    NSRegularExpressionSearch = 1024//只能应用于 rangeOfString:..., stringByReplacingOccurrencesOfString:...和 replaceOccurrencesOfString:... 方法。使用通用兼容的比较方法，如果设置此项，可以去掉 NSCaseInsensitiveSearch 和 NSAnchoredSearch
//}

#import "NSArray+Helper.h"

#import "NSObject+Helper.h"
#import "NSString+Helper.h"
#import "NSNumber+Helper.h"
#import "NSMutableArray+Helper.h"
#import "NSMutableDictionary+Helper.h"

@implementation NSArray (Helper)

- (NSData *)jsonData{
    NSError *error;
    NSData *data = [NSJSONSerialization dataWithJSONObject:self options:kNilOptions error:&error];
    if (error) {
        return nil;
    }
    return data;
}

- (NSString *)jsonString{
    NSString *result = [[NSString alloc]initWithData:self.jsonData encoding:NSUTF8StringEncoding];
    return result;
}

- (NSArray *)reversed{
    return self.reverseObjectEnumerator.allObjects;
}

- (NSArray * (^)(SEL))sorted{
    return ^(SEL aSEL) {
        return [self sortedArrayUsingSelector:aSEL];
    };
}

- (NSString *(^)(NSString *))joinedBy{
    return ^(NSString *value) {
        return [self componentsJoinedByString: value];
    };
}

- (NSArray * _Nonnull (^)(NSArray * _Nonnull))append{
    return ^(NSArray *value) {
        NSMutableArray *marr = [NSMutableArray arrayWithArray:self];
        [marr addObjectsFromArray:value];
        return marr.copy;
    };
}

#pragma mark -高阶函数
- (NSArray *)map:(id (NS_NOESCAPE ^)(id obj, NSUInteger idx))transform{
    if (!transform) {
        NSParameterAssert(transform != nil);
        return self;
    }
    
    __block NSMutableArray *marr = [NSMutableArray array];
    [self enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        id value = transform(obj, idx);
        if (value) {
            [marr addObject:value];
        }
    }];
//    DDLog(@"%@->%@", self, marr.copy);
    return marr.copy;
}

- (NSArray *)compactMap:(id (NS_NOESCAPE ^)(id obj, NSUInteger idx))transform{
    if (!transform) {
        NSParameterAssert(transform != nil);
        return self;
    }
    
    __block NSMutableArray *marr = [NSMutableArray array];
    [self enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        id value = transform(obj, idx);
        if ([value isKindOfClass: [NSArray class]]) {
            [marr addObjectsFromArray:value];
        } else {
            [marr addObject:value];
        }
    }];
//    DDLog(@"%@->%@", self, marr.copy);
    return marr.copy;
}

- (NSArray *)filter:(BOOL(NS_NOESCAPE ^)(id obj, NSUInteger idx))transform{
    if (!transform) {
        NSParameterAssert(transform != nil);
        return self;
    }

    __block NSMutableArray *marr = [NSMutableArray array];
    [self enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (transform(obj, idx) == true) {
            [marr addObject:obj];
        }
    }];
    return marr.copy;
}

- (NSNumber *)reduce:(NSNumber *)initial transform:(NSNumber *(NS_NOESCAPE ^)(NSNumber *result, NSNumber *obj))transform{
    if (!transform) {
        NSParameterAssert(transform != nil);
        return initial;
    }

    __block NSNumber *value = initial;
    [self enumerateObjectsUsingBlock:^(NSNumber *_Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        value = transform(value, obj);
    }];
    return value;
}
#pragma mark -其他方法

- (NSArray *)sorteDescriptorAscending:(NSDictionary<NSString*, NSNumber*> *)dic{
    __block NSMutableArray *marr = [NSMutableArray array];
    [dic enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, NSNumber * _Nonnull obj, BOOL * _Nonnull stop) {
        NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:key ascending: obj.boolValue];
        [marr addObject:sort];
    }];
    return [self sortedArrayUsingDescriptors:marr.copy];
}

+ (NSArray *)repeating:(id)repeatedValue count:(NSInteger)count {
    NSMutableArray *marr = [NSMutableArray array];
    for (NSInteger i = 0; i < count; i++) {
        [marr addObject:repeatedValue];
    }
    return marr.copy;
}

+ (NSArray<NSNumber *> *)range:(NSInteger)start end:(NSInteger)end step:(NSInteger)step{
    assert(start < end);
    NSMutableArray *list = [NSMutableArray array];
    
    NSInteger count = end - start + 1;
    NSInteger k = 0;
    for (NSInteger i = 0; i < count; i++) {
        k = start + step*i;
        if (k < end) {
            [list addObject:@(k)];
        }
    }
    return list.copy;
}

+ (NSArray *)arrayRandomFrom:(NSInteger)from to:(NSInteger)to count:(NSInteger)count{
    NSMutableArray *marr = [NSMutableArray arrayWithCapacity:0];
    for (NSInteger i = 0; i < count; i++) {
        NSInteger inter = (from + (arc4random() % (to - from + 1)));
        [marr addObject:@(inter)];
    }
    return marr.copy;
}

+ (NSArray *)arrayItemPrefix:(NSString *)prefix
                  startIndex:(NSInteger)startIndex
                       count:(NSInteger)count
                        type:(NSNumber *)type{
    NSMutableArray *marr = [NSMutableArray array];
    for (NSInteger i = startIndex; i <= startIndex + count; i++) {
        NSString *title = [NSString stringWithFormat:@"%@%@",prefix,@(i)];
        switch (type.integerValue) {
            case 1:
            {
                UIImage *image = [UIImage imageNamed:title];
                [marr addObject:image];
            }
                break;
            default:
                [marr addObject:title];
                
                break;
        }
    }
    return marr.copy;
}


@end


@implementation NSString (Ext)

- (NSArray<NSString *> *(^)(NSString *))separatedBy{
    return ^(NSString *value) {
        return [self componentsSeparatedByString: value];
    };
}

#pragma mark -高阶函数
- (NSString *)mapBySeparator:(NSString *)separator transform:(NSString * (NS_NOESCAPE ^)(NSString *obj))transform{
    if (!transform) {
        NSParameterAssert(transform != nil);
        return self;
    }
    NSString *result = [self.separatedBy(separator) map:^id _Nonnull(NSString * _Nonnull obj, NSUInteger idx) {
        return transform(obj);
    }].joinedBy(separator);
    return result;
}

@end
