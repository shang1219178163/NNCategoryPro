//
//  WKWebView+Helper.m
//  BN_Category
//
//  Created by hsf on 2018/11/1.
//

#import "WKWebView+Helper.h"

@implementation WKWebView (Helper)

- (NSString *)changTextFontRatio:(CGFloat)fontRatio{
    
    NSString * textSize = [NSString stringWithFormat:@"%@%@",@(fontRatio),@"%"];;
    NSString * str = [NSString stringWithFormat:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '%@'",textSize];
    return str;
}

@end
