//
//  UIView+AddView.m
//  
//
//  Created by BIN on 2017/7/31.
//  Copyright © 2017年 SHANG. All rights reserved.
//

#import "UIView+AddView.h"
#import <objc/runtime.h>

#import <NNGloble/NNGloble.h>

#import "NSObject+Helper.h"
#import "UIView+Helper.h"
#import "UIImage+Helper.h"
#import "UIImageView+Helper.h"
#import "UITextView+Helper.h"
#import "UIGestureRecognizer+Helper.h"

#import "CALayer+Helper.h"

#import <SDWebImage/UIImageView+WebCache.h>

@implementation UIView (AddView)

- (UIView *)lineTop{
    id obj = objc_getAssociatedObject(self, _cmd);
    if (obj) {
        return obj;
    }
    
    UIView *view = ({
        CGRect rect = CGRectMake(0, 0, CGRectGetWidth(self.bounds), kH_LINE_VIEW);
        UIView *view = [[UIView alloc] initWithFrame:rect];
        view.hidden = true;
       
        view;
    });
    objc_setAssociatedObject(self, _cmd, view, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    return view;
}

- (void)setLineTop:(UIView *)lineTop{
    objc_setAssociatedObject(self, @selector(lineTop), lineTop, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)lineBottom{
    id obj = objc_getAssociatedObject(self, _cmd);
    if (obj) {
        return obj;
    }
    
    UIView *view = ({
        CGRect rect = CGRectMake(0, CGRectGetHeight(self.bounds) - kH_LINE_VIEW, CGRectGetWidth(self.bounds), kH_LINE_VIEW);
        UIView *view = [[UIView alloc] initWithFrame:rect];
        view.hidden = true;
       
        view;
    });
    objc_setAssociatedObject(self, _cmd, view, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    return view;
}

- (void)setLineBottom:(UIView *)lineBottom{
    objc_setAssociatedObject(self, @selector(lineBottom), lineBottom, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CAGradientLayer *)gradientLayer{
    id obj = objc_getAssociatedObject(self, _cmd);
    if (obj) {
        return obj;
    }
    
    NSArray *colors = @[[UIColor.themeColor colorWithAlphaComponent:0.5], [UIColor.themeColor colorWithAlphaComponent:0.9]];
     CAGradientLayer *layer = [CAGradientLayer layerWithRect:CGRectZero colors:colors start:CGPointMake(0, 0) end:CGPointMake(1.0, 0)];
    
    objc_setAssociatedObject(self, _cmd, layer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    return obj;
}

- (void)setGradientLayer:(CAGradientLayer *)gradientLayer{
    objc_setAssociatedObject(self, @selector(gradientLayer), gradientLayer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)holderView{
    id obj = objc_getAssociatedObject(self, _cmd);
    if (obj) {
        return obj;
    }
    
    UIView *view = ({
        UIView *view = [[UIView alloc] initWithFrame:self.bounds];
        view.hidden = true;
        
        CGFloat height = CGRectGetHeight(self.bounds) - 25*2;
        CGFloat YGap = height*0.2;
        
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, YGap, CGRectGetWidth(self.bounds), height*0.3)];
        imgView.contentMode = UIViewContentModeScaleAspectFit;
        imgView.userInteractionEnabled = YES;
        imgView.tag = kTAG_IMGVIEW;
        [view addSubview:imgView];
        
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(imgView.frame) + 25, CGRectGetWidth(self.bounds), 25)];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = @"暂无数据";
        label.textColor = UIColorHexValue(0x999999);
        label.tag = kTAG_LABEL;
        [view addSubview:label];

        view;
    });
    objc_setAssociatedObject(self, _cmd, view, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    return view;
}

-(void)setHolderView:(UIView *)holderView{
    objc_setAssociatedObject(self, @selector(holderView), holderView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)holderView:(NSString *)title image:(NSString *)image{
    UIImageView *imgView = [self viewWithTag:kTAG_IMGVIEW];
    UILabel *label = [self viewWithTag:kTAG_LABEL];
    label.text = title;
    if (!image) {
        label.center = CGPointMake(self.holderView.center.x, self.holderView.sizeHeight*0.35);
    } else {
        imgView.image = UIImageNamed(image);
    }
}

/**
 增加虚线边框
 */
- (void)addLineDashLayerColor:(UIColor *)color
                        width:(CGFloat)width
                  dashPattern:(NSArray <NSNumber *>*)dashPattern
                 cornerRadius:(CGFloat)cornerRadius {
    assert(CGRectEqualToRect(CGRectZero, self.bounds) == false);
    UIView *view = self;
    view.layer.borderColor = UIColor.clearColor.CGColor;
    view.layer.borderWidth = 0;
    
    CAShapeLayer *shapeLayer = CAShapeLayer.layer;
    //虚线的颜色
    shapeLayer.strokeColor = color.CGColor ? : UIColor.redColor.CGColor;
    //填充的颜色
    shapeLayer.fillColor = UIColor.clearColor.CGColor;
    shapeLayer.frame = view.bounds;
    shapeLayer.path = [UIBezierPath bezierPathWithRoundedRect:shapeLayer.frame cornerRadius:cornerRadius].CGPath;
    
    //虚线的宽度
    shapeLayer.lineWidth = width > 0.5 ? width : 1;
    //虚线的间隔
    shapeLayer.lineDashPattern = dashPattern ? : @[@4, @2];
    //设置线条的样式
    //    shapeLayer.lineCap = @"square";
    
    if (cornerRadius > 0) {
        view.layer.cornerRadius = cornerRadius;
        view.layer.masksToBounds = true;
    }
    
    [view.layer addSublayer:shapeLayer];
}

- (void)addLineRect:(CGRect)rect isDash:(BOOL)isDash inView:(UIView *)inView{
    if (!isDash) {
        UIView *lineView = [[UIView alloc]initWithFrame:rect];
//            lineView.backgroundColor = [Utilities colorWithHexString:@"#d2d2d2"];
        lineView.backgroundColor = UIColor.lineColor;
        [inView addSubview:lineView];
        
    } else {
        UIImageView *imgView = [[UIImageView alloc]initWithFrame:rect];
        imgView.backgroundColor = UIColor.clearColor;
        [inView addSubview:imgView];
        
        UIGraphicsBeginImageContext(imgView.frame.size);   //开始画线
        [imgView.image drawInRect:CGRectMake(0, 0, CGRectGetWidth(imgView.frame), CGRectGetHeight(imgView.frame))];
        CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);  //设置线条终点形状
        
        CGFloat lengths[] = {3,1.5};
        CGContextRef line = UIGraphicsGetCurrentContext();
        CGContextSetStrokeColorWithColor(line, UIColor.lightGrayColor.CGColor);
        
        CGContextSetLineDash(line, 0, lengths, 2);  //画虚线
        CGContextMoveToPoint(line, 0, 0);    //开始画线
        CGContextAddLineToPoint(line, CGRectGetMaxX(imgView.frame), 0);
        CGContextStrokePath(line);
        
        imgView.image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
}

+ (UIView *)createLineRect:(CGRect)rect isDash:(BOOL)isDash hidden:(BOOL)hidden{
    if (!isDash) {
        UIView *lineView = [[UIView alloc]initWithFrame:rect];
        lineView.backgroundColor = UIColor.lineColor;
        lineView.hidden = hidden;
        return lineView;
    } else {
        
        UIImageView *imgView = [[UIImageView alloc]initWithFrame:rect];
        imgView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        imgView.backgroundColor = UIColor.clearColor;
        
        UIGraphicsBeginImageContext(imgView.frame.size);   //开始画线
        [imgView.image drawInRect:CGRectMake(0, 0, CGRectGetWidth(imgView.frame), CGRectGetHeight(imgView.frame))];
        CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);  //设置线条终点形状
        
        CGFloat lengths[] = {3,1.5};
        CGContextRef line = UIGraphicsGetCurrentContext();
        CGContextSetStrokeColorWithColor(line, UIColor.lightGrayColor.CGColor);
        
        CGContextSetLineDash(line, 0, lengths, 2);  //画虚线
        CGContextMoveToPoint(line, 0, 0);    //开始画线
        CGContextAddLineToPoint(line, CGRectGetMaxX(imgView.frame), 0);
        CGContextStrokePath(line);
        
        imgView.image = UIGraphicsGetImageFromCurrentImageContext();
        imgView.hidden = hidden;
        UIGraphicsEndImageContext();
        return imgView;
    }
}

- (CGRect)rectWithLineType:(NSNumber *)type width:(CGFloat)width paddingScale:(CGFloat)paddingScale{
    UIView *view = self;
    CGRect rect = self.bounds;
    switch (type.integerValue) {
        case 0:
        {
            //上边框
            CGFloat paddingX = CGRectGetWidth(view.frame)*paddingScale;
            rect = CGRectMake(paddingX, 0, CGRectGetWidth(view.frame) - paddingX*2, width);
            
        }
            break;
        case 1:
        {
            //左边框
            CGFloat paddingY = CGRectGetHeight(view.frame)*paddingScale;
            rect = CGRectMake(0, paddingY, width, CGRectGetHeight(view.frame) - paddingY*2);
        }
            break;
        case 2:
        {
            //下边框
            CGFloat paddingX = CGRectGetWidth(view.frame)*paddingScale;
            rect = CGRectMake(paddingX, CGRectGetHeight(view.frame) - width, CGRectGetWidth(view.frame) - paddingX*2, width);
            
        }
            break;
        case 3:
        {
            //右边框
            CGFloat paddingY = CGRectGetHeight(view.frame)*paddingScale;
            rect = CGRectMake(CGRectGetWidth(view.frame) - width, paddingY, width, CGRectGetHeight(view.frame) - paddingY*2);
            
        }
            break;
        default:
            break;
    }
    return rect;
}

- (UIView *)createViewType:(NSNumber *)type{
    UIView *view = self;
    UIView *layer = [view createViewType:type color:UIColor.lineColor width:kW_LayerBorder paddingScale:0];
    
    return layer;
}

- (UIView *)createViewType:(NSNumber *)type
                    color:(UIColor *)color
                    width:(CGFloat)width
             paddingScale:(CGFloat)paddingScale{
    UIView *view = self;
    UIView *layer = [[UIView alloc]init];
    layer.backgroundColor = color;
    layer.frame = [view rectWithLineType:type width:width paddingScale:paddingScale];
    
    return layer;
}

- (CALayer *)createLayerType:(NSNumber *)type{
    UIView *view = self;
    CALayer *layer = [view createLayerType:type color:UIColor.lineColor width:kW_LayerBorder paddingScale:0];
    
    return layer;
}

- (CALayer *)createLayerType:(NSNumber *)type
                      color:(UIColor *)color
                      width:(CGFloat)width
               paddingScale:(CGFloat)paddingScale{
    UIView *view = self;
    CALayer *layer = CALayer.layer;
    layer.backgroundColor = color.CGColor;
    layer.frame = [view rectWithLineType:type width:width paddingScale:paddingScale];
    
    return layer;
}

#pragma mark -设置部分圆角

- (UIView *)addCorners:(UIRectCorner)corners
           cornerRadii:(CGSize)cornerRadii
                 width:(CGFloat)width
                 color:(UIColor *)color{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                   byRoundingCorners:corners
                                                         cornerRadii:cornerRadii];
    // 创建遮罩层
    CAShapeLayer *maskLayer = CAShapeLayer.layer;
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;   // 轨迹
    maskLayer.borderWidth = width;
    maskLayer.borderColor = color.CGColor;
    self.layer.mask = maskLayer;
    return self;
}

/**
 上下文绘制圆角矩形
 */
- (UIImage *)drawCorners:(UIRectCorner)corners
            cornerRadii:(CGFloat)radius
            borderWidth:(CGFloat)borderWidth
            borderColor:(UIColor *)borderColor
                 bgColor:(UIColor*)bgColor{
    CGSize size = self.bounds.size;
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    CGContextRef contextRef =  UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(contextRef, borderWidth);
    CGContextSetStrokeColorWithColor(contextRef, borderColor.CGColor);
    CGContextSetFillColorWithColor(contextRef, bgColor.CGColor);
    
    CGFloat halfBorderWidth = borderWidth / 2.0;
    CGFloat width = size.width;
    CGFloat height = size.height;
    
    CGContextMoveToPoint(contextRef,
                         width - halfBorderWidth,
                         radius + halfBorderWidth);
    CGContextAddArcToPoint(contextRef,
                           width - halfBorderWidth,
                           height - halfBorderWidth,
                           width - radius - halfBorderWidth,
                           height - halfBorderWidth, radius);  // 右下角角度
    CGContextAddArcToPoint(contextRef,
                           halfBorderWidth,
                           height - halfBorderWidth,
                           halfBorderWidth,
                           height - radius - halfBorderWidth, radius); // 左下角角度
    CGContextAddArcToPoint(contextRef,
                           halfBorderWidth,
                           halfBorderWidth,
                           width - halfBorderWidth,
                           halfBorderWidth,
                           radius); // 左上角
    CGContextAddArcToPoint(contextRef,
                           width - halfBorderWidth,
                           halfBorderWidth,
                           width - halfBorderWidth,
                           radius + halfBorderWidth,
                           radius); // 右上角
    CGContextDrawPath(contextRef, kCGPathFillStroke);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (UIView *)addCorners:(UIRectCorner)corners cornerRadii:(CGSize)cornerRadii{
    return [self addCorners:corners cornerRadii:cornerRadii width:1.0 color:UIColor.whiteColor];
}


@end
