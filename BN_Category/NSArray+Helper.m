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

NSString * const kArr_avg_float = @"@avg.floatValue";
NSString * const kArr_sum_inter = @"@sum.intValue";
NSString * const kArr_max_inter = @"@max.intValue";
NSString * const kArr_min_inter = @"@min.intValue";
NSString * const kArr_sum_float = @"@sum.floatValue";
NSString * const kArr_max_float = @"@max.floatValue";
NSString * const kArr_min_float = @"@min.floatValue";
NSString * const kArr_upper_list = @"uppercaseString";//大小写转换
NSString * const kArr_lower_list = @"lowercaseString";//大小写转换
NSString * const kArrs_unionDist_list = @"@distinctUnionOfArrays.self";//数组内部去重
NSString * const kArrs_union_list = @"@unionOfArrays.self";

@implementation NSArray (Helper)


+ (NSArray *)arrayWithItem:(id)item count:(NSInteger)count{
    NSMutableArray * marr = [NSMutableArray arrayWithCapacity:0];
    for (NSInteger i = 0; i < count; i++) {
        [marr addObject:item];
    }
    return marr.copy;
}

+ (NSArray *)arrayWithItemFrom:(NSInteger)from to:(NSInteger)to count:(NSInteger)count{
    NSMutableArray * marr = [NSMutableArray arrayWithCapacity:0];
    for (NSInteger i = 0; i < count; i++) {
        
        NSInteger inter = (from + (arc4random() % (to - from + 1)));
        [marr addObject:@(inter)];
    }
    return marr.copy;
}


+ (NSArray *)arrayWithItemPrefix:(NSString *)prefix startIndex:(NSInteger)startIndex count:(NSInteger)count type:(NSNumber *)type{
    
    NSMutableArray *marr = [NSMutableArray arrayWithCapacity:0];
    for (NSInteger i = startIndex; i <= startIndex + count; i++) {
        NSString *imgName = [NSString stringWithFormat:@"%@%@",prefix,@(i)];
        
        switch (type.integerValue) {
            case 1:
            {
                UIImage *image = [UIImage imageNamed:imgName];
                [marr addObject:image];
            }
                break;
            default:
                [marr addObject:imgName];
                
                break;
        }
        
    }
    return marr.copy;
}

- (NSMutableArray *)BN_filterByPropertyList:(NSArray *)propertyList isNumValue:(BOOL)isNumValue {
    __block NSMutableArray * listArr = [NSMutableArray array];
    [self enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSMutableArray * marr = [NSMutableArray array];
        for (NSString * key in propertyList) {
            id value = [obj valueForKey:key];
            value = isNumValue == NO ? value : [value numberValue];
            [marr addSafeObjct:value];
        }
        [listArr addSafeObjct:marr];
        
    }];
    return listArr;
}

- (NSMutableArray *)BN_filterByPropertyList:(NSArray *)propertyList prefix:(NSString *)prefix isNumValue:(BOOL)isNumValue {
    NSMutableArray * marr = [NSMutableArray array];
    [propertyList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [marr addSafeObjct:[prefix stringByAppendingString:obj]];
        
    }];
    NSMutableArray * list = [self BN_filterByPropertyList:marr isNumValue:isNumValue];
    return list;
}

- (NSArray *)BN_filterListByQueryContain:(NSString *)query{
    
    NSMutableArray * marr = [NSMutableArray arrayWithCapacity:0];
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([query containsString:obj]) {
            [marr addObject:obj];
            
        }
    }];
    return marr.copy;
}


- (id)BN_filterModelByKey:(NSString *)key value:(id)value{
    NSParameterAssert([value isKindOfClass:[NSString class]] || [value isKindOfClass:[NSNumber class]]);
    if ([value isKindOfClass:[NSNumber class]]) {
        value = [value stringValue];
    }
    
    for (id obj in self) {
        if ([[obj valueForKey:key] isEqualToString:value]) {
            return obj;
        }
    }
    return nil;
}


- (id)BN_resultBykeyPath:(NSString *)key valuePath:(NSString *)value isImg:(BOOL)isImg{
    
    if (!value) {
        __block NSMutableArray * marr = [NSMutableArray array];
        [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSString * value = [obj valueForKey:key];
            [marr addSafeObjct:value];
            
        }];
        return marr;
        
    }
    else{
        NSMutableDictionary * mdic = [NSMutableDictionary dictionary];
        [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (key && [key validObject]) {
                NSString * objKey = [obj valueForKey:key];
                NSString * objValue = [obj valueForKey:value];
                objValue = [objValue validObject] ? objValue : @"";
                [mdic setSafeObjct:objValue forKey:objKey];
                
            }
        }];
        return mdic;
        
    }
    return nil;
}


- (NSArray *)sortedByAscending{
    //block比较方法，数组中可以是NSInteger，NSString（需要转换）
    if ([[self firstObject] isKindOfClass:[NSString class]]) {
        NSComparator sort = ^(id string1,id string2){
            if ([string1 integerValue] > [string2 integerValue]) {
                return NSOrderedDescending;
                
            }
            else if ([string1 integerValue] < [string2 integerValue]){
                return NSOrderedAscending;
                
            }
            else
                return NSOrderedSame;
        };
        
        //数组排序：
        NSArray *resultArray = [self sortedArrayUsingComparator:sort];
//        NSLog(@"第一种排序结果：%@",resultArray);
        return resultArray;
        
    }
    else if ([[self firstObject] isKindOfClass:[NSNumber class]]) {
        NSStringCompareOptions options = NSCaseInsensitiveSearch|NSNumericSearch|
        NSWidthInsensitiveSearch|NSForcedOrderingSearch;
        NSComparator sort = ^(NSString *obj1,NSString *obj2){
            NSRange range = NSMakeRange(0,obj1.length);
            return [obj1 compare:obj2 options:options range:range];
        };
        NSArray *resultArray = [self sortedArrayUsingComparator:sort];
//        NSLog(@"字符串数组排序结果%@",resultArray2);
        return resultArray;

    }
    return nil;
    
}


- (NSArray *)arrayWithObjRange:(NSRange)objRange {
    __block NSMutableArray * marr = [NSMutableArray arrayWithCapacity:0];
    [self enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString * tmp = [obj substringWithRange:objRange];
        [marr addSafeObjct:tmp];
        
    }];
    return marr;
}

- (NSArray *)arrayWithObjOffset:(NSInteger)offSet{
    __block NSMutableArray * marr = [NSMutableArray arrayWithCapacity:0];
    
    for (NSInteger i = 0; i < self.count; i++) {
        id obj = self[i];
        if ([obj isEqualToString:@""]) continue;
        id value = [obj isKindOfClass:[NSNumber class]] ? @([obj integerValue] + offSet) : [@([obj integerValue] + offSet) stringValue];
        [marr addSafeObjct:value];
    }
    return marr.copy;
}

@end
