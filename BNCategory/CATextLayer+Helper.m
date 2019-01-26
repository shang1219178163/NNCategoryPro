//
//  CATextLayer+Helper.m
//  BNAlertView
//
//  Created by BIN on 2018/9/10.
//  Copyright © 2018年 SouFun. All rights reserved.
//

#import "CATextLayer+Helper.h"

@implementation CATextLayer (Helper)


+(CATextLayer *)createRect:(CGRect)rect string:(NSString *)string font:(UIFont *)font textColor:(UIColor *)textColor alignmentMode:(NSString *)alignmentMode{
    
    CATextLayer *titleLayer = CATextLayer.layer;
    titleLayer.frame = rect;
    titleLayer.string = string;
    titleLayer.foregroundColor = textColor.CGColor;
    titleLayer.font = CFBridgingRetain(font.fontName);
    titleLayer.fontSize = font.pointSize;
    titleLayer.alignmentMode = alignmentMode;
    titleLayer.contentsScale = UIScreen.mainScreen.scale;
    return titleLayer;
}

@end
