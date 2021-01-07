
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
#import "NSMutableAttributedString+Chain.h"

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
+ (instancetype)createRect:(CGRect)rect type:(NSNumber *)type{
    UILabel * label = [[self alloc] initWithFrame:rect];
    label.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    label.font = [UIFont systemFontOfSize:kFontSize16];
    switch (type.integerValue) {
        case 0://无限折行
        {
            label.numberOfLines = 0;
            label.lineBreakMode = NSLineBreakByCharWrapping;
        }
            break;
        case 1://abc...
        {
            label.numberOfLines = 1;
            label.lineBreakMode = NSLineBreakByTruncatingTail;
        }
            break;
        case 2://一行字体大小自动调节
        {
            label.numberOfLines = 1;
            label.lineBreakMode = NSLineBreakByTruncatingTail;
            
            label.adjustsFontSizeToFitWidth = YES;
//            label.minimumScaleFactor = 0.8;
        }
            break;
        case 3://圆形
        {
            label.textAlignment = NSTextAlignmentCenter;
            label.numberOfLines = 1;
      
//            label.layer.masksToBounds = YES;
            label.layer.cornerRadius = CGRectGetWidth(rect)/2.0;
            
            label.layer.shouldRasterize = YES;
            label.layer.rasterizationScale = UIScreen.mainScreen.scale;
        }
            break;
        case 4://带边框的圆角矩形标签
        {
            label.numberOfLines = 1;
            
            label.layer.borderColor = UIColor.themeColor.CGColor;
            label.layer.borderWidth = 1.0;
            label.layer.masksToBounds = YES;
            label.layer.cornerRadius = 3;
        }
            break;
        default:
            break;
    }

    return label;
}

/**
 UILabel小标志专用,例如左侧头像上的"企"
 */
+ (instancetype)createTipWithSize:(CGSize)size
                        tipCenter:(CGPoint)tipCenter
                             text:(NSString *)text
                        textColor:(UIColor *)textColor{
    UILabel *label = [self createRect:CGRectMake(0, 0, size.width, size.height) type:@1];
    label.center = tipCenter;
    label.textColor = textColor;
    label.textAlignment = NSTextAlignmentCenter;
    return label;
}
///UILabel富文本设置
- (NSMutableAttributedString *)setContent:(NSString *)content attDic:(NSDictionary *)attDic{
    NSAssert([self.text containsString:content], @"包含子标题");
    NSString *text = self.text;
    
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc]initWithString:text];
    NSRange range = [text rangeOfString:content];
    [attString addAttributes:attDic range:range];
    self.attributedText = attString;
    return attString;
}


@end
