//
//  WKWebView+Helper.m
//  NNCategory
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
            confi;
        });
    }
    return _confiDefault;
}

- (nullable WKNavigation *)loadHTMLStringWithMagic:(NSString *)content baseURL:(nullable NSURL *)baseURL{
    NSString *headerString = @"<header><meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no'></header>";
    return [self loadHTMLString: content baseURL: baseURL];
}

/**
 自定义方法
 */
- (void)addUserScript:(NSString *)source{
    NSParameterAssert(self.configuration.userContentController != nil);
    WKUserScript *userScript = [[WKUserScript alloc] initWithSource:source
                                                      injectionTime:WKUserScriptInjectionTimeAtDocumentStart
                                                   forMainFrameOnly:false];
    [self.configuration.userContentController addUserScript:userScript];
}

- (void)setCookieByJavaScript:(NSDictionary<NSString *, NSString *> *)dic handler:(void (^ _Nullable)(_Nullable id, NSError * _Nullable error))handler{
    NSMutableString *mstr = [NSMutableString string];
    [dic enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, NSString * _Nonnull obj, BOOL * _Nonnull stop) {
        [mstr appendFormat:@"%@=%@,", key, obj];
    }];
    NSString *js = [@"document.cookie = " stringByAppendingFormat:@"'%@'", mstr];
    [self evaluateJavaScript:js completionHandler:handler];
}

- (void)copyNSHTTPCookieStorageToWKHTTPCookieStoreWithHandler:(nullable void (^)())handler API_AVAILABLE(macos(10.13), ios(11.0)) {
    NSArray *cookies = NSHTTPCookieStorage.sharedHTTPCookieStorage.cookies;
    WKHTTPCookieStore *cookieStroe = self.configuration.websiteDataStore.httpCookieStore;
    if (cookies.count == 0) {
        !handler ?: handler();
        return;
    }
    for (NSHTTPCookie *cookie in cookies) {
        [cookieStroe setCookie:cookie completionHandler:^{
            if ([[cookies lastObject] isEqual:cookie]) {
                !handler ?: handler();
                return;
            }
        }];
    }
}

- (void)loadUrl:(NSString *)urlString additionalHttpHeaders:(NSDictionary<NSString *, NSString *> *)additionalHttpHeaders{
    //应用于 ajax 请求的 cookie 设置
    WKUserContentController *userContentController = WKUserContentController.new;
    NSString *cookieSource = [NSString stringWithFormat:@"document.cookie = 'user=%@';", @"userValue"];

    WKUserScript *cookieScript = [[WKUserScript alloc] initWithSource:cookieSource injectionTime:WKUserScriptInjectionTimeAtDocumentStart forMainFrameOnly:NO];
    [userContentController addUserScript:cookieScript];

    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    config.userContentController = userContentController;
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://momo.domain.com"]];
        
    // 应用于 request 的 cookie 设置
    NSDictionary *headFields = request.allHTTPHeaderFields;
    NSString *cookie = headFields[@"user"];
    if (!cookie) {
        [request addValue:[NSString stringWithFormat:@"user=%@", @"userValue"] forHTTPHeaderField:@"Cookie"];
    }
    [self loadRequest:request];
}


@end
