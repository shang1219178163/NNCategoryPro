//
//  NSMutableParagraphStyle+Helper.m
//  ProductTemplet
//
//  Created by Bin Shang on 2019/4/26.
//  Copyright © 2019 BN. All rights reserved.
//

#import "NSMutableParagraphStyle+Helper.h"

@implementation NSMutableParagraphStyle (Helper)

+(NSMutableParagraphStyle)createBreakModel:(NSLineBreakMode )lineBreakMode alignment:(NSTextAlignment )alignment lineSpacing:(CGFloat )lineSpacing{
    NSMutableParagraphStyle * style = [[NSMutableParagraphStyle alloc]init];
    style.lineBreakMode = .byCharWrapping;
    style.alignment = .left;
    style.lineSpacing = lineSpacing;
    return style
}

@end
