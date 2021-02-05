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

- (NSArray * _Nonnull (^)(NSUInteger))subarray{
    return ^(NSUInteger value) {
        return [self subarrayWithRange:NSMakeRange(0, MIN(value, self.count))];
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

- (void)forEach:(id (NS_NOESCAPE ^)(id obj, NSUInteger idx))block{
    if (!block) {
        return;
    }
    [self enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        block(obj, idx);
    }];
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

- (NSArray<id> *)filteredArrayUsingPredicateFormat:(NSString *)format, ... NS_FORMAT_FUNCTION(1,2){
    va_list args;
    va_start(args, format);
    NSString *string = [[NSString alloc] initWithFormat:format arguments:args];
    va_end(args);
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%@", string];
    return [self filteredArrayUsingPredicate:predicate];
}

#pragma mark - Set operations
///交集
- (NSArray *)intersectionWithArray:(NSArray *)array {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF IN %@", array];
    return [self filteredArrayUsingPredicate:predicate];
}

///并集
- (NSArray *)unionWithArray:(NSArray *)array {
    NSArray *complement = [self relativeComplementWithArray:array];
    return [complement arrayByAddingObjectsFromArray:array];
}

///补集
- (NSArray *)relativeComplementWithArray:(NSArray *)array {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"NOT SELF IN %@", array];
    return [self filteredArrayUsingPredicate:predicate];
}

///差集
- (NSArray *)differenceWithArray:(NSArray *)array {
    NSArray *aSubtractB = [self relativeComplementWithArray:array];
    NSArray *bSubtractA = [array relativeComplementWithArray:self];
    return [aSubtractB unionWithArray:bSubtractA];
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
                       count:(NSInteger)count{
    NSMutableArray *marr = [NSMutableArray array];
    for (NSInteger i = startIndex; i <= startIndex + count; i++) {
        NSString *title = [NSString stringWithFormat:@"%@%@",prefix,@(i)];
        [marr addObject:title];
    }
    return marr.copy;
}


@end


@implementation NSMutableArray (Helper)

- (NSMutableArray * _Nonnull (^)(id _Nonnull))addObject{
    return ^(id obj) {
        if (obj) {
            [self addObject:obj];
        }
        return self;
    };
}

- (NSMutableArray * _Nonnull (^)(NSArray<id> *))addObjects{
    return ^(NSArray<id> * value) {
        if (value) {
            [self addObjectsFromArray:value];
        }
        return self;
    };
}

- (NSMutableArray * _Nonnull (^)(id, NSUInteger))insertAtIndex{
    return ^(id value, NSUInteger index) {
        if (value) {
            [self insertObject:value atIndex:index];
        }
        return self;
    };
}

- (NSMutableArray * _Nonnull (^)(NSUInteger))removeAtIndex{
    return ^(NSUInteger index) {
        if (index < self.count) {
            [self removeObjectAtIndex:index];
        }
        return self;
    };
}

- (NSMutableArray * _Nonnull (^)(NSArray<id> *))removeObjects{
    return ^(NSArray<id> * value) {
        [self removeObjectsInArray:value];
        return self;
    };
}

- (NSMutableArray * _Nonnull (^)(void))removeAll{
    return ^(void) {
        [self removeAllObjects];
        return self;
    };
}

- (NSMutableArray * _Nonnull (^)(id, NSUInteger))replaceAtIndex{
    return ^(id value, NSUInteger index) {
        if (index < self.count) {
            [self replaceObjectAtIndex:index withObject:value];
        }
        return self;
    };
}

- (NSMutableArray * _Nonnull (^)(SEL))sort{
    return ^(SEL aSel) {
        [self sortUsingSelector:aSel];
        return self;
    };
}
 
@end

