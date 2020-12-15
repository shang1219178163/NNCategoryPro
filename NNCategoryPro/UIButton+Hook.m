//
//  UIButton+Hook.m
//  NNCategoryPro
//
//  Created by Bin Shang on 2019/12/27.
//

#import "UIButton+Hook.h"
#import "NSObject+Hook.h"

@implementation UIButton (Hook)
 
+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        swizzleInstanceMethod(self.class, @selector(sendAction:to:forEvent:), @selector(hook_sendAction:to:forEvent:));
        swizzleInstanceMethod(self.class, @selector(setImage:forState:), @selector(hook_setImage:forState:));
        swizzleInstanceMethod(self.class, @selector(hook_setBackgroundImage:forState:), @selector(hook_setBackgroundImage:forState:));
    });
}

-(void)hook_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event{
//    [self logGatherWithSendAction:action to:target forEvent:event];
    [self hook_sendAction:action to:target forEvent:event];
    
}

#pragma mark -swz_setImage
- (void)hook_setImage:(nullable UIImage *)image forState:(UIControlState)state{
    [self hook_setImage:image forState:state];
    if (image) {
        self.adjustsImageWhenHighlighted = false;
    }
}

#pragma mark -swz_setBackgroundImage
- (void)hook_setBackgroundImage:(nullable UIImage *)image forState:(UIControlState)state{
    [self hook_setBackgroundImage:image forState:state];
    if (image) {
        self.adjustsImageWhenHighlighted = false;
    }
}

/// 日志收集/埋点
- (void)logGatherWithSendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event {
//    if (event.allTouches.anyObject.phase == UITouchPhaseEnded) {
//        NSString *actionStr = NSStringFromSelector(action);
//        NSString *targetName = NSStringFromClass([target class]);
//        NSString *identifer = [NSString stringWithFormat:@"%@ %@", targetName, actionStr];
//    }
}

@end

