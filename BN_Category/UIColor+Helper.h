//
//  UIColor+Helper.h
//  HuiZhuBang
//
//  Created by BIN on 2018/9/11.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Helper)

@property (class, nonatomic, readonly) UIColor *randomColor;
@property (class, nonatomic, readonly) UIColor *themeColor;
@property (class, nonatomic, readonly) UIColor *backgroudColor;
@property (class, nonatomic, readonly) UIColor *lineColor;
@property (class, nonatomic, readonly) UIColor *btnColor_N;
@property (class, nonatomic, readonly) UIColor *btnColor_H;
@property (class, nonatomic, readonly) UIColor *btnColor_D;
@property (class, nonatomic, readonly) UIColor *excelColor;

/**
 十六进制颜色
 */
+ (UIColor *)colorWithHexString:(NSString *)colorString;

+ (BOOL)isLightColor:(UIColor*)color;

@end

