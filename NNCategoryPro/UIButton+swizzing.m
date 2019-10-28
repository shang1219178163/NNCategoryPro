
//
//  UIButton+swizzing.m
//  
//
//  Created by BIN on 2017/12/27.
//  Copyright © 2017年 SHANG. All rights reserved.
//

#import "UIButton+swizzing.h"

#import "NSObject+swizzling.h"

@implementation UIButton (swizzing)

+ (void)initialize{
    if (self == self.class) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            SwizzleMethodInstance(@"UIButton", @selector(sendAction:to:forEvent:), @selector(swz_sendAction:to:forEvent:));
            
            SwizzleMethodInstance(@"UIButton", @selector(setImage:forState:), @selector(swz_setImage:forState:));

            SwizzleMethodInstance(@"UIButton", @selector(swz_setBackgroundImage:forState:), @selector(swz_setBackgroundImage:forState:));
            
        });
    }
}

-(void)swz_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event{
    // 是否小于设定的时间间隔
    BOOL isSendAction = (NSDate.date.timeIntervalSince1970 - self.custom_acceptEventTime >= 1);

    // 更新上一次点击时间戳
    if (self.custom_acceptEventInterval > 0) {
        self.custom_acceptEventTime = NSDate.date.timeIntervalSince1970;
    }
    
    if (isSendAction) {
        // 两次点击的时间间隔小于设定的时间间隔时，才执行响应事件
        [self swz_sendAction:action to:target forEvent:event];
    }
}

- (NSTimeInterval)custom_acceptEventTime{
    return [objc_getAssociatedObject(self, _cmd) doubleValue];
}

- (void)setCustom_acceptEventTime:(NSTimeInterval)custom_acceptEventTime{
    objc_setAssociatedObject(self, @selector(custom_acceptEventTime), @(custom_acceptEventTime), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark -关联
- (NSTimeInterval)custom_acceptEventInterval{
    return [objc_getAssociatedObject(self, _cmd) doubleValue];
}

- (void)setCustom_acceptEventInterval:(NSTimeInterval)custom_acceptEventInterval{
    objc_setAssociatedObject(self, @selector(custom_acceptEventInterval), @(custom_acceptEventInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark -swz_setImage
- (void)swz_setImage:(nullable UIImage *)image forState:(UIControlState)state{
    [self swz_setImage:image forState:state];
    if (image) {
        self.adjustsImageWhenHighlighted = false;
    }
}

#pragma mark -swz_setBackgroundImage
- (void)swz_setBackgroundImage:(nullable UIImage *)image forState:(UIControlState)state{
    [self swz_setBackgroundImage:image forState:state];
    if (image) {
        self.adjustsImageWhenHighlighted = false;
    }
}

@end

