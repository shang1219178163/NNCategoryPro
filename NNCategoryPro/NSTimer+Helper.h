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

///GCD定时器(秒)
+ (dispatch_source_t)createGCDTimer:(NSTimeInterval)interval
                            repeats:(BOOL)repeats
                              block:(void (^)(void))block;

+(void)destoryGCDTimer:(dispatch_source_t)timer;

///激活/启动
- (void)activate;
///暂停
- (void)pause;
//销毁
- (void)destroy;

@end

NS_ASSUME_NONNULL_END
