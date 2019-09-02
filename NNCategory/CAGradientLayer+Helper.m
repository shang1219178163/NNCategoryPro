//
//  CAGradientLayer+Helper.m
//  BNAnimation
//
//  Created by BIN on 2018/10/16.
//  Copyright © 2018年 世纪阳天. All rights reserved.
//

#import "CAGradientLayer+Helper.h"

@implementation CAGradientLayer (Helper)

+(CAGradientLayer *)layerRect:(CGRect)rect colors:(NSArray *)colors start:(CGPoint)start end:(CGPoint)end{
    
    CAGradientLayer *layer = CAGradientLayer.layer;
    layer.frame = rect;
    layer.colors = colors;
    //45度变色(由lightColor－>white)
    layer.startPoint = start;
    layer.endPoint = end;

    return layer;
}

@end
