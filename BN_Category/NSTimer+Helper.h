//
//  NSTimer+Helper.h
//  
//
//  Created by BIN on 2018/5/7.
//  Copyright © 2018年 SHANG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (Helper)

+ (NSTimer *)BN_timeInterval:(NSTimeInterval)interval
                       block:(void(^)(NSTimer *timer))block
                     repeats:(BOOL)repeats;

+ (void)stopTimer:(NSTimer *)timer;

/**
 GCD定时器(秒)
 */
+ (dispatch_source_t)counterWithTimer:(dispatch_source_t)timer handler:(void (^)(void))handler;

+(void)destoryTimer:(dispatch_source_t)timer;


@end
