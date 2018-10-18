//
//  CAShapeLayer+Helper.h
//  ProductTemplet
//
//  Created by hsf on 2018/9/29.
//  Copyright © 2018年 BN. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

@interface CAShapeLayer (Helper)

+(CAShapeLayer *)layerWithRect:(CGRect)rect path:(CGPathRef)path strokeEnd:(CGFloat)strokeEnd fillColor:(UIColor *)fillColor strokeColor:(UIColor *)strokeColor lineWidth:(CGFloat)lineWidth;

+(CAShapeLayer *)layerWithSender:(CALayer *)sender path:(CGPathRef)path fillColor:(UIColor *)fillColor strokeColor:(UIColor *)strokeColor opacity:(CGFloat)opacity;
    
@end
