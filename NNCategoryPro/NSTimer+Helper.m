
//
//  NSTimer+Helper.m
//  
//
//  Created by BIN on 2018/5/7.
//  Copyright © 2018年 SHANG. All rights reserved.
//

#import "NSTimer+Helper.h"

@implementation NSTimer (Helper)

/**
 分类方法
 */
+ (NSTimer *)scheduledTimer:(NSTimeInterval)interval
                      block:(void(^)(NSTimer *timer))block
                    repeats:(BOOL)repeats{
    return [self scheduledTimerWithTimeInterval:interval
                                         target:self
                                       selector:@selector(handleInvoke:)
                                       userInfo:[block copy]
                                        repeats:repeats];
}

+ (void)handleInvoke:(NSTimer *)timer {
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

/**
 定时器暂停/继续
 */
+ (void)pauseTimer:(NSTimer *)timer isPause:(BOOL)isPause{
//    暂停：触发时间设置在未来，既很久之后，这样定时器自动进入等待触发的状态.
//    继续：触发时间设置在现在/获取，这样定时器自动进入马上进入工作状态.
    timer.fireDate = isPause == false ? NSDate.distantFuture : NSDate.distantPast;
}

+ (dispatch_source_t)createGCDTimer:(NSTimeInterval)interval
                            repeats:(BOOL)repeats
                              block:(void (^)(void))block{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(timer,dispatch_walltime(NULL, 0), interval * NSEC_PER_SEC, 0); //执行间隔
    dispatch_source_set_event_handler(timer, ^{
        if (!repeats) {
            dispatch_source_cancel(timer);
        }
        dispatch_async(dispatch_get_main_queue(), block);
        
    });
    dispatch_resume(timer); // 启动定时器
    return timer;
}
 
+(void)destoryGCDTimer:(dispatch_source_t)timer{
    if (timer) {
        dispatch_source_cancel(timer);
    }
}

@end
