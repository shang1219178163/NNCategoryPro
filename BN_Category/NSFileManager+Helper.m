

//
//  NSFileManager+Helper.m
//  ProductTemplet
//
//  Created by hsf on 2018/9/30.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "NSFileManager+Helper.h"

@implementation NSFileManager (Helper)

+ (BOOL)fileExistAtPath:(NSString *)path{
    NSFileManager *fileManager = [[NSFileManager alloc]init];
    BOOL isExist = [fileManager fileExistsAtPath:path];
    return isExist;
}

+ (BOOL)createDirectoryAtPath:(NSString *)path{
    NSFileManager *fileManager = [[NSFileManager alloc]init];
    if ([fileManager fileExistsAtPath:path]) {
        return YES;
    }
    BOOL isSuccess = [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    return isSuccess;
}


@end
