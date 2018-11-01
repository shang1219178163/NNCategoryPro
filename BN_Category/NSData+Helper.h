//
//  NSData+Helper.h
//  Location
//
//  Created by BIN on 2017/12/23.
//  Copyright © 2017年 Location. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSData (Helper)

+(NSData *)dataFromObj:(id)obj;

+ (NSData *)base64DataFromString:(NSString *)string;

+ (NSData *)dataFromHexString:(NSString *)hexString;

#pragma mark - - AES
- (NSData *)AES256EncryptWithKey:(NSString *)key;
- (NSData *)AES256DecryptWithKey:(NSString *)key;

+ (NSData *)dataWithBase64EncodedString:(NSString *)string;
- (id)initWithBase64EncodedString:(NSString *)string;

- (NSString *)base64Encoding;
- (NSString *)base64EncodingWithLineLength:(NSUInteger)lineLength;

- (BOOL)hasPrefixBytes:(const void *)prefix length:(NSUInteger)length;
- (BOOL)hasSuffixBytes:(const void *)suffix length:(NSUInteger)length;

@end
