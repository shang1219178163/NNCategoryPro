//
//  NSAttributedString+Helper.h
//  MacTemplet
//
//  Created by Bin Shang on 2019/6/27.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

//推荐使用 NSMutableAttributedString+Chain.h 链式编程

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSAttributedString (Helper)

- (CGSize)sizeWithWidth:(CGFloat)width;

/**
 富文本特殊部分设置
 */
+ (NSDictionary *)attrDictWithFont:(CGFloat)font textColor:(UIColor *)textColor;

/**
 富文本整体设置
 */
+ (NSDictionary *)paraDictWithFont:(CGFloat)font textColor:(UIColor *)textColor alignment:(NSTextAlignment)alignment;

/**
 [源]富文本
 @param text 源字符串
 @param textTaps 特殊部分数组(每一部分都必须包含在text中)
 @param font 一般字体大小(传NSNumber或者UIFont)
 @param tapColor 特殊部分颜色
 @return 富文本字符串
 */
+ (NSAttributedString *)getAttString:(NSString *)text
                            textTaps:(NSArray<NSString *> *_Nullable)textTaps
                                font:(CGFloat)font
                               color:(UIColor *)color
                            tapColor:(UIColor *)tapColor
                           alignment:(NSTextAlignment)alignment;

/**
 富文本段落
 */
+ (NSAttributedString *)getAttString:(NSString *)string
                            textTaps:(NSArray<NSString *> *_Nullable)textTaps
                               color:(UIColor *)color
                            tapColor:(UIColor *)tapColor;

/**
 富文本产生
 */
+ (NSMutableAttributedString *)getAttString:(NSString *)string textTaps:(NSArray<NSString *> *)textTaps;

/**
 (推荐)单个标题前加*
 */
+ (NSAttributedString *)getAttringByPrefix:(NSString *)prefix content:(NSString *)content isMust:(BOOL)isMust color:(UIColor *)color;


+ (NSAttributedString *)hyperlinkFromString:(NSString *)string withURL:(NSURL *)aURL font:(UIFont *)font;

@end


@interface NSMutableAttributedString (Chain)

// addAttrs
@property(nonatomic, strong, readonly) NSMutableAttributedString *(^addAttrs)(NSDictionary<NSAttributedStringKey, id> *);

// ParagraphStyle
@property(nonatomic, strong, readonly) NSMutableAttributedString *(^paragraphStyle)(NSParagraphStyle *);

// Font
@property(nonatomic, strong, readonly) NSMutableAttributedString *(^font)(UIFont *);

@property(nonatomic, strong, readonly) NSMutableAttributedString *(^fontSize)(CGFloat);

// ForegroundColor
@property(nonatomic, strong, readonly) NSMutableAttributedString *(^color)(UIColor *);

// BackgroundColor
@property(nonatomic, strong, readonly) NSMutableAttributedString *(^bgColor)(UIColor *);

// Link
@property(nonatomic, strong, readonly) NSMutableAttributedString *(^link)(NSString *);

// Link
@property(nonatomic, strong, readonly) NSMutableAttributedString *(^linkURL)(NSURL *);

// Obliqueness
@property(nonatomic, strong, readonly) NSMutableAttributedString *(^oblique)(CGFloat);

// Kern
@property(nonatomic, strong, readonly) NSMutableAttributedString *(^kern)(CGFloat);

// Expansion
@property(nonatomic, strong, readonly) NSMutableAttributedString *(^expansion)(CGFloat);

// Ligature
@property(nonatomic, strong, readonly) NSMutableAttributedString *(^ligature)(NSUInteger);

// UnderlineStyle
@property(nonatomic, strong, readonly) NSMutableAttributedString *(^underline)(NSUnderlineStyle, UIColor *);

// StrikethroughStyle(负值填充效果，正值中空效果)
@property(nonatomic, strong, readonly) NSMutableAttributedString *(^strikethrough)(NSUnderlineStyle, UIColor *);

// Stroke
@property(nonatomic, strong, readonly) NSMutableAttributedString *(^stroke)(UIColor *, CGFloat);

// StrokeWidth
@property(nonatomic, strong, readonly) NSMutableAttributedString *(^baselineOffset)(CGFloat);

// Shadow
@property(nonatomic, strong, readonly) NSMutableAttributedString *(^shadow)(NSShadow *);

// TextEffect
@property(nonatomic, strong, readonly) NSMutableAttributedString *(^textEffect)(NSString *);

// Attachment
@property(nonatomic, strong, readonly) NSMutableAttributedString *(^attachment)(NSTextAttachment *);


@end


@interface NSString (Chain)

@property(nonatomic, strong, readonly) NSMutableAttributedString *matt;

@end


@interface NSAttributedString (Chain)

@property(nonatomic, strong, readonly) NSMutableAttributedString *matt;

@end



@interface NSMutableParagraphStyle (Chain)

@property(nonatomic, copy, readonly) NSMutableParagraphStyle *(^lineSpacingChain)(CGFloat);

@property(nonatomic, copy, readonly) NSMutableParagraphStyle *(^paragraphSpacingChain)(CGFloat);

@property(nonatomic, copy, readonly) NSMutableParagraphStyle *(^alignmentChain)(NSTextAlignment);

@property(nonatomic, copy, readonly) NSMutableParagraphStyle *(^firstLineHeadIndentChain)(CGFloat);

@property(nonatomic, copy, readonly) NSMutableParagraphStyle *(^headIndentChain)(CGFloat);

@property(nonatomic, copy, readonly) NSMutableParagraphStyle *(^tailIndentChain)(CGFloat);

@property(nonatomic, copy, readonly) NSMutableParagraphStyle *(^lineBreakModeChain)(NSLineBreakMode);

@property(nonatomic, copy, readonly) NSMutableParagraphStyle *(^minimumLineHeightChain)(CGFloat);

@property(nonatomic, copy, readonly) NSMutableParagraphStyle *(^maximumLineHeightChain)(CGFloat);

@property(nonatomic, copy, readonly) NSMutableParagraphStyle *(^baseWritingDirectionChain)(NSWritingDirection);

@property(nonatomic, copy, readonly) NSMutableParagraphStyle *(^lineHeightMultipleChain)(CGFloat);

@property(nonatomic, copy, readonly) NSMutableParagraphStyle *(^paragraphSpacingBeforeChain)(CGFloat);

@property(nonatomic, copy, readonly) NSMutableParagraphStyle *(^hyphenationFactorChain)(float);

@property(nonatomic, copy, readonly) NSMutableParagraphStyle *(^tabStopsChain)(NSArray<NSTextTab *> *) API_AVAILABLE(macos(10.0), ios(7.0));
@property(nonatomic, copy, readonly) NSMutableParagraphStyle *(^defaultTabIntervalChain)(CGFloat) API_AVAILABLE(macos(10.0), ios(7.0));
@property(nonatomic, copy, readonly) NSMutableParagraphStyle *(^allowsDefaultTighteningForTruncationChain)(BOOL) API_AVAILABLE(macos(10.11), ios(9.0));
@property(nonatomic, copy, readonly) NSMutableParagraphStyle *(^lineBreakStrategyChain)(NSLineBreakStrategy) API_AVAILABLE(macos(10.11), ios(9.0));


@end

NS_ASSUME_NONNULL_END
