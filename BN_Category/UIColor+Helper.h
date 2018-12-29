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

/**
 十六进制颜色
 */
UIColor * UIColorHex(NSString *hex);

UIColor * UIColorHexInter(NSInteger hex);
    
+ (UIColor *)colorWithHexString:(NSString *)colorString;

NSArray * RGBAFromColor(UIColor *color);

+ (BOOL)isLightColor:(UIColor*)color;

@end

