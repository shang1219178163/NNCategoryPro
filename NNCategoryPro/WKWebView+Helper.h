//
//  WKWebView+Helper.h
//  NNCategory
//
//  Created by BIN on 2018/11/1.
//

#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WKWebView (Helper)

@property (class, nonatomic) WKWebViewConfiguration *confiDefault;

+ (NSString *)changTextFontRatio:(CGFloat)fontRatio;

- (void)addUserScript:(NSString *)source;

/// 此方法解决了: Web 页面包含了 ajax 请求的话，cookie 要重新在 WKWebView 的 WKWebViewConfiguration 中进行配置的问题
- (void)loadUrl:(NSString *)urlString additionalHttpHeaders:(NSDictionary<NSString *, NSString *> *)additionalHttpHeaders;

@end

NS_ASSUME_NONNULL_END
