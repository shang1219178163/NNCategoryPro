//
//  NSString+Helper.h
//  HuiZhuBang
//
//  Created by BIN on 2017/7/31.
//  Copyright © 2017年 WeiHouKeJi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "NSString+Other.h"

@interface NSString (Helper)

- (BOOL)isPureInteger;
//浮点形判断：
- (BOOL)isPureFloat;

/**
 字符串转number

 */
- (id)numberValue;

- (BOOL)isPureByCharSet:(NSString *)charSet;

- (NSDictionary *)dictionaryValue;

- (NSString *)toFileString;

- (id)jsonFileToObjcWithOptions:(NSJSONReadingOptions)options;

- (id)jsonFileExcelToObjcWithOptions:(NSJSONReadingOptions)options;

- (BOOL)isContainBlank;

- (BOOL)isContainsCharacterSet:(NSCharacterSet *)set;

- (NSString *)subStringFrom:(NSString *)startString to:(NSString *)endString;

- (NSString *)stringBylimitLength:(NSInteger)limitLength;

- (NSString *)makeUnicodeToString;
    

+ (NSString *)stringFromNumber:(NSNumber *)number;

+ (NSString *)stringFromInter:(NSInteger)inter;

+ (NSString *)stringFromFloat:(CGFloat)inter;

+ (NSString *)stringFromDouble:(double)inter;

/**
 随即字符串
 
 */
+ (NSString *)randomStringLength:(NSInteger)length;

/**
 随即产生字符串部分字符组合
 
 */
- (NSString *)randomStringPartLength:(NSInteger)length;

- (BOOL)isTimeStamp;

- (NSString *)toDateShort;

- (NSString *)toDateMonthDay;

- (NSString *)toBeforeDays:(NSInteger)days;

- (NSString *)compareDate:(NSString *)otherDate isMax:(BOOL)isMax type:(NSNumber *)type;

+ (NSString *)stringFromData:(NSData *)data;


/**
 过滤特殊字符集
 */
- (id)filterString:(NSString *)filterString;

- (NSString *)stringByReplacingList:(NSArray *)list withString:(NSString *)replacement;

- (NSString *)deleteWhiteSpaceBeginEnd;

/**
 弃用
 */
- (NSString *)stringByTitle;

/**
 星号取代字符
 */
- (NSString *)stringByReplacingAsteriskRange:(NSRange)range;

/**
 根据range.length生成相应长度星号字符串
 */
- (NSString *)getAsteriskStringByRange:(NSRange)range;


/**
 取代字符串中某个索引字符
 */
- (NSString *)stringByReplacingCharacterIndex:(NSUInteger)index withString:(NSString *)string;

/**
 获取随机子字符串
 e.g.:0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ

 */
- (NSString *)randomStringLength:(NSInteger)length;

/**
 字符串包含集合任一元素

 @param collection 字符串集合
 @return 是否包含集合中的任一字符串
 */
- (BOOL)containsStringFromCollection:(id)collection;

/**
 
 @param array 字符串数组
 @return 包含所有元素
 */
- (BOOL)containArray:(NSArray *)array;

- (BOOL)stringContainArrObj:(NSArray *)array;

- (NSString *)getPlaceholder;

+ (NSString *)ramdomText;


/**
 弃用

 */
+(NSString *)resultByAnObject:(NSString *)anObject multiplyAnothor:(NSString *)anothor;

#pragma mark - - 加减乘除
-(NSString *)multiplyAnothor:(NSString *)anothor;

-(NSString *)divideAnothor:(NSString *)anothor;

-(NSString *)addAnothor:(id)anothor;

#pragma mark - - other
- (BOOL)isBeyondWithLow:(NSString *)low high:(NSString *)high;

- (void)copyToPasteboard:(BOOL)hiddenTips;

- (void)copyToPasteboard;

- (BOOL)openThisURL;

- (BOOL)callPhone;

@end
