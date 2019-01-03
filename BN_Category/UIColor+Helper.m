//
//  UIColor+Helper.m
//  
//
//  Created by BIN on 2018/9/11.
//  Copyright © 2018年 SHANG. All rights reserved.
//

#import "UIColor+Helper.h"

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

+ (void)setThemeColor:(UIColor *)themeColor{
    _themeColor = themeColor;
}

+ (UIColor *)themeColor{
    if (!_themeColor) {
//        _themeColor = [UIColor colorWithHexString:@"#0082e0"];
        _themeColor = UIColor.orangeColor;
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
        _backgroudColor = [UIColor colorWithHexString:@"#E9E9E9"];//233,233,233;
    }
    return _backgroudColor;
}

+ (UIColor *)lineColor{
    if (!_lineColor) {
        _lineColor = [UIColor colorWithHexString:@"#e0e0e0"];
    }
    return _lineColor;
}

+ (UIColor *)btnColor_N{
    if (!_btnColor_N) {
        _btnColor_N = [UIColor colorWithHexString:@"#fea914"];
    }
    return _btnColor_N;
}

+ (UIColor *)btnColor_H{
    if (!_btnColor_H) {
        _btnColor_H = [UIColor colorWithHexString:@"#f1a013"];
    }
    return _btnColor_H;
}

+ (UIColor *)btnColor_D{
    if (!_btnColor_D) {
        _btnColor_D = [UIColor colorWithHexString:@"#999999"];
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
        _titleColor = UIColorHex(@"#333333");
    }
    return _titleColor;
}

+ (UIColor *)titleSubColor{
    if (!_titleSubColor) {
        _titleSubColor = UIColorHex(@"#999999");
    }
    return _titleSubColor;
}

+ (UIColor *)colorWithHexString:(NSString *)colorString{
    NSString *cString = [[colorString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
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
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}


@end

