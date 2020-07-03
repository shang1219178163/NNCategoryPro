//
//  UIColor+Helper.m
//  
//
//  Created by BIN on 2018/9/11.
//  Copyright © 2018年 SHANG. All rights reserved.
//

#import "UIColor+Helper.h"

#import <NNGloble/NNGloble.h>
#import "UIApplication+Helper.h"

@implementation UIColor (Helper)

static UIColor * _themeColor = nil;

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
    return UIColorHexValue(0xE9E9E9);//233,233,233;
}

+ (UIColor *)lineColor{
    return UIColorHexValue(0xe4e4e4);
}

+ (UIColor *)btnColor_N{
    return UIColorHexValue(0xfea914);
}

+ (UIColor *)btnColor_H{
    return UIColorHexValue(0xf1a013);
}

+ (UIColor *)btnColor_D{
    return UIColorHexValue(0x999999);
}

+ (UIColor *)excelColor{
    return [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1];
}

+ (UIColor *)titleColor{
    return UIColorHexValue(0x333333);
}

+ (UIColor *)titleSubColor{
    return UIColorHexValue(0x999999);
}

+ (UIColor *)lightBlue{
    return UIColorHexValue(0x29B5FE);
}

+ (UIColor *)lightOrange{
    return UIColorHexValue(0xFFBB50);
}

+ (UIColor *)lightGreen{
    return UIColorHexValue(0x1AC756);
}

+ (UIColor *)titleColor3{
    return UIColorHexValue(0x333333);
}

+ (UIColor *)titleColor6{
    return UIColorHexValue(0x666666);
}

+ (UIColor *)titleColor9{
    return UIColorHexValue(0x999999);
}


UIColor * UIColorDim(CGFloat White,CGFloat a){
    return [UIColor colorWithWhite:White alpha:a];////white 0-1为黑到白,alpha透明度
//    return [UIColor colorWithWhite:0.2f alpha: 0.5];////white 0-1为黑到白,alpha透明度
}
#pragma mark- -十六进制颜色
UIColor * UIColorRGBA(CGFloat r, CGFloat g, CGFloat b, CGFloat a){
    return [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a];
}

UIColor * UIColorRGB(CGFloat r, CGFloat g, CGFloat b){
    return UIColorRGBA(r, g, b, 1);
}

UIColor * UIColorHexValue(NSInteger hex){
    return UIColorHexValueAlpha(hex, 1.0);
}

UIColor * UIColorHexValueAlpha(NSInteger hex, CGFloat alpha){
    return [UIColor colorWithRed:((hex & 0xFF0000) >> 16)/255.0
                           green:((hex & 0xFF00) >> 8)/255.0
                            blue:(hex & 0xFF)/255.0
                           alpha:alpha];
}

UIColor * UIColorHexAlpha(NSString *hex, CGFloat alpha){
    return [UIColor colorWithHexString:hex alpha:alpha];
}

UIColor * UIColorHex(NSString *hex){
    return [UIColor colorWithHexString:hex alpha:1.0];
}

NSArray * RGBAFromColor(UIColor *color){
    CGFloat red = 0.0;
    CGFloat green = 0.0;
    CGFloat blue = 0.0;
    CGFloat alpha = 0.0;
    [color getRed:&red green:&green blue:&blue alpha:&alpha];
//    const CGFloat *components = CGColorGetComponents(color.CGColor);
    return @[@(red), @(green), @(blue), @(alpha)];
}

/**
 判断颜色是不是亮色
 */
BOOL isLightColor(UIColor *color){
    NSArray *components = RGBAFromColor(color);
//    NSLog(@"%f %f %f", components[0], components[1], components[2]);
    CGFloat sum = [[components valueForKeyPath:kArrSumFloat] floatValue];
    bool isLight = sum < 382 ? false : true;
    return isLight;
}

+ (UIColor *)colorWithHexString:(NSString *)colorStr{
    return [UIColor colorWithHexString:colorStr alpha:1.0];
}

+ (UIColor *)colorWithHexString:(NSString *)colorStr alpha:(CGFloat)alpha{
    NSString *cString = [[colorStr stringByTrimmingCharactersInSet: NSCharacterSet.whitespaceAndNewlineCharacterSet] uppercaseString];
    
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
    
    return [UIColor colorWithRed:((float) r /255.0f)
                           green:((float) g /255.0f)
                            blue:((float) b /255.0f)
                           alpha:alpha];
}


@end

