
//
//  UILabel+Helper.m
//  ProductTemplet
//
//  Created by Bin Shang on 2019/1/3.
//  Copyright © 2019 BN. All rights reserved.
//

#import "UILabel+Helper.h"
#import <NNGloble/NNGloble.h>
#import "UIColor+Helper.h"
#import "NSAttributedString+Helper.h"

@implementation UILabel (Helper)

- (NSAttributedString *)matt{
    if (self.attributedText) {
        return self.attributedText;
    }
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc]init];
    style.lineBreakMode = self.lineBreakMode;
    style.alignment = self.textAlignment;
    
    NSString *text = self.text ? : @"";
    NSMutableAttributedString *attString = text
    .matt
    .font(self.font)
    .color(self.textColor)
    .paragraphStyle(style);
    return attString;
}

/**
 [源]UILabel创建
 */
+ (instancetype)createRect:(CGRect)rect type:(NNLabelType)type{
    UILabel *label = [[self alloc] initWithFrame:rect];
    label.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    label.font = [UIFont systemFontOfSize:kFontSize16];
    [label setCustomType:type];
    return label;
}

- (void)setCustomType:(NNLabelType)type{
    switch (type) {
        case NNLabelTypeNumberOfLines0:
        {
            self.numberOfLines = 0;
            self.lineBreakMode = NSLineBreakByCharWrapping;
        }
            break;
        case NNLabelTypeNumberOfLines1:
        {
            self.numberOfLines = 1;
            self.lineBreakMode = NSLineBreakByTruncatingTail;
        }
            break;
        case NNLabelTypeFitWidth:
        {
            self.numberOfLines = 1;
            self.lineBreakMode = NSLineBreakByTruncatingTail;
            
            self.adjustsFontSizeToFitWidth = YES;
//            self.minimumScaleFactor = 0.8;
        }
            break;
        case NNLabelTypeOutline:
        {
            self.numberOfLines = 1;
            
            UIColor *titleColor = self.textColor ? : UIColor.clearColor;
            self.layer.borderColor = titleColor.CGColor;
            self.layer.borderWidth = 1.0;
        }
            break;
        default:
            break;
    }
}

///UILabel富文本设置
- (void)setContent:(NSString *)content attDic:(NSDictionary *)attDic{
    NSAssert([self.text containsString:content], @"不包含子标题");
    NSString *text = self.text;
    
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc]initWithString:text];
    NSRange range = [text rangeOfString:content];
    [attString addAttributes:attDic range:range];
    self.attributedText = attString;
}

- (void)appendAsteriskPrefix{
    self.attributedText = [self.text.matt appendPrefix:kAsterisk color:UIColor.redColor font:self.font];
}


@end
