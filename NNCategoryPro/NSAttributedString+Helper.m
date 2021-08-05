
//
//  NSAttributedString+Helper.m
//  MacTemplet
//
//  Created by Bin Shang on 2019/6/27.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

#import "NSAttributedString+Helper.h"

@implementation NSAttributedString (Helper)

- (CGSize)sizeWithWidth:(CGFloat)width{
    CGSize size = [self boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX)
                                     options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                     context:nil
                   ].size;
    CGSize result = CGSizeMake(ceil(size.width), ceil(size.height));
    return result;
}

/**
 富文本整体设置
 */
+ (NSDictionary *)paraDictWithFont:(UIFont *)font textColor:(UIColor *)textColor alignment:(NSTextAlignment)alignment{
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paraStyle.alignment = alignment;
    //    paraStyle.lineSpacing = 5;//行间距
    
    return @{NSFontAttributeName: font,
             NSForegroundColorAttributeName: textColor,
             NSBackgroundColorAttributeName: UIColor.clearColor,
             NSParagraphStyleAttributeName: paraStyle,
    };
}


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
                                Font:(UIFont *)font
                               color:(UIColor *)color
                            tapColor:(UIColor *)tapColor
                           alignment:(NSTextAlignment)alignment{

    // 设置段落
    NSDictionary *paraDict = [NSAttributedString paraDictWithFont:font textColor:color alignment:alignment];
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:text attributes:paraDict];

    for (NSString *textTap in textTaps){
        NSRange range = [text rangeOfString:textTap];
        // 创建文字属性
        [attString addAttributes:@{
            NSForegroundColorAttributeName: color,
            NSFontAttributeName: font,
            
        } range:range];
    }
    return attString;
}

+ (NSAttributedString *)getAttString:(NSString *)string
                            textTaps:(NSArray<NSString *> *_Nullable)textTaps
                               color:(UIColor *)color
                            tapColor:(UIColor *)tapColor{
    return [NSAttributedString getAttString:string
                                   textTaps:textTaps
                                       font:[UIFont systemFontOfSize:16]
                                      color: color
                                   tapColor:tapColor
                                  alignment: NSTextAlignmentLeft];
}


/**
 富文本产生
 */
+ (NSMutableAttributedString *)getAttString:(NSString *)string textTaps:(NSArray<NSString *> *)textTaps{
    NSMutableAttributedString *matt = [[NSMutableAttributedString alloc]initWithString:string];
    [matt addAttributes:@{ NSFontAttributeName: [UIFont systemFontOfSize:16] }
                  range:NSMakeRange(0, string.length)];
    
    for (NSInteger i = 0; i < textTaps.count; i++){
        [matt addAttributes:@{
            NSForegroundColorAttributeName: UIColor.orangeColor,
            NSFontAttributeName: [UIFont systemFontOfSize:16],
            
        } range:[string rangeOfString:textTaps[i]]];
    }
    return matt;
}


///**
// (推荐)单个标题前加*
// */
//+ (NSAttributedString *)getAttringByPrefix:(NSString *)prefix content:(NSString *)content isMust:(BOOL)isMust color:(UIColor *)color{
//    
//    if (![content hasPrefix:prefix]) content = [prefix stringByAppendingString:content];
//    
//    UIColor *colorMust = isMust ? UIColor.redColor : UIColor.clearColor;
//    
//    NSArray *textTaps = @[prefix];
//    NSAttributedString *attString = [NSAttributedString getAttString:content
//                                                            textTaps:textTaps
//                                                                font:[UIFont systemFontOfSize:15]
//                                                               color:color
//                                                            tapColor:colorMust
//                                                           alignment:NSTextAlignmentCenter];
//
//    return attString;
//}

+ (NSAttributedString *)hyperlinkFromString:(NSString *)string withURL:(NSURL *)aURL font:(UIFont *)font{
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString: string];
    
    NSRange range = NSMakeRange(0, attrString.length);
    
//    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc]init];
    NSDictionary *dic = @{NSFontAttributeName: font,
                          NSForegroundColorAttributeName: UIColor.blueColor,
                          NSLinkAttributeName: aURL.absoluteString,
                          NSUnderlineStyleAttributeName: @(NSUnderlineStyleSingle),
//                          NSParagraphStyleAttributeName: paraStyle,
//                          NSBaselineOffsetAttributeName: @15,
                          };
    
    [attrString beginEditing];
    [attrString addAttributes:dic range:range];
    [attrString endEditing];
    return attrString;
}


@end


@implementation NSMutableAttributedString (Chain)

- (NSMutableAttributedString *(^)(NSDictionary<NSAttributedStringKey, id> *))addAttrs{
    return ^(NSDictionary<NSAttributedStringKey, id> * dic){
        [self addAttributes:dic range:NSMakeRange(0, self.length)];
        return self;
    };
}

- (NSMutableAttributedString *(^)(NSParagraphStyle *))paragraphStyle{
    return ^(NSParagraphStyle *style){
        [self addAttributes:@{NSParagraphStyleAttributeName: style} range:NSMakeRange(0, self.length)];
        return self;
    };
}

- (NSMutableAttributedString *(^)(UIFont *))font{
    return ^(UIFont *font){
        [self addAttributes:@{NSFontAttributeName: font} range:NSMakeRange(0, self.length)];
        return self;
    };
}

- (NSMutableAttributedString *(^)(CGFloat))fontSize{
    return ^(CGFloat fontSize){
        [self addAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:fontSize]} range:NSMakeRange(0, self.length)];
        return self;
    };
}

- (NSMutableAttributedString *(^)(UIColor *))color{
    return ^(UIColor *color){
        [self addAttributes:@{NSForegroundColorAttributeName: color} range:NSMakeRange(0, self.length)];
        return self;
    };
}

- (NSMutableAttributedString *(^)(UIColor *))bgColor{
    return ^(UIColor *color){
        [self addAttributes:@{NSBackgroundColorAttributeName: color} range:NSMakeRange(0, self.length)];
        return self;
    };
}

- (NSMutableAttributedString *(^)(NSString *))link{
    return ^(NSString *link){
        [self addAttributes:@{NSLinkAttributeName: link} range:NSMakeRange(0, self.length)];
        return self;
    };
}

- (NSMutableAttributedString *(^)(NSURL *))linkURL{
    return ^(NSURL *link){
        [self addAttributes:@{NSLinkAttributeName: link} range:NSMakeRange(0, self.length)];
        return self;
    };
}

- (NSMutableAttributedString *(^)(CGFloat))oblique{
    return ^(CGFloat value){
        [self addAttributes:@{NSObliquenessAttributeName: @(value)} range:NSMakeRange(0, self.length)];
        return self;
    };
}

- (NSMutableAttributedString *(^)(CGFloat))kern{
    return ^(CGFloat kern){
        [self addAttributes:@{NSKernAttributeName: @(kern)} range:NSMakeRange(0, self.length)];
        return self;
    };
}

- (NSMutableAttributedString *(^)(CGFloat))expansion{
    return ^(CGFloat value){
        [self addAttributes:@{NSExpansionAttributeName: @(value)} range:NSMakeRange(0, self.length)];
        return self;
    };
}

- (NSMutableAttributedString *(^)(NSUInteger))ligature{
    return ^(NSUInteger ligature){
        [self addAttributes:@{NSLigatureAttributeName: @(ligature)} range:NSMakeRange(0, self.length)];
        return self;
    };
}

- (NSMutableAttributedString *(^)(NSUnderlineStyle, UIColor *))underline{
    return ^(NSUnderlineStyle underline, UIColor *color){
        [self addAttributes:@{NSUnderlineStyleAttributeName: @(underline)} range:NSMakeRange(0, self.length)];
        [self addAttributes:@{NSUnderlineColorAttributeName: color} range:NSMakeRange(0, self.length)];
        return self;
    };
}

- (NSMutableAttributedString *(^)(NSUnderlineStyle, UIColor *))strikethrough{
    return ^(NSUnderlineStyle underline, UIColor *color){
        [self addAttributes:@{NSStrikethroughStyleAttributeName: @(underline)} range:NSMakeRange(0, self.length)];
        [self addAttributes:@{NSStrikethroughColorAttributeName: color} range:NSMakeRange(0, self.length)];
        return self;
    };
}

- (NSMutableAttributedString *(^)(UIColor *, CGFloat))stroke{
    return ^(UIColor *color, CGFloat value){
        [self addAttributes:@{NSStrokeColorAttributeName: color} range:NSMakeRange(0, self.length)];
        [self addAttributes:@{NSStrokeWidthAttributeName: @(value)} range:NSMakeRange(0, self.length)];
        return self;
    };
}

- (NSMutableAttributedString *(^)(NSShadow *))shadow{
    return ^(NSShadow *shadow){
        [self addAttributes:@{NSShadowAttributeName: shadow} range:NSMakeRange(0, self.length)];
        return self;
    };
}

- (NSMutableAttributedString *(^)(NSString *))textEffect{
    return ^(NSString *textEffect){
        [self addAttributes:@{NSTextEffectAttributeName: textEffect} range:NSMakeRange(0, self.length)];
        return self;
    };
}

- (NSMutableAttributedString *(^)(NSTextAttachment *))attachment{
    return ^(NSTextAttachment *attachment){
        [self addAttributes:@{NSAttachmentAttributeName: attachment} range:NSMakeRange(0, self.length)];
        return self;
    };
}

- (NSMutableAttributedString *(^)(CGFloat))baselineOffset{
    return ^(CGFloat value){
        [self addAttributes:@{NSBaselineOffsetAttributeName: @(value)} range:NSMakeRange(0, self.length)];
        return self;
    };
}

- (NSMutableAttributedString *)appendPrefix:(NSString *)prefix color:(UIColor *)color font:(UIFont *)font{
    NSDictionary *attributes = @{
        NSForegroundColorAttributeName: color,
        NSFontAttributeName: font};
    
    NSRange range = [self.string rangeOfString:prefix];
    if (range.location == NSNotFound) {
        NSMutableAttributedString *matt = [[NSMutableAttributedString alloc]initWithString:prefix
                                                                                attributes:attributes];
        [self insertAttributedString:matt atIndex:0];
        return self;
    }
    [self addAttributes:attributes range:range];
    return self;
}

- (NSMutableAttributedString *)appendSuffix:(NSString *)suffix color:(UIColor *)color font:(UIFont *)font{
    NSDictionary *attributes = @{
        NSForegroundColorAttributeName: color,
        NSFontAttributeName: font};
    
    NSRange range = [self.string rangeOfString:suffix options:NSBackwardsSearch];
    if (range.location == NSNotFound) {
        NSMutableAttributedString *matt = [[NSMutableAttributedString alloc]initWithString:suffix
                                                                                attributes:attributes];
        [self appendAttributedString:matt];
        return self;
    }
    [self addAttributes:attributes range:range];
    return self;
}

@end


@implementation NSString (Chain)

- (NSMutableAttributedString *)matt{
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:self];
    return attrString;
}

@end


@implementation NSAttributedString (Chain)

- (NSMutableAttributedString *)matt{
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithAttributedString:self];
    return attrString;
}

@end


@implementation NSMutableParagraphStyle (Chain)

- (NSMutableParagraphStyle * (^)(CGFloat))lineSpacingChain{
    return ^(CGFloat value){
        self.lineSpacing = value;
        return self;
    };
}

- (NSMutableParagraphStyle * (^)(CGFloat))paragraphSpacingChain{
    return ^(CGFloat value){
        self.paragraphSpacing = value;
        return self;
    };
}

- (NSMutableParagraphStyle * (^)(NSTextAlignment))alignmentChain{
    return ^(NSTextAlignment value){
        self.alignment = value;
        return self;
    };
}

- (NSMutableParagraphStyle * (^)(CGFloat))firstLineHeadIndentChain{
    return ^(CGFloat value){
        self.firstLineHeadIndent = value;
        return self;
    };
}

- (NSMutableParagraphStyle * (^)(CGFloat))headIndentChain{
    return ^(CGFloat value){
        self.headIndent = value;
        return self;
    };
}

- (NSMutableParagraphStyle * (^)(CGFloat))tailIndentChain{
    return ^(CGFloat value){
        self.tailIndent = value;
        return self;
    };
}

- (NSMutableParagraphStyle * (^)(NSLineBreakMode))lineBreakModeChain{
    return ^(NSLineBreakMode value){
        self.lineBreakMode = value;
        return self;
    };
}

- (NSMutableParagraphStyle * (^)(CGFloat))minimumLineHeightChain{
    return ^(CGFloat value){
        self.minimumLineHeight = value;
        return self;
    };
}

- (NSMutableParagraphStyle * (^)(CGFloat))maximumLineHeightChain{
    return ^(CGFloat value){
        self.maximumLineHeight = value;
        return self;
    };
}

- (NSMutableParagraphStyle * (^)(NSWritingDirection))baseWritingDirectionChain{
    return ^(NSWritingDirection value){
        self.baseWritingDirection = value;
        return self;
    };
}

- (NSMutableParagraphStyle * (^)(CGFloat))lineHeightMultipleChain{
    return ^(CGFloat value){
        self.lineHeightMultiple = value;
        return self;
    };
}

- (NSMutableParagraphStyle * (^)(CGFloat))paragraphSpacingBeforeChain{
    return ^(CGFloat value){
        self.paragraphSpacingBefore = value;
        return self;
    };
}

- (NSMutableParagraphStyle * (^)(float))hyphenationFactorChain{
    return ^(float value){
        self.hyphenationFactor = value;
        return self;
    };
}

- (NSMutableParagraphStyle * (^)(NSArray<NSTextTab *> *))tabStopsChain{
    return ^(NSArray<NSTextTab *> * value){
        self.tabStops = value;
        return self;
    };
}

- (NSMutableParagraphStyle * (^)(CGFloat))defaultTabIntervalChain{
    return ^(CGFloat value){
        self.defaultTabInterval = value;
        return self;
    };
}

- (NSMutableParagraphStyle * (^)(BOOL))allowsDefaultTighteningForTruncationChain{
    return ^(BOOL value){
        self.allowsDefaultTighteningForTruncation = value;
        return self;
    };
}

- (NSMutableParagraphStyle * (^)(NSLineBreakStrategy))lineBreakStrategyChain{
    return ^(NSLineBreakStrategy value){
        self.lineBreakStrategy = value;
        return self;
    };
}



@end
