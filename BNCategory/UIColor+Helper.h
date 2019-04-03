//
//  UIColor+Helper.h
//  
//
//  Created by BIN on 2018/9/11.
//  Copyright © 2018年 SHANG. All rights reserved.
//

#import <UIKit/UIKit.h>

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

@property (class, nonatomic, readonly) UIColor *titleColor3;
@property (class, nonatomic, readonly) UIColor *titleColor6;
@property (class, nonatomic, readonly) UIColor *titleColor9;

FOUNDATION_EXPORT UIColor * UIColorDim(CGFloat White,CGFloat a);
FOUNDATION_EXPORT UIColor * UIColorRGBA(CGFloat r,CGFloat g,CGFloat b,CGFloat a);
FOUNDATION_EXPORT UIColor * UIColorRGB(CGFloat r,CGFloat g,CGFloat b);

FOUNDATION_EXPORT UIColor * UIColorHex(NSString *hex);

FOUNDATION_EXPORT UIColor * UIColorHexValueAlpha(NSInteger hex, CGFloat alpha);
FOUNDATION_EXPORT UIColor * UIColorHexValue(NSInteger hexValue);

FOUNDATION_EXPORT NSArray * RGBAFromColor(UIColor *color);
FOUNDATION_EXPORT BOOL isLightColor(UIColor *color);
//
+ (UIColor *)colorWithHexString:(NSString *)colorString;

@end

