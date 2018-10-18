
//
//  NSTimer+Helper.m
//  HuiZhuBang
//
//  Created by BIN on 2018/5/7.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//

#import "NSTimer+Helper.h"

@implementation NSTimer (Helper)

+ (NSTimer *)BN_timeInterval:(NSTimeInterval)interval
                       block:(void(^)(NSTimer *timer))block
                     repeats:(BOOL)repeats{
    
    return [self scheduledTimerWithTimeInterval:interval
                                         target:self
                                       selector:@selector(BN_handleInvoke:)
                                       userInfo:[block copy]
                                        repeats:repeats];
}

+ (void)BN_handleInvoke:(NSTimer *)timer {
    void(^block)(NSTimer *timer) = timer.userInfo;
    if(block) {
        block(timer);
    }
}

+ (void)stopTimer:(NSTimer *)timer{
    [timer invalidate];
    timer = nil;
    
//    DDLog(@"timer stop!!!");
}



@end
