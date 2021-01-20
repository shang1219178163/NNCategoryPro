//
//  NSFileManager+Helper.h
//  ProductTemplet
//
//  Created by BIN on 2018/9/30.
//  Copyright © 2018年 BN. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSFileManager (Helper)

@property (class, readonly, nullable) NSURL *documentsURL;
@property (class, readonly, nullable) NSString *documentsPath;
@property (class, readonly, nullable) NSURL *libraryURL;
@property (class, readonly, nullable) NSString *libraryPath;
@property (class, readonly, nullable) NSURL *cachesURL;
@property (class, readonly, nullable) NSString *cachesPath;
@property (class, readonly, assign) CGFloat availableDiskSpace;

+ (NSString *)fileContentWithName:(NSString *)fileName type:(NSString *)ext;

+ (BOOL)fileExistAtPath:(NSString *)path;
+ (BOOL)createDirectoryAtPath:(NSString *)path;

+ (NSURL *)fileURLForDirectory:(NSSearchPathDirectory)directory;
+ (NSString *)filePathForDirectory:(NSSearchPathDirectory)directory;
+ (BOOL)addSkipBackupAttributeToFile:(NSString *)path;

- (unsigned long long)sizeOfFolder:(NSString *)folderPath;
- (NSString *)appFileSize;

+ (id)paserJsonFile:(NSString *)fileName;

+ (void)deleteDocument:(UIDocument *)document withCompletionBlock:(void (^)(void))completionBlock;

@end

NS_ASSUME_NONNULL_END
