//
//  UIButton+Helper.h
//  HuiZhuBang
//
//  Created by BIN on 2017/12/27.
//  Copyright © 2017年 WeiHouKeJi. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "NSObject+Helper.h"//优点全部子类使用;使用性能较差需要一级级去查找

@interface UIButton (Helper)

/**
 导航栏按钮
 */
+(UIButton *)buttonWithSize:(CGSize)size
                 image_N:(id)image_N
                 image_H:(id)image_H
         imageEdgeInsets:(UIEdgeInsets)imageEdgeInsets;

/**
 导航栏按钮
 */
+(UIButton *)buttonWithSize:(CGSize)size
                   title:(NSString *)title
                    font:(NSUInteger)font
            titleColor_N:(UIColor *)titleColor_N
            titleColor_H:(UIColor *)titleColor_H
         titleEdgeInsets:(UIEdgeInsets)titleEdgeInsets;


/**
 验证码倒计时默认60s
 */
- (void)startCountdown60s;

- (void)startCountdown:(NSTimeInterval)count;

- (void)startDisplayLink;

- (CGSize)btnSizeByHeight:(CGFloat)height;

- (void)showImageType:(NSNumber *)type image:(id)image;

@end

