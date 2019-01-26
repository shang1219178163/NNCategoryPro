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

#import "UIColor+Helper.h"
#import "UILabel+Helper.h"

#import "BNGloble.h"

@implementation UIButton (Helper)

/**
 UIButton不同状态下设置富文本标题
 */
- (NSMutableAttributedString *)setContent:(NSString *)content attDic:(NSDictionary *)attDic forState:(UIControlState)state{
    NSMutableAttributedString *attString = [self.titleLabel setContent:content attDic:attDic];
    [self setAttributedTitle:attString forState:state];
    return attString;
}

+(UIButton *)buttonWithSize:(CGSize)size
                    image_N:(id)image_N
                    image_H:(id)image_H
            imageEdgeInsets:(UIEdgeInsets)imageEdgeInsets{
    
    if ([image_N isKindOfClass:[NSString class]]) image_N = [UIImage imageNamed:image_N];
    if ([image_H isKindOfClass:[NSString class]]) image_H = [UIImage imageNamed:image_H];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    if (image_N) [btn setImage:[image_N imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    if (image_H) [btn setImage:image_H forState:UIControlStateHighlighted];
    
    [btn sizeToFit];
        
    CGRect btnRect = btn.frame;
    btnRect.size = size;
    btn.frame = btnRect;

    btn.imageEdgeInsets = imageEdgeInsets;
    return btn;
}

+(UIButton *)buttonWithSize:(CGSize)size
                      title:(NSString *)title
                       font:(NSUInteger)font
               titleColor_N:(UIColor *)titleColor_N
               titleColor_H:(UIColor *)titleColor_H
            titleEdgeInsets:(UIEdgeInsets)titleEdgeInsets {
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:font];
    if (titleColor_N) [btn setTitleColor:titleColor_N forState:UIControlStateNormal];
    if (titleColor_H) [btn setTitleColor:titleColor_H forState:UIControlStateHighlighted];
    
    [btn sizeToFit];
    
    CGRect btnRect = btn.frame;
    btnRect.size = size;
    btn.frame = btnRect;
    
    btn.titleEdgeInsets = titleEdgeInsets;
    btn.exclusiveTouch = YES;

    if (title.length >= 3) {
        CGSize titleSize = [self sizeWithText:title font:@(font) width:UIScreen.width];
        
        btn.frame = CGRectMake(0, 0, titleSize.width, size.height);
        btn.titleEdgeInsets = UIEdgeInsetsMake(-10, -20, -10, -20);
        
        if (title.length == 4) {
            btn.titleLabel.adjustsFontSizeToFitWidth = YES;
            btn.titleLabel.minimumScaleFactor = 1;
        }
    }
    return btn;
}

- (void)startCountdown60s{
    [self startCountdown:60];

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

-(void)startTime:(NSInteger)timeout title:(NSString *)tittle waitTittle:(NSString *)waitTittle{
    __block NSInteger timeOut=timeout; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeOut<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [self setTitle:tittle forState:UIControlStateNormal];
                self.userInteractionEnabled = YES;
            });
        } else {
            //            int minutes = timeout / 60;
            int seconds = timeOut % 60;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                NSLog(@"____%@",strTime);
                [self setTitle:[NSString stringWithFormat:@"%@%@",strTime,waitTittle] forState:UIControlStateNormal];
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


+ (UIView *)buttonRect:(CGRect)rect attDict:(NSDictionary *)dict tag:(NSInteger)tag{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(20, 0, 90, 40);
    button.backgroundColor = UIColor.themeColor;
    [button setImage:[UIImage imageNamed:@"img_like_W"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"img_like_W"] forState:UIControlStateHighlighted];
    
    //button图片的偏移量，距上左下右分别(10, 10, 10, 60)像素点
    [button setTitle:@"点赞" forState:UIControlStateNormal];
    [button setTitle:@"取消" forState:UIControlStateHighlighted];
    [button setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    
    //button标题的偏移量，这个偏移量是相对于图片的
    button.titleEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    button.imageEdgeInsets = UIEdgeInsetsMake(5, 10, 5, 60);

    return button;
    
}

- (CGSize)btnSizeByHeight:(CGFloat)height{
    
    UIButton *sender = self;
    CGSize btnTitleSize = [self sizeWithText:sender.titleLabel.text font:sender.titleLabel.font width:UIScreen.width];

    CGSize  imgSize = sender.imageView.image != nil ? CGSizeMake(height, height) : CGSizeZero;
    CGSize btnSize = CGSizeMake(btnTitleSize.width + imgSize.width + kPadding*2, height);

    return btnSize;
    
}


- (void)showImageType:(NSNumber *)type image:(id)image{
    
    NSParameterAssert([image isKindOfClass:[NSString class]] || [image isKindOfClass:[UIImage class]]);
    UIImage * img = nil;
    if ([image isKindOfClass:[NSString class]]) {
        img = [UIImage imageNamed:image];
        
    } else {
        img = image;
        
    }
    
    switch (type.integerValue) {
        case 1:
        {
            //字+图
            [self.titleLabel sizeToFit];
            [self setTitleEdgeInsets:UIEdgeInsetsMake(0, -img.size.width, 0, img.size.width)];
            [self setImageEdgeInsets:UIEdgeInsetsMake(0, self.titleLabel.bounds.size.width, 0, -self.titleLabel.bounds.size.width)];
        }
            break;
        default:
            break;
    }
}

//- (void)showImageType:(NSNumber *)type{
//
//    UIButton *sender = self;
//
//    CGSize sizeLab = sender.titleLabel.bounds.size;
//    CGSize sizeImg = sender.imageView.bounds.size;
//
//    switch (type.integerValue) {
//        case 1:
//        {
//            //字+图
//            sender.imageEdgeInsets = UIEdgeInsetsMake(0, sizeLab.width, 0, -sizeLab.width);
//            sender.titleEdgeInsets = UIEdgeInsetsMake(0, -sizeImg.width, 0, sizeImg.width);
//        }
//            break;
//        default:
//            break;
//    }
//}


@end

