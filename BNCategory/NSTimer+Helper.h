//
//  NSTimer+Helper.h
//  
//
//  Created by BIN on 2018/5/7.
//  Copyright © 2018年 SHANG. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSTimer (Helper)

+ (NSTimer *)scheduledTimer:(NSTimeInterval)interval
                      block:(void(^)(NSTimer *timer))block
                    repeats:(BOOL)repeats;

+ (void)stopTimer:(NSTimer *)timer;

+ (void)pauseTimer:(NSTimer *)timer isPause:(BOOL)isPause;

/**
 GCD定时器(秒)
 */
+ (dispatch_source_t)counterWithTimer:(dispatch_source_t)timer handler:(void (^)(void))handler;

+(void)destoryTimer:(dispatch_source_t)timer;

@end

NS_ASSUME_NONNULL_END
