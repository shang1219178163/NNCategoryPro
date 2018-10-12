//
//  NSUserDefaults+Helper.h
//  HuiZhuBang
//
//  Created by BIN on 2018/3/16.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSUserDefaults (Helper)

@property (class, nonatomic, strong, readonly, nonnull) NSArray *typeList;

@property (nonatomic, strong, readonly) NSArray *typeArray;

- (void)BN_setObject:(id)value forKey:(NSString *)defaultName;
- (id)BN_objectForKey:(NSString *)defaultName;

+ (void)BN_setObject:(id)value forKey:(NSString *)defaultName;
+ (id)BN_objectForKey:(NSString *)defaultName;

+ (void)defaultsSynchronize;


@end
