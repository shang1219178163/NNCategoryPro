//
//  NSArray+Helper.h
//  
//
//  Created by BIN on 2018/3/24.
//  Copyright © 2018年 SHANG. All rights reserved.
//

#import <Foundation/Foundation.h>

FOUNDATION_EXPORT NSString * const kArr_avg_float ;
FOUNDATION_EXPORT NSString * const kArr_sum_inter ;
FOUNDATION_EXPORT NSString * const kArr_max_inter ;
FOUNDATION_EXPORT NSString * const kArr_min_inter ;
FOUNDATION_EXPORT NSString * const kArr_sum_float ;
FOUNDATION_EXPORT NSString * const kArr_max_float ;
FOUNDATION_EXPORT NSString * const kArr_min_float ;
FOUNDATION_EXPORT NSString * const kArr_upper_list ;//大小写转换
FOUNDATION_EXPORT NSString * const kArr_lower_list ;//大小写转换
FOUNDATION_EXPORT NSString * const kArrs_unionDist_list ;//数组内部去重
FOUNDATION_EXPORT NSString * const kArrs_union_list ;
/*
数组合并(去重合并:distinctUnionOfArrays.self、直接合并:unionOfArrays.self)
NSArray *temp1 = @[@3, @2, @2, @1];
NSArray *temp2 = @[@3, @4, @5];
NSLog(@"/n%@",[@[temp1, temp2] valueForKeyPath:@"@distinctUnionOfArrays.self"]);
NSLog(@"/n%@",[@[temp1, temp2] valueForKeyPath:@"@unionOfArrays.self"]);
输出两个数组:( 5, 1, 2, 3, 4 ), ( 3, 2, 2, 1, 3, 4, 5 )。
*/
 
 
@interface NSArray (Helper)

+ (NSArray *)arrayWithItem:(id)item count:(NSInteger)count;

+ (NSArray *)arrayRandomFrom:(NSInteger)from to:(NSInteger)to count:(NSInteger)count;

/**
   有序图片数组或者字符串数字

 @param type @0字符串数组 ,@1:UIImage数组,
 @return 数组
 */
+ (NSArray *)arrayItemPrefix:(NSString *)prefix startIndex:(NSInteger)startIndex count:(NSInteger)count type:(NSNumber *)type;

/**
 推荐
 */
- (NSMutableArray *)BNfilterByPropertyList:(NSArray *)propertyList isNumValue:(BOOL)isNumValue;
- (NSMutableArray *)BNfilterByPropertyList:(NSArray *)propertyList prefix:(NSString *)prefix isNumValue:(BOOL)isNumValue;

- (NSArray *)BNfilterListByQueryContain:(NSString *)query;


- (id)BNfilterModelByKey:(NSString *)key value:(id)value;

- (id)BNresultBykeyPath:(NSString *)key valuePath:(NSString *)value isImg:(BOOL)isImg;

- (NSArray *)sortedByAscending;

- (NSArray *)arrayWithObjRange:(NSRange)objRange;

- (NSArray *)arrayWithObjOffset:(NSInteger)offSet;

@end
