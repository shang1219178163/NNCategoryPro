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
    if (color == nil) {
        return;
    }
    UIImage *image = [UIImage imageWithColor:color];
    [self setBackgroundImage:image forState:state];
}

/**
 [源]UIButton创建
 */
+ (instancetype)createRect:(CGRect)rect title:(NSString *)title image:(NSString *_Nullable)image type:(NSNumber *)type{
    UIButton * btn = [self buttonWithType:UIButtonTypeCustom];
    btn.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;

    btn.frame = rect;
    [btn setTitle:title forState:UIControlStateNormal];
//    btn.titleLabel.adjustsFontSizeToFitWidth = YES;
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    btn.imageView.contentMode = UIViewContentModeScaleAspectFit;

    switch (type.integerValue) {
        case 1://主题背景白色字体无圆角
        {
            [btn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
            [btn setBackgroundImage:UIImageColor(UIColor.themeColor) forState:UIControlStateNormal];
        }
            break;
        case 2://白色背景灰色字体无边框
        {
            [btn setTitleColor:UIColor.titleColor9 forState:UIControlStateNormal];
        }
            break;
        case 3://地图定位按钮一类
        {
            [btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
            [btn setBackgroundImage:UIImageColor(UIColor.lightGrayColor) forState:UIControlStateDisabled];
            btn.adjustsImageWhenHighlighted = false;
        }
            break;
        case 4://白色背景主题色字体和边框
        {
            [btn setTitleColor:UIColor.themeColor forState:UIControlStateNormal];
            btn.layer.borderColor = UIColor.themeColor.CGColor;
            btn.layer.borderWidth = kW_LayerBorder;
        }
            break;
        case 5://白色背景主题字体无边框
        {
            [btn setTitleColor:UIColor.themeColor forState:UIControlStateNormal];
        }
            break;
        case 6://红色背景白色字体
        {
            [btn setBackgroundImage:UIImageColor(UIColor.redColor) forState:UIControlStateNormal];
            [btn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
            btn.layer.cornerRadius = 3;
        }
            break;
        case 7://灰色背景黑色字体无边框
        {
            [btn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
            [btn setBackgroundImage:UIImageColor(UIColor.backgroudColor) forState:UIControlStateNormal];

            [btn setTitleColor:UIColor.whiteColor forState:UIControlStateSelected];
            [btn setBackgroundImage:UIImageColor(UIColor.themeColor) forState:UIControlStateSelected];
        }
            break;
        case 8://白色背景红色字体无边框
        {
            [btn setTitleColor:UIColor.redColor forState:UIControlStateNormal];
        }
            break;
        default:
        {
            //白色背景黑色字体灰色边框
            [btn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
            btn.layer.borderColor = UIColor.lineColor.CGColor;
            btn.layer.borderWidth = 1;
        }
            break;
    }
    return btn;
}
/**
 UIButton不同状态下设置富文本标题
 */
- (NSMutableAttributedString *)setContent:(NSString *)content attDic:(NSDictionary *)attDic forState:(UIControlState)state{
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:self.titleLabel.text attributes:attDic];    
    [self setAttributedTitle:attString forState:state];
    return attString;
}

+(UIButton *)buttonWithSize:(CGSize)size
                    imageN:(id)imageN
                    imageH:(id)imageH
            imageEdgeInsets:(UIEdgeInsets)imageEdgeInsets{
    
    if ([imageN isKindOfClass:[NSString class]]) imageN = [UIImage imageNamed:imageN];
    if ([imageH isKindOfClass:[NSString class]]) imageH = [UIImage imageNamed:imageH];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    if (imageN) [btn setImage:[imageN imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    if (imageH) [btn setImage:imageH forState:UIControlStateHighlighted];
    
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
               titleColorN:(UIColor *)titleColorN
               titleColorH:(UIColor *)titleColorH
            titleEdgeInsets:(UIEdgeInsets)titleEdgeInsets {
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:font];
    if (titleColorN) [btn setTitleColor:titleColorN forState:UIControlStateNormal];
    if (titleColorH) [btn setTitleColor:titleColorH forState:UIControlStateHighlighted];
    
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

- (void)showImageType:(NSNumber *)type image:(id)image{
    NSParameterAssert([image isKindOfClass:[NSString class]] || [image isKindOfClass:[UIImage class]]);
    UIImage * img = [image isKindOfClass:[NSString class]] ? [UIImage imageNamed:image] : image;
    
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

