//
//  UIColor+Helper.m
//  
//
//  Created by BIN on 2018/9/11.
//  Copyright © 2018年 SHANG. All rights reserved.
//

#import "UIColor+Helper.h"

#import "BNGloble.h"
#import "UIApplication+Helper.h"

@implementation UIColor (Helper)

static UIColor * _themeColor = nil;
static UIColor * _backgroudColor = nil;
static UIColor * _lineColor = nil;
static UIColor * _btnColor_N = nil;
static UIColor * _btnColor_H = nil;
static UIColor * _btnColor_D = nil;
static UIColor * _excelColor = nil;
static UIColor * _titleColor = nil;
static UIColor * _titleSubColor = nil;

static UIColor * _titleColor3 = nil;
static UIColor * _titleColor6 = nil;
static UIColor * _titleColor9 = nil;

+ (void)setThemeColor:(UIColor *)themeColor{
    _themeColor = themeColor;
}

+ (UIColor *)themeColor{
    if (!_themeColor) {
        _themeColor = UIColorHexValue(0x0082e0);
    }
    return _themeColor;
}

+ (UIColor *)randomColor{
    CGFloat red = arc4random_uniform(256);
    CGFloat green = arc4random_uniform(256);
    CGFloat blue = arc4random_uniform(256);
    return [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1];
}

+ (UIColor *)backgroudColor{
    if (!_backgroudColor) {
        _backgroudColor = UIColorHexValue(0xE9E9E9);//233,233,233;
    }
    return _backgroudColor;
}

+ (UIColor *)lineColor{
    if (!_lineColor) {
        _lineColor = UIColorHexValue(0xe0e0e0);
    }
    return _lineColor;
}

+ (UIColor *)btnColor_N{
    if (!_btnColor_N) {
        _btnColor_N = UIColorHexValue(0xfea914);
    }
    return _btnColor_N;
}

+ (UIColor *)btnColor_H{
    if (!_btnColor_H) {
        _btnColor_H = UIColorHexValue(0xf1a013);
    }
    return _btnColor_H;
}

+ (UIColor *)btnColor_D{
    if (!_btnColor_D) {
        _btnColor_D = UIColorHexValue(0x999999);
    }
    return _btnColor_D;
}

+ (UIColor *)excelColor{
    if (!_excelColor) {
        _excelColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1];
    }
    return _excelColor;
}

+ (UIColor *)titleColor{
    if (!_titleColor) {
        _titleColor = UIColorHexValue(0x333333);
    }
    return _titleColor;
}

+ (UIColor *)titleSubColor{
    if (!_titleSubColor) {
        _titleSubColor = UIColorHexValue(0x999999);
    }
    return _titleSubColor;
}

+ (UIColor *)titleColor3{
    if (!_titleColor) {
        _titleColor = UIColorHexValue(0x333333);
    }
    return _titleColor;
}

+ (UIColor *)titleColor6{
    if (!_titleColor) {
        _titleColor = UIColorHexValue(0x666666);
    }
    return _titleColor;
}

+ (UIColor *)titleColor9{
    if (!_titleColor) {
        _titleColor = UIColorHexValue(0x999999);
    }
    return _titleColor;
}


UIColor * UIColorDim(CGFloat White,CGFloat a){
    return [UIColor colorWithWhite:White alpha:a];////white 0-1为黑到白,alpha透明度
    //    return [UIColor colorWithWhite:0.2f alpha: 0.5];////white 0-1为黑到白,alpha透明度
}
#pragma mark- -十六进制颜色
UIColor * UIColorRGBA(CGFloat r,CGFloat g,CGFloat b,CGFloat a){
    return [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a];
}

UIColor * UIColorRGB(CGFloat r,CGFloat g,CGFloat b){
    return UIColorRGBA(r, g, b, 1);
}

UIColor * UIColorHexValue(NSInteger hex){
    return UIColorHexValueAlpha(hex, 1.0);
}

/**
 [源]0x十六进制数值
 */
UIColor * UIColorHexValueAlpha(NSInteger hex, CGFloat alpha){
    return [UIColor colorWithRed:((hex & 0xFF0000) >> 16)/255.0 green:((hex & 0xFF00) >> 8)/255.0 blue:(hex & 0xFF)/255.0 alpha:alpha];
}

/**
 十六进制字符串
 */
UIColor * UIColorHex(NSString *hex){
    return [UIColor colorWithHexString:hex];
}


NSArray * RGBAFromColor(UIColor *color){
    CGFloat red = 0.0;
    CGFloat green = 0.0;
    CGFloat blue = 0.0;
    CGFloat alpha = 0.0;
    [color getRed:&red green:&green blue:&blue alpha:&alpha];
    return @[@(red), @(green), @(blue), @(alpha)];
}

/**
 判断颜色是不是亮色
 */
BOOL isLightColor(UIColor *color){
    NSArray *components = RGBAFromColor(color);
    //    NSLog(@"%f %f %f", components[0], components[1], components[2]);
    CGFloat sum = [[components valueForKeyPath:kArr_sum_float] floatValue];
    bool isLight = sum < 382 ? false : true;
    return isLight;
}

+ (UIColor *)colorWithHexString:(NSString *)colorString{
    NSString *cString = [[colorString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if (cString.length < 6) {
        return UIColor.clearColor;
    }
    // 判断前缀
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return UIColor.clearColor;
    // 从六位数值中找到RGB对应的位数并转换
    NSRange range;
    range.location = 0;
    range.length = 2;
    //R、G、B
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r /255.0f) green:((float) g /255.0f) blue:((float) b /255.0f) alpha:1.0f];
}


@end

