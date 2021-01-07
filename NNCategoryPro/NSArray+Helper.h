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

///->NSData
@property(nonatomic, strong, readonly, nullable) NSData *jsonData;
///->NSString
@property(nonatomic, strong, readonly, nullable) NSString *jsonString;
///倒叙
@property(nonatomic, strong, readonly, nullable) NSArray *reversed;

///componentsJoinedByString
@property(nonatomic, strong, readonly) NSString *(^joinedBy)(NSString *);

@property(nonatomic, strong, readonly) NSArray *(^sorted)(SEL);

@property(nonatomic, strong, readonly) NSArray *(^append)(NSArray *);

/**
 map 高阶函数
 */
- (NSArray *)map:(id (NS_NOESCAPE ^)(ObjectType obj, NSUInteger idx))transform;

/**
compactMap 高阶降维函数
*/
- (NSArray *)compactMap:(id (NS_NOESCAPE ^)(ObjectType obj, NSUInteger idx))transform;

/**
 filter 高阶函数
 */
- (NSArray *)filter:(BOOL(NS_NOESCAPE ^)(ObjectType obj, NSUInteger idx))transform;

/**
 reduce 高阶函数(求和,累加等)
 */
- (NSNumber *)reduce:(NSNumber *)initial transform:(NSNumber *(NS_NOESCAPE ^)(NSNumber *result, NSNumber *obj))transform;

/**
 排序器排序
 @param dic key为排序键;value是升序yes/降序false
 */
- (NSArray *)sorteDescriptorAscending:(NSDictionary<NSString*, NSNumber*> *)dic;

///重复元素
+ (NSArray *)repeating:(id)repeatedValue count:(NSInteger)count;

/// 快速生成一个数组(step代表步长)
+ (NSArray<NSNumber *> *)range:(NSInteger)start end:(NSInteger)end step:(NSInteger)step;
/**
 from,to之间的随机数数组
 */
+ (NSArray *)arrayRandomFrom:(NSInteger)from to:(NSInteger)to count:(NSInteger)count;

/**
   有序图片数组或者字符串数字

 @param type @0字符串数组 ,@1:UIImage数组,
 @return 数组
 */
+ (NSArray *)arrayItemPrefix:(NSString *)prefix
                  startIndex:(NSInteger)startIndex
                       count:(NSInteger)count
                        type:(NSNumber *)type;


@end

@interface NSString (Ext)
///componentsSeparatedByString
@property(nonatomic, strong, readonly) NSArray<NSString *> *(^separatedBy)(NSString *);

///separator 分割后的子元素进行转换
- (NSString *)mapBySeparator:(NSString *)separator transform:(NSString * (NS_NOESCAPE ^)(NSString *obj))transform;

@end

NS_ASSUME_NONNULL_END



