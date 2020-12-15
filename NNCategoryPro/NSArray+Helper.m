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

#pragma mark -高阶函数
- (NSArray *)map:(id (NS_NOESCAPE ^)(id obj, NSUInteger idx))block{
    if (!block) {
        NSParameterAssert(block != nil);
        return self;
    }
    
    __block NSMutableArray *marr = [NSMutableArray array];
    [self enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        id value = block(obj, idx);
        if (value) {
            [marr addObject:value];
        }
    }];
//    DDLog(@"%@->%@", self, marr.copy);
    return marr.copy;
}

- (NSArray *)compactMap:(id (NS_NOESCAPE ^)(id obj, NSUInteger idx))block{
    if (!block) {
        NSParameterAssert(block != nil);
        return self;
    }
    
    __block NSMutableArray *marr = [NSMutableArray array];
    [self enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        id value = block(obj, idx);
        if ([value isKindOfClass:NSArray.class]) {
            [marr addObjectsFromArray:value];
        } else {
            [marr addObject:value];
        }
    }];
//    DDLog(@"%@->%@", self, marr.copy);
    return marr.copy;
}

- (NSArray *)filter:(BOOL(NS_NOESCAPE ^)(id obj, NSUInteger idx))block{
    if (!block) {
        NSParameterAssert(block != nil);
        return self;
    }

    __block NSMutableArray *marr = [NSMutableArray array];
    [self enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (block(obj, idx) == true) {
            [marr addObject:obj];
        }
    }];
    return marr.copy;
}

- (NSNumber *)reduce:(NSNumber *)initial block:(NSNumber *(NS_NOESCAPE ^)(NSNumber *result, NSNumber *obj))block{
    if (!block) {
        NSParameterAssert(block != nil);
        return initial;
    }

    __block NSNumber *value = initial;
    [self enumerateObjectsUsingBlock:^(NSNumber *_Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        value = block(value, obj);
    }];
    return value;
}
#pragma mark -其他方法

- (NSArray *)sorted{
    return [self sortedArrayUsingSelector:@selector(compare:)];
}

- (NSArray *)reversed{
    return self.reverseObjectEnumerator.allObjects;
}

- (NSArray *)sorteDescriptorAscending:(NSDictionary<NSString*, NSNumber*> *)dic{
    __block NSMutableArray *marr = [NSMutableArray array];
    [dic enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, NSNumber * _Nonnull obj, BOOL * _Nonnull stop) {
        NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:key ascending: obj.boolValue];
        [marr addObject:sort];
    }];
    return [self sortedArrayUsingDescriptors:marr.copy];
}

- (NSArray *)contactArray:(NSArray *)array{
    NSMutableArray *marr = [NSMutableArray arrayWithArray:self];
    [marr addObjectsFromArray:array];
    return marr.copy;
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

- (NSMutableArray *)filterByPropertyList:(NSArray *)propertyList isNumValue:(BOOL)isNumValue {
    __block NSMutableArray *listArr = [NSMutableArray array];
    [self enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSMutableArray *marr = [NSMutableArray array];
        for (NSString * key in propertyList) {
            id value = [obj valueForKey:key];
            value = isNumValue == NO ? value : [value numberValue];
            [marr addSafeObjct:value];
        }
        [listArr addSafeObjct:marr];
    }];
    return listArr;
}

- (NSMutableArray *)filterByPropertyList:(NSArray *)propertyList prefix:(NSString *)prefix isNumValue:(BOOL)isNumValue {
    NSMutableArray *marr = [NSMutableArray array];
    [propertyList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [marr addSafeObjct:[prefix stringByAppendingString:obj]];
        
    }];
    NSMutableArray *list = [self filterByPropertyList:marr isNumValue:isNumValue];
    return list;
}

- (NSArray *)filterListByQueryContain:(NSString *)query{
    NSMutableArray *marr = [NSMutableArray arrayWithCapacity:0];
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([query containsString:obj]) {
            [marr addObject:obj];
        }
    }];
    return marr.copy;
}


@end


@implementation NSString (Ext)

- (NSString *)mapOffsetFloat:(CGFloat)value{
    NSString *result = [[[self componentsSeparatedByString:@","] map:^id _Nonnull(NSString *obj, NSUInteger idx) {
        obj = ![obj isEqualToString:@""] ? obj : @"0.0";
        NSNumber *num = @([obj floatValue] + value);
        return [num stringValue];
        
    }] componentsJoinedByString:@","];
    return result;
}

- (NSString *)mapOffsetInter:(NSInteger)value{
    NSString *result = [[[self componentsSeparatedByString:@","] map:^id _Nonnull(NSString *obj, NSUInteger idx) {
        obj = ![obj isEqualToString:@""] ? obj : @"0";
        NSNumber *num = @([obj integerValue] + value);
        return [num stringValue];
        
    }] componentsJoinedByString:@","];
    return result;
}

@end
