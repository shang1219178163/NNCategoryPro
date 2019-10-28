//
//  UIColor+Helper.h
//  
//
//  Created by BIN on 2018/9/11.
//  Copyright © 2018年 SHANG. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (Helper)

@property (class, nonatomic) UIColor *themeColor;
@property (class, nonatomic, readonly) UIColor *randomColor;
@property (class, nonatomic, readonly) UIColor *backgroudColor;
@property (class, nonatomic, readonly) UIColor *lineColor;
@property (class, nonatomic, readonly) UIColor *btnColor_N;
@property (class, nonatomic, readonly) UIColor *btnColor_H;
@property (class, nonatomic, readonly) UIColor *btnColor_D;
@property (class, nonatomic, readonly) UIColor *excelColor;
 
@property (class, nonatomic, readonly) UIColor *titleColor;
@property (class, nonatomic, readonly) UIColor *titleSubColor;

@property (class, nonatomic, readonly) UIColor *lightBlue;
@property (class, nonatomic, readonly) UIColor *lightOrange;
@property (class, nonatomic, readonly) UIColor *lightGreen;

@property (class, nonatomic, readonly) UIColor *titleColor3;
@property (class, nonatomic, readonly) UIColor *titleColor6;
@property (class, nonatomic, readonly) UIColor *titleColor9;
/// 背景灰色半透明,子视图不透明
FOUNDATION_EXPORT UIColor * UIColorDim(CGFloat White, CGFloat a);
FOUNDATION_EXPORT UIColor * UIColorRGBA(CGFloat r, CGFloat g, CGFloat b, CGFloat a);
FOUNDATION_EXPORT UIColor * UIColorRGB(CGFloat r, CGFloat g, CGFloat b);
/// 十六进制字符串
FOUNDATION_EXPORT UIColor * UIColorHexAlpha(NSString *hex, CGFloat alpha);
/// 十六进制字符串
FOUNDATION_EXPORT UIColor * UIColorHex(NSString *hex);
/// [源]0x十六进制数值
FOUNDATION_EXPORT UIColor * UIColorHexValueAlpha(NSInteger hex, CGFloat alpha);
/// 0x十六进制数值
FOUNDATION_EXPORT UIColor * UIColorHexValue(NSInteger hexValue);
/// 颜色RGBA数值集合
FOUNDATION_EXPORT NSArray * RGBAFromColor(UIColor *color);
/// 浅色系
FOUNDATION_EXPORT BOOL isLightColor(UIColor *color);
//
+ (UIColor *)colorWithHexString:(NSString *)colorString;

+ (UIColor *)colorWithHexString:(NSString *)colorStr alpha:(CGFloat)alpha;

@end

NS_ASSUME_NONNULL_END
