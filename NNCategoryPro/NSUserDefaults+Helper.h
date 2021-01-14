//
//  NSUserDefaults+Helper.h
//  
//
//  Created by BIN on 2018/3/16.
//  Copyright © 2018年 SHANG. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSUserDefaults (Helper)

+ (NSUserDefaults *)defaults;

+ (void)synchronize;

+ (void)setObject:(id)value forKey:(NSString *)key iCloudSync:(BOOL)sync;

+ (void)setObject:(id)value forKey:(NSString *)key;

+ (id)objectForKey:(NSString *)key iCloudSync:(BOOL)sync;

+ (id)objectForKey:(NSString *)key;

+ (void)synchronizeAndCloudSync:(BOOL)sync;

/// 保存自定义对象
+ (void)setArcObject:(id)value forKey:(NSString *)key;
/// 读取自定义对象
+ (id)arcObjectForKey:(NSString *)key;
    
@end


@interface NSUbiquitousKeyValueStore (Helper)

+ (void)setObject:(id)value forKey:(NSString *)key;

+ (id)objectForKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
