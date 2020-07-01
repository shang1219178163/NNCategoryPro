//
//  NSFileManager+Helper.m
//  ProductTemplet
//
//  Created by BIN on 2018/9/30.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "NSFileManager+Helper.h"

@implementation NSFileManager (Helper)

+ (NSURL *)documentsURL{
    return [self fileURLForDirectory:NSDocumentDirectory];
}

+ (NSString *)documentsPath{
    return [self filePathForDirectory:NSDocumentDirectory];
}

+ (NSURL *)libraryURL{
    return [self fileURLForDirectory:NSLibraryDirectory];
}

+ (NSString *)libraryPath{
    return [self filePathForDirectory:NSLibraryDirectory];
}

+ (NSURL *)cachesURL{
    return [self fileURLForDirectory:NSCachesDirectory];
}

+ (NSString *)cachesPath{
    return [self filePathForDirectory:NSCachesDirectory];
}

+ (CGFloat)availableDiskSpace{
    NSDictionary *attributes = [self.defaultManager attributesOfFileSystemForPath:self.documentsPath error:nil];
    double size = [attributes[NSFileSystemFreeSize] unsignedLongLongValue] / (double)0x100000;
    return (CGFloat)size;
}

+ (BOOL)fileExistAtPath:(NSString *)path{
    return [self.defaultManager fileExistsAtPath:path];;
}

+ (BOOL)createDirectoryAtPath:(NSString *)path{
    if ([self.defaultManager fileExistsAtPath:path]) {
        return YES;
    }
    BOOL isSuccess = [self.defaultManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    return isSuccess;
}

+ (NSURL *)fileURLForDirectory:(NSSearchPathDirectory)directory{
    return [self.defaultManager URLsForDirectory:directory inDomains:NSUserDomainMask].lastObject;
}

+ (NSString *)filePathForDirectory:(NSSearchPathDirectory)directory{
    return NSSearchPathForDirectoriesInDomains(directory, NSUserDomainMask, YES)[0];
}

+ (BOOL)addSkipBackupAttributeToFile:(NSString *)path{
    return [[NSURL.alloc initFileURLWithPath:path] setResourceValue:@(YES) forKey:NSURLIsExcludedFromBackupKey error:nil];
}

- (unsigned long long)sizeOfFolder:(NSString *)folderPath{
    NSArray *contents = [NSFileManager.defaultManager contentsOfDirectoryAtPath:folderPath error:nil];
    NSEnumerator *contentsEnumurator = [contents objectEnumerator];
    
    NSString *file;
    unsigned long long folderSize = 0;
    
    while (file = [contentsEnumurator nextObject]) {
        NSDictionary *fileAttributes = [NSFileManager.defaultManager attributesOfItemAtPath:[folderPath stringByAppendingPathComponent:file] error:nil];
        folderSize += [fileAttributes[NSFileSize] intValue];
    }
    return folderSize;
}

- (NSString *)appFileSize{
    unsigned long long docSize   =  [self sizeOfFolder:NSFileManager.documentsPath];
    unsigned long long libSize   =  [self sizeOfFolder:NSFileManager.libraryPath];
    unsigned long long cacheSize =  [self sizeOfFolder:NSFileManager.cachesPath];
    
    unsigned long long total = docSize + libSize + cacheSize;
    
    NSString *folderSizeStr = [NSByteCountFormatter stringFromByteCount:total countStyle:NSByteCountFormatterCountStyleFile];
    return folderSizeStr;
}

+(id)paserJsonFile:(NSString *)fileName{
    NSParameterAssert([fileName containsString:@".geojson"]);
    
    NSArray * fileNameArray = [fileName componentsSeparatedByString:@"."];
    NSString * path = [NSBundle.mainBundle pathForResource:fileNameArray.firstObject ofType:fileNameArray.lastObject];
    NSData * data = [NSData dataWithContentsOfFile:path];
    NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\\" withString:@""];
    
    NSError * error = nil;
    id obj = [NSJSONSerialization JSONObjectWithData:[jsonString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:&error];
//    DDLog(@"%@",error.description);
    return obj;
}

+ (void)deleteDocument:(UIDocument *)document withCompletionBlock:(void (^)(void))completionBlock {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        
        NSError *fileCoordinatorError = nil;
        
        [[[NSFileCoordinator alloc] initWithFilePresenter:nil] coordinateWritingItemAtURL:document.fileURL
                                                                                  options:NSFileCoordinatorWritingForDeleting
                                                                                    error:&fileCoordinatorError
                                                                               byAccessor:^(NSURL *newURL) {
            
            // extra check to ensure coordinator is not running on main thread
            NSAssert(![NSThread isMainThread], @"Must be not be on main thread");
            
            // create a fresh instance of NSFileManager since it is not thread-safe
            NSFileManager *fileManager = [[NSFileManager alloc] init];
            NSError *error = nil;
            if (![fileManager removeItemAtURL:newURL error:&error]) {
                NSLog(@"Error: %@", error);
                // TODO handle the error
            }
            
            if (completionBlock) {
                completionBlock();
            }
        }];
    });
}


@end
