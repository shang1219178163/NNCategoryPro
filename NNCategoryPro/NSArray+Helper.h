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
@property (nonatomic, strong, readonly, nullable) NSData *jsonData;
///->NSString
@property (nonatomic, strong, readonly, nullable) NSString *jsonString;

/**
 map 高阶函数
 */
- (NSArray *)map:(id (NS_NOESCAPE ^)(ObjectType obj, NSUInteger idx))block;

/**
compactMap 高阶降维函数
*/
- (NSArray *)compactMap:(id (NS_NOESCAPE ^)(ObjectType obj, NSUInteger idx))block;

/**
 filter 高阶函数
 */
- (NSArray *)filter:(BOOL(NS_NOESCAPE ^)(ObjectType obj, NSUInteger idx))block;

/**
 reduce 高阶函数(求和,累加等)
 */
- (NSNumber *)reduce:(NSNumber *)initial block:(NSNumber *(NS_NOESCAPE ^)(NSNumber *result, NSNumber *obj))block;

///数组排序
- (NSArray *)sorted;
///数组倒序
- (NSArray *)reversed;
/**
 排序器排序
 @param dic key为排序键;value是升序yes/降序false
 */
- (NSArray *)sorteDescriptorAscending:(NSDictionary<NSString*, NSNumber*> *)dic;
/// 合并数组
- (NSArray *)contactArray:(NSArray *)array;

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

/**
 推荐
 */
- (NSMutableArray *)filterByPropertyList:(NSArray *)propertyList isNumValue:(BOOL)isNumValue;

- (NSMutableArray *)filterByPropertyList:(NSArray *)propertyList prefix:(NSString *)prefix isNumValue:(BOOL)isNumValue;

@end

NS_ASSUME_NONNULL_END


@interface NSString (Ext)

///当子元素都是NSString,给每个元素添加相同哦值
- (NSString *_Nonnull)mapOffsetFloat:(CGFloat)value;
///当子元素都是NSString,给每个元素添加相同哦值
- (NSString *_Nonnull)mapOffsetInter:(NSInteger)value;

@end
