
//
//  UIButton+swizzing.m
//  HuiZhuBang
//
//  Created by BIN on 2017/12/27.
//  Copyright © 2017年 WeiHouKeJi. All rights reserved.
//

#import "UIButton+swizzing.h"

#import "NSObject+swizzling.h"

#define isOpen 1

@implementation UIButton (swizzing)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
     
        if (isOpen) {
            [self swizzleMethodClass:[self class] origMethod:@selector(sendAction:to:forEvent:) newMethod:@selector(BN_sendAction:to:forEvent:)];
            
        }
        
    });
}

-(void)BN_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event{
//    [self BN_sendAction:action to:target forEvent:event];

    // 是否小于设定的时间间隔
//    BOOL needSendAction = (NSDate.date.timeIntervalSince1970 - self.custom_acceptEventTime >= self.custom_acceptEventInterval);
    BOOL needSendAction = (NSDate.date.timeIntervalSince1970 - self.custom_acceptEventTime >= 1);

    // 更新上一次点击时间戳
    if (self.custom_acceptEventInterval > 0) {
        self.custom_acceptEventTime = NSDate.date.timeIntervalSince1970;
    }
    
    if (needSendAction) {
        // 两次点击的时间间隔小于设定的时间间隔时，才执行响应事件
        [self BN_sendAction:action to:target forEvent:event];
    }
    else{
        return;
    }
}

- (NSTimeInterval )custom_acceptEventTime{
    return [objc_getAssociatedObject(self, _cmd) doubleValue];
    
}

- (void)setCustom_acceptEventTime:(NSTimeInterval)custom_acceptEventTime{
    objc_setAssociatedObject(self, @selector(custom_acceptEventTime), @(custom_acceptEventTime), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}


#pragma mark ------ 关联

- (NSTimeInterval )custom_acceptEventInterval{
    return [objc_getAssociatedObject(self, _cmd) doubleValue];
    
}

- (void)setCustom_acceptEventInterval:(NSTimeInterval)custom_acceptEventInterval{
    objc_setAssociatedObject(self, @selector(custom_acceptEventInterval), @(custom_acceptEventInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end

