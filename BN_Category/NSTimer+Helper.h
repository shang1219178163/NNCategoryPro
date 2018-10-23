//
//  NSTimer+Helper.h
//  HuiZhuBang
//
//  Created by BIN on 2018/5/7.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (Helper)

+ (NSTimer *)BN_timeInterval:(NSTimeInterval)interval
                       block:(void(^)(NSTimer *timer))block
                     repeats:(BOOL)repeats;

+ (void)stopTimer:(NSTimer *)timer;


@end
