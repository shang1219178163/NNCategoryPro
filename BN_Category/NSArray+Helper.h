//
//  NSArray+Helper.h
//  HuiZhuBang
//
//  Created by BIN on 2018/3/24.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString * const kArr_avg = @"@avg.floatValue";

static NSString * const kArr_sum_inter = @"@sum.intValue";
static NSString * const kArr_max_inter = @"@max.intValue";
static NSString * const kArr_min_inter = @"@min.intValue";

static NSString * const kArr_sum_float = @"@sum.floatValue";
static NSString * const kArr_max_float = @"@max.floatValue";
static NSString * const kArr_min_float = @"@min.floatValue";


@interface NSArray (Helper)

+ (NSArray *)arrayWithItem:(id)item count:(NSInteger)count;

+ (NSArray *)arrayWithItemFrom:(NSInteger)from to:(NSInteger)to count:(NSInteger)count;


/**
   有序图片数组或者字符串数字

 @param type @0字符串数组 ,@1:UIImage数组,
 @return 数组
 */
+ (NSArray *)arrayWithItemPrefix:(NSString *)prefix startIndex:(NSInteger)startIndex count:(NSInteger)count type:(NSNumber *)type;


/**
 弃用
 */
- (NSArray *)BN_filterModelListByQuery:(NSString *)query isNumValue:(BOOL)isNumValue;
- (NSArray *)BN_filterModelListByQuery:(NSString *)query;


/**
 推荐
 */
- (NSMutableArray *)BN_filterByPropertyList:(NSArray *)propertyList isNumValue:(BOOL)isNumValue;
- (NSMutableArray *)BN_filterByPropertyList:(NSArray *)propertyList prefix:(NSString *)prefix isNumValue:(BOOL)isNumValue;

- (NSArray *)BN_filterListByQueryContain:(NSString *)query;


- (id)BN_filterModelByKey:(NSString *)key value:(id)value;

- (id)BN_resultBykeyPath:(NSString *)key valuePath:(NSString *)value isImg:(BOOL)isImg;

- (NSArray *)sortedByAscending;

- (NSArray *)arrayWithObjRange:(NSRange)objRange;

- (NSArray *)arrayWithObjOffset:(NSInteger)offSet;

@end
