//
//  NSData+Helper.h
//  Location
//
//  Created by BIN on 2017/12/23.
//  Copyright © 2017年 Shang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSData (Helper)

///->id
@property (nonatomic, strong, readonly) id objValue;

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

NS_ASSUME_NONNULL_END
