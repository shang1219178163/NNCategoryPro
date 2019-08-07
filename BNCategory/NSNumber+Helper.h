//
//  NSNumber+Helper.h
//  
//
//  Created by BIN on 2018/7/20.
//  Copyright © 2018年 SHANG. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSNumber (Helper)

@property (nonatomic, strong, readonly) NSDecimalNumber *decNumer;

/// 转为max位小数四舍五入
-(NSString *)to_string:(NSUInteger)max;

/// 转为2位小数四舍五入
-(NSString *)to_string;

/// 转为2位小数四舍五入
-(NSString *)stringValue;


@end

NS_ASSUME_NONNULL_END
