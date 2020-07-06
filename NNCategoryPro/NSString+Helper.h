//
//  NSString+Helper.h
//  
//
//  Created by BIN on 2017/7/31.
//  Copyright © 2017年 SHANG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "NSString+Other.h"

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Helper)
///判断 self是否有效
@property (nonatomic, assign, readonly) BOOL isValid;
///->NSData
@property (nonatomic, strong, readonly) NSData *jsonData;
///->id
@property (nonatomic, strong, readonly) id objValue;
///->NSDictionary
@property (nonatomic, strong, readonly) NSDictionary *dictValue;
///->NSArray
@property (nonatomic, strong, readonly) NSArray *arrayValue;

@property (nonatomic, strong, readonly) NSString *localized;
@property (nonatomic, strong, readonly) NSDecimalNumber *decNumer;

/// NSIndexPath->字符串
FOUNDATION_EXPORT NSString * NSStringFromIndexPath(NSIndexPath *indexPath);
/// html->字符串
FOUNDATION_EXPORT NSString * NSStringFromHTML(NSString *html);
/// id类型->字符串
FOUNDATION_EXPORT NSString * NSStringFromLet(id obj);
/// NSInteger->字符串
FOUNDATION_EXPORT NSString * NSStringFromInt(NSInteger obj);
/// CGFloat->字符串
FOUNDATION_EXPORT NSString * NSStringFromFloat(CGFloat obj);

+ (NSString *)repeating:(NSString *)repeatedValue count:(NSInteger)count;
///过滤字符串中的字符
- (NSString *)stringByTrimmingCharactersInString:(NSString *)string;
///取代字符串中某个索引字符
- (NSString *)stringByReplacingCharacterIdx:(NSUInteger)index withString:(NSString *)string;
///星号取代字符
- (NSString *)stringByReplacingAsteriskRange:(NSRange)range;
///获取起止字符串之间的部分
- (NSString *)subStringFrom:(NSString *)startString to:(NSString *)endString;

/// 判断是否时间戳字符串
- (BOOL)isTimeStamp;
/// 整形判断
- (BOOL)isPureInteger;
/// 浮点形判断：
- (BOOL)isPureFloat;

/**
 字符串转number
 */
- (id)numberValue;

- (BOOL)isPureByCharSet:(NSString *)charSet;

- (NSString *)toFileString;

- (BOOL)isContainBlank;

- (BOOL)isContainsCharacterSet:(NSCharacterSet *)set;

- (NSString *)stringBylimitLength:(NSInteger)limitLength;

- (NSString *)makeUnicodeToString;
    
+ (NSString *)stringFromNumber:(NSNumber *)number;

+ (NSString *)stringFromInter:(NSInteger)inter;

+ (NSString *)stringFromFloat:(CGFloat)inter;

+ (NSString *)stringFromDouble:(double)inter;

- (NSString *)transformToPinyin;

/**
 随即字符串
 */
+ (NSString *)randomStringLength:(NSInteger)length;

/**
 随即产生字符串部分字符组合
 */
- (NSString *)randomStringPartLength:(NSInteger)length;

- (NSString *)toTimestampMonth;

- (NSString *)toTimestampBegin;

- (NSString *)toTimestampEnd;

- (NSString *)toDateShort;

- (NSString *)toDateMonthDay;

+ (NSString *)stringFromData:(NSData *)data;

/**
 过滤特殊字符集
 */
- (id)filterString:(NSString *)filterString;

- (NSString *)deleteWhiteSpaceBeginEnd;

/**
 获取随机子字符串
 e.g.:0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ
 */
- (NSString *)randomStringLength:(NSInteger)length;

/**
 @param array 字符串数组
 @return 包含所有元素
 */
- (BOOL)containArray:(NSArray *)array;

- (NSString *)getPlaceholder;

+ (NSString *)ramdomText;

#pragma mark - -加减乘除
-(NSString *)multiplyAnothor:(NSString *)anothor;

-(NSString *)divideAnothor:(NSString *)anothor;

-(NSString *)addAnothor:(id)anothor;

- (NSAttributedString *)toAsterisk;

#pragma mark - - other
- (BOOL)isBeyondWithLow:(NSString *)low high:(NSString *)high;

- (BOOL)isCompare:(NSString *)string;

- (void)copyToPasteboard:(BOOL)hiddenTips;

- (void)copyToPasteboard;

@end

NS_ASSUME_NONNULL_END
