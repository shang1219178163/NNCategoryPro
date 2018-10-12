//
//  NSDictionary+Helper.h
//  HuiZhuBang
//
//  Created by BIN on 2017/8/24.
//  Copyright © 2017年 WeiHouKeJi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Helper)

/**
 根据key对字典values排序,区分大小写(按照ASCII排序)
 */
- (NSArray *)sortedValuesByKey;

- (NSMutableDictionary *)BN_filterDictByContainQuery:(NSString *)query isNumValue:(BOOL)isNumValue;

@end
