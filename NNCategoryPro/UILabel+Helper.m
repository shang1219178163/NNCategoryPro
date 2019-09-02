
//
//  UILabel+Helper.m
//  ProductTemplet
//
//  Created by Bin Shang on 2019/1/3.
//  Copyright © 2019 BN. All rights reserved.
//

#import "UILabel+Helper.h"

@implementation UILabel (Helper)

/**
 UILabel富文本设置
 */
- (NSMutableAttributedString *)setContent:(NSString *)content attDic:(NSDictionary *)attDic{
    NSAssert([self.text containsString:content], @"包含子标题");
    NSString * text = self.text;
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc]initWithString:text];
    NSRange range = [text rangeOfString:content];
    [attString addAttributes:attDic range:range];
    self.attributedText = attString;
    return attString;
}


@end
