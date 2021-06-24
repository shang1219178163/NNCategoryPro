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

///字体自适应
- (nullable WKNavigation *)loadHTMLStringWithMagic:(NSString *)content baseURL:(nullable NSURL *)baseURL;

/// JS注入
- (void)addUserScript:(NSString *)source;
///设置 Cookie 参数
- (void)setCookieByJavaScript:(NSDictionary<NSString *, NSString *> *)dic handler:(void (^ _Nullable)(_Nullable id, NSError * _Nullable error))handler;
///添加 cookie的自动推送
- (void)copyNSHTTPCookieStorageToWKHTTPCookieStoreWithHandler:(nullable void (^)())handler API_AVAILABLE(macos(10.13), ios(11.0));

/// 此方法解决了: Web 页面包含了 ajax 请求的话，cookie 要重新在 WKWebView 的 WKWebViewConfiguration 中进行配置的问题
- (void)loadUrl:(NSString *)urlString additionalHttpHeaders:(NSDictionary<NSString *, NSString *> *)additionalHttpHeaders;

@end

NS_ASSUME_NONNULL_END
