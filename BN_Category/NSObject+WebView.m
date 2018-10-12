//
//  NSObject+WebView.m
//  HuiZhuBang
//
//  Created by BIN on 2018/1/2.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//

#import "NSObject+WebView.h"

@implementation NSObject (WebView)

- (NSString *)changWebViewTextFontRatio:(CGFloat)fontRatio{
    
    NSString * textSize = [NSString stringWithFormat:@"%@%@",@(fontRatio),@"%"];;
    NSString * str = [NSString stringWithFormat:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '%@'",textSize];
    return str;
}

@end

