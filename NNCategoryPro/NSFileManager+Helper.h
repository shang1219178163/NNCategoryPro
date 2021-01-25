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

@property (class, readonly) NSURL *documentsURL;
@property (class, readonly) NSString *documentsPath;
@property (class, readonly) NSURL *libraryURL;
@property (class, readonly) NSString *libraryPath;
@property (class, readonly) NSURL *cachesURL;
@property (class, readonly) NSString *cachesPath;
@property (class, readonly, assign) CGFloat availableDiskSpace;

+ (NSURL *)fileURLForDirectory:(NSSearchPathDirectory)directory;
+ (NSString *)filePathForDirectory:(NSSearchPathDirectory)directory;

+ (NSString *)fileContentWithName:(NSString *)fileName type:(NSString *)ext;

+ (BOOL)fileExistAtPath:(NSString *)path;
+ (BOOL)createDirectoryAtPath:(NSString *)path;

+ (BOOL)addSkipBackupAttributeToFile:(NSString *)path;

- (unsigned long long)sizeOfFolder:(NSString *)folderPath;
- (NSString *)appFileSize;

+ (id)paserJsonFile:(NSString *)fileName;

+ (void)deleteDocument:(UIDocument *)document withCompletionBlock:(void (^)(void))completionBlock;

@end

NS_ASSUME_NONNULL_END
