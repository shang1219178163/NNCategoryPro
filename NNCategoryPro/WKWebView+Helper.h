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

@end

NS_ASSUME_NONNULL_END
