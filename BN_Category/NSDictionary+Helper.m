//
//  NSDictionary+Helper.m
//  HuiZhuBang
//
//  Created by BIN on 2017/8/24.
//  Copyright © 2017年 WeiHouKeJi. All rights reserved.
//

#import "NSDictionary+Helper.h"

#import "NSString+Helper.h"
#import "NSArray+Helper.h"
#import "NSMutableArray+Helper.h"

@implementation NSDictionary (Helper)

/**
根据key对字典values排序,区分大小写(按照ASCII排序)
 */
- (NSArray *)sortedValuesByKey{
    
    //将所有的key放进数组
    NSArray *allKeyArray = self.allKeys;
    
    NSArray *sortKeyList = [allKeyArray sortedArrayUsingSelector:@selector(compare:)];
//    DDLog(@"sortKeyList:%@",sortKeyList);
    if ([[allKeyArray firstObject] isKindOfClass:[NSString class]]) {
        sortKeyList = [self.allKeys sortedByAscending];
    }
    
    //通过排列的key值获取value
    NSMutableArray *valueArray = [NSMutableArray array];
    for (NSString *key in sortKeyList) {
        [valueArray addSafeObjct:self[key]];
        
    }
//    DDLog(@"valueArray:%@",valueArray);
    return valueArray.copy;
}

- (NSMutableDictionary *)BN_filterDictByContainQuery:(NSString *)query isNumValue:(BOOL)isNumValue{
    
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [self.allKeys enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj containsString:query]) {
            id value = self[query];
            value = isNumValue == NO ? value : [value numberValue];
            [dic setObject:value forKey:obj];
            
        }
    }];
    return dic;
}


@end
