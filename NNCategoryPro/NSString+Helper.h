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
///判断 self是否为空字符
@property (nonatomic, assign, readonly) BOOL isEmpty;

///->NSData
@property (nonatomic, strong, readonly) NSData *jsonData;
///->id
@property (nonatomic, strong, readonly) id objValue;
///->NSDictionary
@property (nonatomic, strong, readonly) NSDictionary *dictValue;
///->NSArray
@property (nonatomic, strong, readonly) NSArray *arrayValue;

@property (nonatomic, assign, readonly) BOOL boolValue;

@property (nonatomic, strong, readonly) NSString *localized;

@property (nonatomic, strong, readonly) NSDecimalNumber *decNumer;

///过滤前后空格
@property (nonatomic, strong, readonly) NSString *trimmed;
/// 过滤字符集
@property(nonatomic, strong, readonly) NSString *(^trimmedBy)(NSString *);

@property(nonatomic, strong, readonly) NSString *(^subStringBy)(NSUInteger loc, NSUInteger len);


@property(nonatomic, strong, readonly) NSString *(^append)(NSString *);

@property(nonatomic, strong, readonly) NSString *(^appendFormat)(NSString *format, ... );

@property(nonatomic, strong, readonly) NSString *(^replace)(NSString *, NSString *);


@property (nonatomic, strong, readonly) NSString *urlDecoded;
@property (nonatomic, strong, readonly) NSString *urlEncoded;
@property (nonatomic, assign, readonly) BOOL isValidUrl;
@property (nonatomic, assign, readonly) BOOL isValidHttpUrl;
@property (nonatomic, assign, readonly) BOOL isValidFileUrl;
@property (nonatomic, assign, readonly) BOOL isValidPhone;
@property (nonatomic, assign, readonly) BOOL isValidEmail;

- (CGSize)sizeWithFont:(UIFont *)font width:(CGFloat)width mode:(NSLineBreakMode)lineBreakMode;

/// NSIndexPath->字符串
FOUNDATION_EXPORT NSString * NSStringFromIndexPath(NSIndexPath *indexPath);
/// html->字符串
FOUNDATION_EXPORT NSString * NSStringFromHTML(NSString *html);

+ (NSString *)repeating:(NSString *)repeatedValue count:(NSInteger)count;

- (NSString *)repeating:(NSInteger)count;

- (NSString *)stringByTrimmingCharactersInString:(NSString *)string;

///取代字符串中某个索引字符
- (NSString *)stringByReplacingCharacterIdx:(NSUInteger)index withString:(NSString *)string;
///星号取代字符
- (NSString *)stringByReplacingAsteriskRange:(NSRange)range;
///获取起止字符串之间的部分
- (NSString *)subStringFrom:(NSString *)startString to:(NSString *)endString;

/// 整形判断
- (BOOL)isPureInteger;
/// 浮点形判断：
- (BOOL)isPureFloat;

- (BOOL)isPureByCharSet:(NSString *)charSet;

- (NSString *)toFileString;

- (BOOL)isContainsCharacterSet:(NSCharacterSet *)set;

- (NSString *)makeUnicodeToString;
    
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

/**
 获取随机子字符串
 e.g.:0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ
 */
- (NSString *)randomStringLength:(NSInteger)length;

+ (NSString *)ramdomText;

- (NSAttributedString *)toAsterisk;

- (void)copyToPasteboard:(BOOL)hiddenTips;
@end

NS_ASSUME_NONNULL_END
