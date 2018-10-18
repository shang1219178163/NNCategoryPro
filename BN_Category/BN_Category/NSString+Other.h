//
//  NSString+Other.h
//  HuiZhuBang
//
//  Created by BIN on 2018/9/18.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kPwdKey_AES           @"mbqh1Gtpj9L8pJuv"

@interface NSString (Other)

- (BOOL)isValidMobileNumber;

- (BOOL)isValidEmailAddress;

- (BOOL)isValidSimpleVerifyIdentityCardNum;

- (BOOL)isValidCarNumber;

- (BOOL)isValidMacAddress;

- (BOOL)isValidUrl;

- (BOOL)isValidChinese;;

- (BOOL)isValidPostalcode;

- (BOOL)isValidTaxNo;

///精确的身份证号码有效性检测
- (BOOL)isValidAccurateVerifyIDCard;

- (BOOL)isValidBankCardluhmCheck;

- (BOOL)isValidIPAddress;

#pragma mark - -Convert
// 十六进制转换为普通字符串的
+ (NSString *)stringFromHexString:(NSString *)hexString;
//普通字符串转换为十六进制的
//+ (NSString *)hexStringFromString:(NSString *)string;
- (NSString *)hexString;

+ (NSString *)base64StringFromData:(NSData *)data length:(NSUInteger)length;

+ (NSString *)hexStringFromData:(NSData *)data;

- (NSString *)md5Encode;

#pragma mark - 加密相关

- (NSString *)AES256EncryptWithKey:(NSString *)key;
- (NSString *)AES256DecryptWithKey:(NSString *)key;

+ (NSString *)AES128Encrypt:(NSString *)content key:(NSString *)key;
+ (NSString *)AES128Decrypt:(NSString *)content key:(NSString *)key;

/**
 字符串aes加密
 
 @param key 加密秘钥(tips:  NOPadding)
 @param encodeType @"0" hex; default base64
 @return 加密字符串
 
 */
- (NSString *)AES128EncryptKey:(NSString *)key encodeType:(NSString *)encodeType;

/**
 字符串aes解密
 
 @param key 加密秘钥(tips:  NOPadding)
 @param encodeType @"0" hex; default base64
 @return 普通字符串
 */
- (NSString *)AES128DecryptKey:(NSString *)key encodeType:(NSString *)encodeType;



@end
