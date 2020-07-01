
//
//  NSAttributedString+Helper.m
//  MacTemplet
//
//  Created by Bin Shang on 2019/6/27.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

#import "NSAttributedString+Helper.h"

@implementation NSAttributedString (Helper)

-(BOOL)isValid{
    NSString *tmp = self;
    tmp = [tmp stringByReplacingOccurrencesOfString:@" " withString:@""];
            
    NSArray *array = @[@"",@"nil",@"null"];
    if ([array containsObject:tmp] || [tmp containsString:@"null"]) {
//         NSLog(@"无效字符->(%@)",string);
        return false;
    }
    return true;
}

#pragma mark- - 富文本
/**
 富文本特殊部分设置
 */
+ (NSDictionary *)attrDictWithFont:(CGFloat)font textColor:(UIColor *)textColor{
    // 创建文字属性
    NSDictionary * dict = @{NSFontAttributeName:            [UIFont fontWithName:@"PingFangSC-Light" size:font],
                            NSForegroundColorAttributeName: textColor,
                            NSBackgroundColorAttributeName: UIColor.clearColor
                            };
    return dict;
}

/**
 富文本整体设置
 */
+ (NSDictionary *)paraDictWithFont:(CGFloat)font textColor:(UIColor *)textColor alignment:(NSTextAlignment)alignment{
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paraStyle.alignment = alignment;
    //    paraStyle.lineSpacing = 5;//行间距
    
    NSMutableDictionary * mdict = [NSMutableDictionary dictionaryWithDictionary:[NSAttributedString attrDictWithFont:font textColor:textColor]];
    [mdict setObject:paraStyle forKey:NSParagraphStyleAttributeName];
    return mdict;
}

/**
 [源]富文本
 
 @param text 源字符串
 @param textTaps 特殊部分数组(每一部分都必须包含在text中)
 @param font 一般字体大小(传NSNumber或者UIFont)
 @param tapFont 特殊部分子体大小(传NSNumber或者UIFont)
 @param tapColor 特殊部分颜色
 @return 富文本字符串
 */
+ (NSAttributedString *)getAttString:(NSString *)text
                            textTaps:(NSArray<NSString *> *_Nullable)textTaps
                                font:(CGFloat)font
                             tapFont:(CGFloat)tapFont
                               color:(UIColor *)color
                            tapColor:(UIColor *)tapColor
                           alignment:(NSTextAlignment)alignment{
    
    // 设置段落
    NSDictionary *paraDict = [NSAttributedString paraDictWithFont:font textColor:color alignment:alignment];
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:text attributes:paraDict];
    
    for (NSString *textTap in textTaps) {
//        NSAssert([text containsString:textTap],@"textTaps中有不被字符串包含的元素");
        
        NSRange range = [text rangeOfString:textTap];
        // 创建文字属性
        NSDictionary *attrDict = [NSAttributedString attrDictWithFont:tapFont textColor:tapColor];
        [attString addAttributes:attrDict range:range];
        
    }
    return (NSAttributedString *)attString;
}

+ (NSAttributedString *)getAttString:(NSString *)string
                            textTaps:(NSArray<NSString *> *)textTaps
                            tapColor:(UIColor *)tapColor
                           alignment:(NSTextAlignment)alignment{
    NSAttributedString *attString = [NSAttributedString getAttString:string
                                                            textTaps:textTaps
                                                                font:16
                                                             tapFont:16
                                                               color:UIColor.blackColor
                                                            tapColor:tapColor
                                                           alignment:alignment];
    return attString;
}

/**
 富文本段落设置(无特殊文本)
 */
+ (NSAttributedString *)getAttString:(NSString *)string
                                font:(CGFloat)font
                               color:(UIColor *)color
                           alignment:(NSTextAlignment)alignment{
    NSAttributedString *attString = [NSAttributedString getAttString:string
                                                            textTaps:nil
                                                                font:font
                                                             tapFont:font
                                                               color:color
                                                            tapColor:color
                                                           alignment:alignment];
    return attString;
}

/**
 富文本产生
 */
+ (NSMutableAttributedString *)getAttString:(NSString *)string textTaps:(NSArray<NSString *> *)textTaps{
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc]initWithString:string];
    [attString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:NSMakeRange(0, string.length)];
    
    for (NSInteger i = 0; i < textTaps.count; i++) {
        [attString addAttribute:NSForegroundColorAttributeName value:UIColor.orangeColor range:[string rangeOfString:textTaps[i]]];
        [attString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:[string rangeOfString:textTaps[i]]];
        
    }
    return attString;
}


/**
 标题前加*
 */
+ (NSArray *)getAttListByPrefix:(NSString *)prefix titleList:(NSArray *)titleList mustList:(NSArray *)mustList{
    
    NSMutableArray * marr = [NSMutableArray arrayWithCapacity:0];
    
    for (NSString * item in titleList) {
        NSString * title = item;
        if (![title hasPrefix:prefix]) title = [prefix stringByAppendingString:title];
        if (![marr containsObject:title]) [marr addObject:title];
        
        UIColor *colorMust = [mustList containsObject:title] ? UIColor.redColor : UIColor.clearColor;
        
        NSArray *textTaps = @[prefix];
        NSAttributedString *attString = [NSAttributedString getAttString:title
                                                                textTaps:textTaps
                                                                    font:15
                                                                 tapFont:15
                                                                   color:UIColor.blackColor
                                                                tapColor:colorMust
                                                               alignment:NSTextAlignmentCenter];

        if (![marr containsObject:attString]) {
            NSUInteger index = [marr indexOfObject:title];
            [marr replaceObjectAtIndex:index withObject:attString];
            
        }
    }
    return marr.copy;
}

/**
 (推荐)单个标题前加*
 */
+ (NSAttributedString *)getAttringByPrefix:(NSString *)prefix content:(NSString *)content isMust:(BOOL)isMust{
    
    if (![content hasPrefix:prefix]) content = [prefix stringByAppendingString:content];
    
    UIColor *colorMust = isMust ? UIColor.redColor : UIColor.clearColor;
    
    NSArray *textTaps = @[prefix];
    NSAttributedString *attString = [NSAttributedString getAttString:content
                                                            textTaps:textTaps
                                                                font:15
                                                             tapFont:15
                                                               color:UIColor.blackColor
                                                            tapColor:colorMust
                                                           alignment:NSTextAlignmentCenter];

    return attString;
}

+ (NSAttributedString *)attrString:(NSString *)string{
    return [NSAttributedString getAttString:string
                                       font:14
                                      color:UIColor.blackColor
                                  alignment:NSTextAlignmentLeft];
}

+ (NSAttributedString *)hyperlinkFromString:(NSString *)string withURL:(NSURL *)aURL font:(UIFont *)font{
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString: string];
    
    NSRange range = NSMakeRange(0, attrString.length);
    
//    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc]init];
    NSDictionary * dic = @{NSFontAttributeName: font,
                           NSForegroundColorAttributeName: UIColor.blueColor,
                           NSLinkAttributeName: aURL.absoluteString,
                           NSUnderlineStyleAttributeName: @(NSUnderlineStyleSingle),
//                           NSParagraphStyleAttributeName: paraStyle,
//                           NSBaselineOffsetAttributeName: @15,
                           };
    
    [attrString beginEditing];
    [attrString addAttributes:dic range:range];
    [attrString endEditing];
    return attrString;
}


@end
