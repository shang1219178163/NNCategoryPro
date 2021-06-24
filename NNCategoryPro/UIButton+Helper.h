//
//  UIButton+Helper.h
//  
//
//  Created by BIN on 2017/12/27.
//  Copyright © 2017年 SHANG. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

///自定义外观样式
typedef NS_ENUM(NSUInteger, NNButtonType) {
    ///白底黑色字
    NNButtonTypeTitleBlack,
    ///白底主题色字
    NNButtonTypeTitleTheme,
    ///白底主题色字(带边框)
    NNButtonTypeTitleThemeAndOutline,
    ///主题色底白字
    NNButtonTypeTitleWhiteAndBackgroudTheme,
    ///红底白字
    NNButtonTypeTitleWhiteAndBackgroudRed,
    ///白底红字(带边框)
    NNButtonTypeTitleRedAndOutline,
};

@interface UIButton (Helper)

- (void)addActionHandler:(void(^)(UIButton *sender))handler forControlEvents:(UIControlEvents)controlEvents;

- (void)setBackgroundColor:(nullable UIColor *)color forState:(UIControlState)state;

/**
 UIButton 创建
 ///白底黑色字
 NNButtonTypeTitleBlack,
 ///白底主题色字
 NNButtonTypeTitleTheme,
 ///白底主题色字(带边框)
 NNButtonTypeTitleThemeAndOutline,
 ///主题色底白字
 NNButtonTypeTitleWhiteAndBackgroudTheme,
 ///红底白字
 NNButtonTypeTitleWhiteAndBackgroudRed,
 ///白底红字(带边框)
 NNButtonTypeTitleRedAndOutline,
 */
+ (instancetype)createRect:(CGRect)rect title:(NSString *)title type:(NNButtonType)type;

- (void)setCustomType:(NNButtonType)type forState:(UIControlState)state;

- (void)setContent:(NSString *)content attDic:(NSDictionary *)attDic forState:(UIControlState)state;

///验证码倒计时
- (void)startCountdown:(NSTimeInterval)count;
///验证码倒计时
- (void)startTime:(NSInteger)timeout title:(NSString *)title;

- (void)startDisplayLink;

/// 上 左 下 右
- (void)layoutStyle:(NSInteger )style space:(CGFloat)space;

@end

NS_ASSUME_NONNULL_END
