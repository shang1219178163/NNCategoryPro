//
//  UIButton+Helper.m
//  
//
//  Created by BIN on 2017/12/27.
//  Copyright © 2017年 SHANG. All rights reserved.
//

#import "UIButton+Helper.h"
#import <objc/runtime.h>

#import "NSObject+Helper.h"
#import "UIScreen+Helper.h"

#import "UIView+Helper.h"
#import "UIColor+Helper.h"
#import "UILabel+Helper.h"
#import "UIImage+Helper.h"

#import <NNGloble/NNGloble.h>

@implementation UIButton (Helper)

- (void)addActionHandler:(void(^)(UIButton *sender))handler forControlEvents:(UIControlEvents)controlEvents{
    [self addTarget:self action:@selector(p_handleActionBtn:) forControlEvents:controlEvents];
    objc_setAssociatedObject(self, _cmd, handler, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)p_handleActionBtn:(UIButton *)sender{
    void(^block)(UIButton *control) = objc_getAssociatedObject(self, @selector(addActionHandler:forControlEvents:));
    if (block) {
        block(sender);
    }
}

- (void)setBackgroundColor:(nullable UIColor *)color forState:(UIControlState)state{
    if (!color) {
        return;
    }
    UIImage *image = [UIImage imageWithColor:color];
    [self setBackgroundImage:image forState:state];
}

/**
 [源]UIButton创建
 */
+ (instancetype)createRect:(CGRect)rect title:(NSString *)title type:(NNButtonType)type{
    UIButton *btn = [self buttonWithType:UIButtonTypeCustom];
    btn.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;

    btn.frame = rect;
    [btn setTitle:title forState:UIControlStateNormal];
//    btn.titleLabel.adjustsFontSizeToFitWidth = YES;
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    btn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [btn setCustomType:type forState:UIControlStateNormal];
    return btn;
}

- (void)setCustomType:(NNButtonType)type forState:(UIControlState)state{
    switch (type) {
        case NNButtonTypeTitleBlack:
        {
            [self setTitleColor:UIColor.whiteColor forState:state];
            [self setBackgroundImage:UIImageColor(UIColor.whiteColor) forState:state];
        }
            break;
        case NNButtonTypeTitleTheme:
        {
            [self setTitleColor:UIColor.themeColor forState:state];
            [self setBackgroundImage:UIImageColor(UIColor.whiteColor) forState:state];
        }
            break;
        case NNButtonTypeTitleThemeAndOutline:
        {
            [self setTitleColor:UIColor.themeColor forState:state];
            [self setBackgroundImage:UIImageColor(UIColor.redColor) forState:state];
            
            self.layer.borderColor = UIColor.themeColor.CGColor;
            self.layer.borderWidth = 1;
            self.layer.cornerRadius = 3;
        }
            break;
        case NNButtonTypeTitleWhiteAndBackgroudTheme:
        {
            [self setTitleColor:UIColor.whiteColor forState:state];
            [self setBackgroundImage:UIImageColor(UIColor.themeColor) forState:state];
        }
            break;
        case NNButtonTypeTitleWhiteAndBackgroudRed:
        {
            [self setTitleColor:UIColor.whiteColor forState:state];
            [self setBackgroundImage:UIImageColor(UIColor.redColor) forState:state];
        }
            break;
        case NNButtonTypeTitleRedAndOutline:
        {
            [self setTitleColor:UIColor.redColor forState:state];
            [self setBackgroundImage:UIImageColor(UIColor.redColor) forState:state];
            
            self.layer.borderColor = UIColor.redColor.CGColor;
            self.layer.borderWidth = 1;
            self.layer.cornerRadius = 3;
        }
            break;
        default:
            break;
    }
}

/**
 UIButton不同状态下设置富文本标题
 */
- (void)setContent:(NSString *)content attDic:(NSDictionary *)attDic forState:(UIControlState)state{
    NSString *title = [self titleForState:state];
    NSRange range = [title rangeOfString:content];
    if (!title || range.location == NSNotFound) {
        return ;
    }
    
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:title];
    [attString addAttributes:attDic range:range];
    [self setAttributedTitle:attString forState:state];
}

- (void)startCountdown:(NSTimeInterval)count{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0); // 每秒执行一次
    
    NSTimeInterval seconds = count;
    NSDate *endTime = [NSDate dateWithTimeIntervalSinceNow:seconds]; // 最后期限
    
    dispatch_source_set_event_handler(_timer, ^{
        NSInteger interval = [endTime timeIntervalSinceNow];
        if (interval > 0) { // 更新倒计时
            NSString *timeStr = [NSString stringWithFormat:@"剩余%@秒", @(interval)];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.enabled = NO;
                [self setTitle:timeStr forState:UIControlStateNormal];
            });
        }
        else { // 倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                self.enabled = YES;
                [self setTitle:@"获取验证码" forState:UIControlStateNormal];
            });
        }
    });
    dispatch_resume(_timer);
}

- (void)startTime:(NSInteger)timeout title:(NSString *)title{
    __block NSInteger timeOut = timeout; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeOut <= 0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [self setTitle:title forState:UIControlStateNormal];
                self.userInteractionEnabled = YES;
            });
        } else {
            //            int minutes = timeout / 60;
            int seconds = timeOut % 60;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [self setTitle:[NSString stringWithFormat:@"剩余%@s", strTime] forState:UIControlStateNormal];
                self.userInteractionEnabled = NO;
                
            });
            timeOut--;
            
        }
    });
    dispatch_resume(_timer);
}

/**
 CADisplayLink是一个能让我们以和屏幕刷新率同步的频率将特定的内容画到屏幕上的定时器类。
 CADisplayLink以特定模式注册到runloop后， 每当屏幕显示内容刷新结束的时候，runloop就会向 CADisplayLink指定的target发送一次指定的selector消息，
 CADisplayLink类对应的selector就会被调用一次。
 
 */
- (void)startDisplayLink{
    CADisplayLink *displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(handleDisplayLink:)];
    [displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
}

- (void)handleDisplayLink:(CADisplayLink *)displayLink{

}

/// 上 左 下 右
- (void)layoutStyle:(NSInteger )style space:(CGFloat)space{
    //得到imageView和titleLabel的宽高
    CGFloat imageWidth = self.imageView.frame.size.width;
    CGFloat imageHeight = self.imageView.frame.size.height;
    
    CGFloat labelWidth = self.titleLabel.intrinsicContentSize.width;
    CGFloat labelHeight = self.titleLabel.intrinsicContentSize.height;
    
    //初始化imageEdgeInsets和labelEdgeInsets
    UIEdgeInsets imageEdgeInsets = UIEdgeInsetsZero;
    UIEdgeInsets labelEdgeInsets = UIEdgeInsetsZero;
    
    switch (style) {//上 左 下 右
        case 0:
        {
            imageEdgeInsets = UIEdgeInsetsMake(-labelHeight-space/2, 0, 0, -labelWidth);
            labelEdgeInsets = UIEdgeInsetsMake( 0, -imageWidth, -imageHeight-space/2, 0);
        }
            break;
        case 1:
        {
            imageEdgeInsets = UIEdgeInsetsMake( 0, -space/2, 0, space);
            labelEdgeInsets = UIEdgeInsetsMake( 0, space/2, 0, -space/2);
        }
            break;
        case 2:
        {
            imageEdgeInsets = UIEdgeInsetsMake( 0, 0, -labelHeight-space/2, -labelWidth);
            labelEdgeInsets = UIEdgeInsetsMake( -imageHeight-space/2, -imageWidth, 0, 0);
        }
            break;
        case 3:
        {
            imageEdgeInsets = UIEdgeInsetsMake( 0, labelWidth+space/2, 0, -labelWidth-space/2);
            labelEdgeInsets = UIEdgeInsetsMake( 0, -imageWidth-space/2, 0, imageWidth+space/2);
        }
            break;
        default:
        {
            imageEdgeInsets = UIEdgeInsetsMake( 0, labelWidth+space/2, 0, -labelWidth-space/2);
            labelEdgeInsets = UIEdgeInsetsMake( 0, -imageWidth-space/2, 0, imageWidth+space/2);
        }
            break;
    }
    self.titleEdgeInsets = labelEdgeInsets;
    self.imageEdgeInsets = imageEdgeInsets;
}


@end

