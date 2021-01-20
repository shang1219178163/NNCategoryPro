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

NSString * NSStringFromIndexPath(NSIndexPath *indexPath);

@interface NSString (Helper)
///判断 self是否为空字符
@property (nonatomic, assign, readonly) BOOL isEmpty;

///->NSData
@property (nonatomic, strong, readonly) NSData *jsonData;
///->id
@property (nonatomic, strong, readonly, nullable) id objValue;
///->NSDictionary
@property (nonatomic, strong, readonly, nullable) NSDictionary *dictValue;
///->NSArray
@property (nonatomic, strong, readonly, nullable) NSArray *arrayValue;

@property (nonatomic, assign, readonly) BOOL boolValue;

@property (nonatomic, strong, readonly) NSString *localized;

@property (nonatomic, strong, readonly) NSDecimalNumber *decNumer;

///过滤前后空格
@property (nonatomic, strong, readonly) NSString *trimmed;
/// 过滤字符集
@property(nonatomic, copy, readonly) NSString *(^trimmedBy)(NSString *);
@property(nonatomic, copy, readonly) NSString *(^trimmedBySet)(NSCharacterSet *);

@property(nonatomic, copy, readonly) NSString *(^subStringBy)(NSUInteger loc, NSUInteger len);
@property(nonatomic, copy, readonly) NSString *(^subStringFrom)(NSUInteger from);
@property(nonatomic, copy, readonly) NSString *(^subStringTo)(NSUInteger to);

@property(nonatomic, copy, readonly) NSString *(^appending)(NSString *);

@property(nonatomic, copy, readonly) NSString *(^appendingFormat)(NSString *format, ...);

@property(nonatomic, copy, readonly) NSString *(^replacingOccurrences)(NSString *, NSString *, NSStringCompareOptions);
@property(nonatomic, copy, readonly) NSString *(^replacingCharacters)(NSRange, NSString *);

@property(nonatomic, copy, readonly) NSComparisonResult (^compareBy)(NSString *, NSStringCompareOptions);

@property(nonatomic, copy, readonly) BOOL (^equalTo)(NSString *);

@property(nonatomic, copy, readonly) BOOL (^hasPrefix)(NSString *);
@property(nonatomic, copy, readonly) BOOL (^hasSuffix)(NSString *);
@property(nonatomic, copy, readonly) BOOL (^contains)(NSString *);
@property(nonatomic, copy, readonly) NSRange (^rangeBy)(NSString *, NSStringCompareOptions);
@property(nonatomic, copy, readonly, nullable) NSData *(^encoding)(NSStringEncoding);

///componentsSeparatedByString
@property(nonatomic, strong, readonly) NSArray<NSString *> *(^separatedBy)(NSString *);
///componentsSeparatedByString
@property(nonatomic, strong, readonly) NSArray<NSString *> *(^separatedBySet)(NSCharacterSet *);

@property (nonatomic, strong, readonly) NSString *urlDecoded;
@property (nonatomic, strong, readonly) NSString *urlEncoded;
@property (nonatomic, assign, readonly) BOOL isValidUrl;
@property (nonatomic, assign, readonly) BOOL isValidHttpUrl;
@property (nonatomic, assign, readonly) BOOL isValidFileUrl;
@property (nonatomic, assign, readonly) BOOL isValidPhone;
@property (nonatomic, assign, readonly) BOOL isValidEmail;

///****-**-** 00:00:00
@property (nonatomic, strong, readonly) NSString *dayBegin;
///****-**-** 23:59:59
@property (nonatomic, strong, readonly) NSString *dayEnd;
///过滤 html 中的文字
@property (nonatomic, strong, readonly) NSString *filterHTML;

///separator 分割后的子元素进行转换
- (NSString *)mapBySeparator:(NSString *)separator transform:(NSString * (NS_NOESCAPE ^)(NSString *obj))transform;

- (CGSize)sizeWithFont:(UIFont *)font width:(CGFloat)width mode:(NSLineBreakMode)lineBreakMode;

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

- (BOOL)isContainsSet:(NSCharacterSet *)set;

- (NSString *)makeUnicodeToString;
    
- (NSString *)transformToPinyin;

/**
 随即字符串
 */
+ (NSString *)randomStringLength:(NSInteger)length;

- (NSAttributedString *)toAsterisk;

- (void)copyToPasteboard:(BOOL)hiddenTips;

@end


@interface NSMutableString (Ext)

//- (void)appendString:;
@property(nonatomic, copy, readonly) NSMutableString * (^appending)(NSString *);

///- (void)appendFormat:(NSString *)format, ... NS_FORMAT_FUNCTION(1,2);
@property(nonatomic, copy, readonly) NSMutableString * (^appendingFormat)(NSString *format, ...);

///- (void)replaceCharactersInRange: withString:
@property(nonatomic, copy, readonly) NSMutableString * (^replacingCharacters)(NSRange, NSString *);

///- (NSUInteger)replaceOccurrencesOfString: withString: options: range:
@property(nonatomic, copy, readonly) NSMutableString * (^replacingOccurrences)(NSString *, NSString *, NSStringCompareOptions);

///- (void)insertString: atIndex:
@property(nonatomic, copy, readonly) NSMutableString * (^insertAtIndex)(NSString *, NSUInteger);

///- (void)deleteCharactersInRange:
@property(nonatomic, copy, readonly) NSMutableString * (^deleteCharacters)(NSRange);

@end

NS_ASSUME_NONNULL_END
