//
//  NSArray+Helper.h
//  
//
//  Created by BIN on 2018/3/24.
//  Copyright © 2018年 SHANG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <NNGloble/NNGloble.h>

/*
数组合并(去重合并:distinctUnionOfArrays.self、直接合并:unionOfArrays.self)
NSArray *temp1 = @[@3, @2, @2, @1];
NSArray *temp2 = @[@3, @4, @5];
NSLog(@"/n%@",[@[temp1, temp2] valueForKeyPath:@"@distinctUnionOfArrays.self"]);
NSLog(@"/n%@",[@[temp1, temp2] valueForKeyPath:@"@unionOfArrays.self"]);
输出两个数组:( 5, 1, 2, 3, 4 ), ( 3, 2, 2, 1, 3, 4, 5 )。
*/

NS_ASSUME_NONNULL_BEGIN

@interface NSArray<ObjectType> (Helper)

/// ->NSData
@property(nonatomic, strong, readonly, nullable) NSData *jsonData;
/// ->NSString
@property(nonatomic, strong, readonly, nullable) NSString *jsonString;
/// 倒叙
@property(nonatomic, strong, readonly, nullable) NSArray *reversed;

/// componentsJoinedByString
@property(nonatomic, strong, readonly) NSString *(^joinedBy)(NSString *);

@property(nonatomic, strong, readonly) NSArray *(^sorted)(SEL);

@property(nonatomic, strong, readonly) NSArray *(^append)(NSArray *);

@property(nonatomic, strong, readonly) NSArray *(^subarray)(NSUInteger);

/// map 高阶函数
- (NSArray *)map:(id (NS_NOESCAPE ^)(ObjectType obj, NSUInteger idx))transform;

/// forEach 高阶函数
- (void)forEach:(id (NS_NOESCAPE ^)(ObjectType obj, NSUInteger idx))block;

/// compactMap 高阶降维函数
- (NSArray *)compactMap:(id (NS_NOESCAPE ^)(ObjectType obj, NSUInteger idx))transform;

/// filter 高阶函数
- (NSArray *)filter:(BOOL(NS_NOESCAPE ^)(ObjectType obj, NSUInteger idx))transform;

/// reduce 高阶函数(求和,累加等)
- (NSNumber *)reduce:(NSNumber *)initial transform:(NSNumber *(NS_NOESCAPE ^)(NSNumber *result, NSNumber *obj))transform;

/// 排序器排序 @param dic key为排序键;value是升序yes/降序false
- (NSArray *)sorteDescriptorAscending:(NSDictionary<NSString*, NSNumber*> *)dic;

///重复元素
+ (NSArray *)repeating:(ObjectType)repeatedValue count:(NSInteger)count;


- (NSArray<ObjectType> *)filteredArrayUsingPredicateFormat:(NSString *)format, ... NS_FORMAT_FUNCTION(1,2);

/// 交集
- (NSArray *)intersectionWithArray:(NSArray *)array;

/// 并集
- (NSArray *)unionWithArray:(NSArray *)array;

/// 补集
- (NSArray *)relativeComplementWithArray:(NSArray *)array;

/// 差集
- (NSArray *)differenceWithArray:(NSArray *)array;

/// 快速生成一个数组(step代表步长)
+ (NSArray<NSNumber *> *)range:(NSInteger)start end:(NSInteger)end step:(NSInteger)step;

/// from,to之间的随机数数组
+ (NSArray *)arrayRandomFrom:(NSInteger)from to:(NSInteger)to count:(NSInteger)count;

/// 有序图片数组或者字符串数字
+ (NSArray *)arrayItemPrefix:(NSString *)prefix
                  startIndex:(NSInteger)startIndex
                       count:(NSInteger)count;


@end


@interface NSMutableArray<ObjectType> (Helper)

@property(nonatomic, copy, readonly) NSMutableArray *(^addObject)(ObjectType);
@property(nonatomic, copy, readonly) NSMutableArray *(^addObjects)(NSArray<ObjectType> *);

@property(nonatomic, copy, readonly) NSMutableArray *(^insertAtIndex)(ObjectType, NSUInteger);
@property(nonatomic, copy, readonly) NSMutableArray *(^removeAtIndex)(NSUInteger);
@property(nonatomic, copy, readonly) NSMutableArray *(^removeObjects)(NSArray<ObjectType> *);
@property(nonatomic, copy, readonly) NSMutableArray *(^removeAll)(void);

@property(nonatomic, copy, readonly) NSMutableArray *(^replaceAtIndex)(ObjectType, NSUInteger);

@property(nonatomic, copy, readonly) NSMutableArray *(^sort)(SEL);

@end


NS_ASSUME_NONNULL_END



