//
//  NSFileManager+Helper.h
//  ProductTemplet
//
//  Created by hsf on 2018/9/30.
//  Copyright © 2018年 BN. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSFileManager (Helper)

#pragma mark - -文件管理

+ (BOOL)fileExistAtPath:(NSString *)path;

+ (BOOL)createDirectoryAtPath:(NSString *)path;


@end
