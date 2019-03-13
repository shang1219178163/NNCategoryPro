//
//  WKWebView+Helper.m
//  BNCategory
//
//  Created by BIN on 2018/11/1.
//

#import "WKWebView+Helper.h"

@implementation WKWebView (Helper)

static WKWebViewConfiguration *_confiDefault = nil;

+ (void)setConfiDefault:(WKWebViewConfiguration *)confiDefault{
    _confiDefault = confiDefault;
}

+(WKWebViewConfiguration *)confiDefault{
    if (!_confiDefault) {
        _confiDefault = ({
            // 设置WKWebView基本配置信息
            WKWebViewConfiguration *confi = [[WKWebViewConfiguration alloc] init];
            confi.allowsInlineMediaPlayback = true;
            confi.selectionGranularity = WKSelectionGranularityDynamic;
            confi.preferences = [[WKPreferences alloc] init];
            confi.preferences.javaScriptCanOpenWindowsAutomatically = false;
            confi.preferences.javaScriptEnabled = true;
            confi.preferences.minimumFontSize = 17;
            confi;
        });
    }
    return _confiDefault;
}

+ (NSString *)changTextFontRatio:(CGFloat)fontRatio{
    NSString * textSize = [NSString stringWithFormat:@"%@%@",@(fontRatio),@"%"];;
    NSString * str = [NSString stringWithFormat:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '%@'",textSize];
    return str;
}

/**
 自定义方法
 */
- (void)addUserScript:(NSString *)source{
    NSParameterAssert(self.configuration.userContentController != nil);
    WKUserScript *userScript = [[WKUserScript alloc] initWithSource:source injectionTime:WKUserScriptInjectionTimeAtDocumentStart forMainFrameOnly:false];
    [self.configuration.userContentController addUserScript:userScript];

}


@end
