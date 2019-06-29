
//
//  NSAttributedString+Helper.m
//  MacTemplet
//
//  Created by Bin Shang on 2019/6/27.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

#import "NSAttributedString+Helper.h"

@implementation NSAttributedString (Helper)

+ (__kindof NSAttributedString *)attrString:(NSString *)string font:(CGFloat)font alignment:(NSTextAlignment)alignment{
    
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc]init];
    paraStyle.alignment = alignment;
    
    NSDictionary *attrDic = @{
                              NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Light" size:font],
                              NSForegroundColorAttributeName: UIColor.blackColor,
                              NSParagraphStyleAttributeName: paraStyle,
                              };
    
    NSAttributedString * attrString = [[self alloc]initWithString:string attributes:attrDic];
    return attrString;
}

+ (NSAttributedString *)attrString:(NSString *)string{
    return [NSAttributedString attrString:string font:14 alignment:NSTextAlignmentLeft];
}

+ (NSAttributedString *)hyperlinkFromString:(NSString *)string withURL:(NSURL *)aURL font:(UIFont *)font{
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString: string];
    
    NSRange range = NSMakeRange(0, attrString.length);
    
//    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc]init];
    NSDictionary * dic = @{
                           NSFontAttributeName: font,
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
