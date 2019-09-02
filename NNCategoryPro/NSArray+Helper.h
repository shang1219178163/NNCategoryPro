//
//  NSArray+Helper.h
//  
//
//  Created by BIN on 2018/3/24.
//  Copyright © 2018年 SHANG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NNGloble.h"

/*
数组合并(去重合并:distinctUnionOfArrays.self、直接合并:unionOfArrays.self)
NSArray *temp1 = @[@3, @2, @2, @1];
NSArray *temp2 = @[@3, @4, @5];
NSLog(@"/n%@",[@[temp1, temp2] valueForKeyPath:@"@distinctUnionOfArrays.self"]);
NSLog(@"/n%@",[@[temp1, temp2] valueForKeyPath:@"@unionOfArrays.self"]);
输出两个数组:( 5, 1, 2, 3, 4 ), ( 3, 2, 2, 1, 3, 4, 5 )。
*/

NS_ASSUME_NONNULL_BEGIN

@interface NSArray (Helper)

/**
 map 高阶函数(使用时需要将obj强转为数组元素类型)
 */
//- (NSArray<NSString *> *)map:(NSString *(^)(NSObject *obj, NSUInteger idx))handler;

- (NSArray<NSObject *> *)map:(NSObject *(^)(NSObject *obj, NSUInteger idx))handler;

/**
 filter 高阶函数(使用时需要将obj强转为数组元素类型)
 */
- (NSArray *)filter:(BOOL(^)(NSObject *obj, NSUInteger idx))handler;

/**
 reduce 高阶函数(求和,累加等)
 */
- (NSNumber *)reduce:(NSNumber *(^)(NSNumber *num1, NSNumber *num2))handler;

/**
 数组排序
 */
- (NSArray *)sortedAscending:(BOOL)isAscending;

/**
 排序器排序
 @param dic key为排序键;value是升序yes/降序false
 */
- (NSArray *)sorteDescriptorAscending:(NSDictionary<NSString*, NSNumber*> *)dic;
/// 合并数组
- (NSArray *)contactArray:(NSArray *)array;

/// 快速生成一个数组(step代表步长)
+ (NSArray<NSNumber *> *)range:(NSInteger)start end:(NSInteger)end step:(NSInteger)step;

+ (NSArray *)arrayWithItem:(id)item count:(NSInteger)count;
/**
 from,to之间的随机数数组
 */
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

- (NSArray *)arrayWithObjRange:(NSRange)objRange;

- (NSArray *)arrayWithObjOffset:(NSInteger)offSet;

@end

NS_ASSUME_NONNULL_END
