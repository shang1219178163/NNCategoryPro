//
//  UIView+AddView.m
//  
//
//  Created by BIN on 2017/7/31.
//  Copyright © 2017年 SHANG. All rights reserved.
//

#import "UIView+AddView.h"
#import <objc/runtime.h>

#import "NNGloble.h"

#import "NSObject+Helper.h"
#import "UIView+Helper.h"
#import "UIImage+Helper.h"
#import "UIImageView+Helper.h"
#import "UITextView+Helper.h"
#import "UIGestureRecognizer+Helper.h"

#import "CAGradientLayer+Helper.h"

#import <SDWebImage/UIImageView+WebCache.h>

@implementation UIView (AddView)

-(UIView *)lineTop{
    id obj = objc_getAssociatedObject(self, _cmd);
    if (!obj) {
        obj = ({
            CGRect rect = CGRectMake(0, 0, CGRectGetWidth(self.bounds), kH_LINE_VIEW);
            UIView *view = [[UIView alloc] initWithFrame:rect];
            view.hidden = true;
           
            view;
        });
        objc_setAssociatedObject(self, _cmd, obj, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
    }
    return obj;
}

- (void)setLineTop:(UIView *)lineTop{
    objc_setAssociatedObject(self, @selector(lineTop), lineTop, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(UIView *)lineBottom{
    id obj = objc_getAssociatedObject(self, _cmd);
    if (!obj) {
        obj = ({
            CGRect rect = CGRectMake(0, CGRectGetHeight(self.bounds) - kH_LINE_VIEW, CGRectGetWidth(self.bounds), kH_LINE_VIEW);
            UIView *view = [[UIView alloc] initWithFrame:rect];
            view.hidden = true;
           
            view;
        });
        objc_setAssociatedObject(self, _cmd, obj, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
    }
    return obj;
}

- (void)setLineBottom:(UIView *)lineBottom{
    objc_setAssociatedObject(self, @selector(lineBottom), lineBottom, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(CAGradientLayer *)gradientLayer{
    id obj = objc_getAssociatedObject(self, _cmd);
    if (!obj) {
        NSArray * colors = @[[UIColor.themeColor colorWithAlphaComponent:0.5], [UIColor.themeColor colorWithAlphaComponent:0.9]];
        obj = [CAGradientLayer layerRect:CGRectZero colors:colors start:CGPointMake(0, 0) end:CGPointMake(1.0, 0)];
        
        objc_setAssociatedObject(self, _cmd, obj, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return obj;
}

-(void)setGradientLayer:(CAGradientLayer *)gradientLayer{
    objc_setAssociatedObject(self, @selector(gradientLayer), gradientLayer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(UIView *)holderView{
    id obj = objc_getAssociatedObject(self, _cmd);
    if (!obj) {
        obj = ({
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
        objc_setAssociatedObject(self, _cmd, obj, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
    }
    return obj;
}

-(void)setHolderView:(UIView *)holderView{
    objc_setAssociatedObject(self, @selector(holderView), holderView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)holderView:(NSString *)title image:(NSString *)image{
    UIImageView *imgView = [self viewWithTag:kTAG_IMGVIEW];
    UILabel *label = [self viewWithTag:kTAG_LABEL];
    label.text = title;
    if (image == nil) {
        label.center = CGPointMake(self.holderView.center.x, self.holderView.sizeHeight*0.35);
    } else {
        imgView.image = UIImageNamed(image);
    }
}

/**
 增加虚线边框
 */
- (void)addLineDashLayerColor:(UIColor *)color width:(CGFloat)width dashPattern:(NSArray <NSNumber *>*)dashPattern cornerRadius:(CGFloat)cornerRadius {
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

-(void)addLineRect:(CGRect)rect isDash:(BOOL)isDash inView:(UIView *)inView{
    if (!isDash) {
        UIView * lineView = [[UIView alloc]initWithFrame:rect];
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

+(UIView *)createLineRect:(CGRect)rect isDash:(BOOL)isDash hidden:(BOOL)hidden{
    if (!isDash) {
        UIView * lineView = [[UIView alloc]initWithFrame:rect];
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

-(CGRect)rectWithLineType:(NSNumber *)type width:(CGFloat)width paddingScale:(CGFloat)paddingScale{
    UIView * view = self;
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

-(UIView *)createViewType:(NSNumber *)type{
    UIView * view = self;
    UIView * layer = [view createViewType:type color:UIColor.lineColor width:kW_LayerBorder paddingScale:0];
    
    return layer;
}

-(UIView *)createViewType:(NSNumber *)type color:(UIColor *)color width:(CGFloat)width paddingScale:(CGFloat)paddingScale{
    UIView * view = self;
    UIView * layer = [[UIView alloc]init];
    layer.backgroundColor = color;
    layer.frame = [view rectWithLineType:type width:width paddingScale:paddingScale];
    
    return layer;
}

-(CALayer *)createLayerType:(NSNumber *)type{
    UIView * view = self;
    CALayer * layer = [view createLayerType:type color:UIColor.lineColor width:kW_LayerBorder paddingScale:0];
    
    return layer;
}

-(CALayer *)createLayerType:(NSNumber *)type color:(UIColor *)color width:(CGFloat)width paddingScale:(CGFloat)paddingScale{
    UIView * view = self;
    CALayer * layer = CALayer.layer;
    layer.backgroundColor = color.CGColor;
    layer.frame = [view rectWithLineType:type width:width paddingScale:paddingScale];
    
    return layer;
}


//右指箭头
+ (UIView *)createArrowRect:(CGRect)rect{
    NSString * imageStrRight = kIMG_arrowRight;
//    CGSize imgViewRightSize = CGSizeMake(25, 25);
    UIImageView * imgViewRight = [UIImageView createRect:rect type:@0];
    imgViewRight.image = [UIImage imageNamed:imageStrRight];
    return imgViewRight;
}

#pragma mark - -类方法

/**
 [源]UIView创建
 */
+ (__kindof UIView *)createViewRect:(CGRect)rect{
    UIView * backgroundView = [[self alloc]initWithFrame:rect];
    backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    return backgroundView;
}

/**
 BtnView创建
 */
+ (UIView *)createBtnViewRect:(CGRect)rect imgName:(NSString *)imgName imgHeight:(CGFloat)imgHeight title:(NSString *)title titleColor:(UIColor *)titleColor type:(NSNumber *)type{

    UIView * backgroudView = [[UIView alloc]initWithFrame:rect];
    
    UIImageView * imgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:imgName]];
    imgView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    imgView.contentMode = UIViewContentModeScaleAspectFit;
    imgView.userInteractionEnabled = YES;
    imgView.tag = kTAG_IMGVIEW;
    
    CGRect labRect = CGRectZero;
    switch (type.integerValue) {
        case 0://图上名下
        {
            CGFloat gapY = (CGRectGetHeight(rect) - imgHeight - kH_LABEL)/3.0;
//            imgV.frame = CGRectMake(0, gapY, CGRectGetWidth(rect), imgHeight);
//            labRect = CGRectMake(CGRectGetMinX(rect), CGRectGetMaxY(imgV.frame)+gapY, CGRectGetWidth(imgV.frame), kH_LABEL);
            labRect = CGRectMake(0, CGRectGetHeight(rect) - kH_LABEL - gapY, CGRectGetWidth(rect), kH_LABEL);
            imgView.frame = CGRectMake(0, gapY, CGRectGetWidth(rect), imgHeight);
        }
            break;
        case 1://图左名右
        {
            CGFloat gapY = (CGRectGetHeight(rect) - imgHeight)/2.0;
            imgView.frame = CGRectMake(kPadding, gapY, imgHeight, imgHeight);
            labRect = CGRectMake(CGRectGetMaxX(imgView.frame) + kPadding, CGRectGetMinY(imgView.frame), CGRectGetWidth(rect) - CGRectGetMaxX(imgView.frame) - kPadding*2, CGRectGetHeight(imgView.frame));
        }
            break;
        case 2://图左名右
        {
            imgView.frame = CGRectMake(0, 0, CGRectGetWidth(rect) * 1/3, CGRectGetHeight(rect));
            labRect = CGRectMake(CGRectGetMaxX(imgView.frame), CGRectGetMinY(imgView.frame), CGRectGetWidth(rect) - CGRectGetWidth(imgView.frame), CGRectGetHeight(imgView.frame));
        }
            break;
        case 3://leftMenu 安全保障//图上名下
        {
            labRect = CGRectMake(0, 35, CGRectGetWidth(rect), kH_LABEL);
            imgView.frame = CGRectMake((CGRectGetWidth(rect) - 35)/2.0, 0, 35, 35);
            
        }
            break;
        case 4://企业//图左名右
        {
            CGFloat YGap = (CGRectGetHeight(rect) - imgHeight)/2.0;
            CGFloat padding = 0;
            imgView.frame = CGRectMake(YGap, YGap, imgHeight, imgHeight);
            labRect = CGRectMake(CGRectGetMaxX(imgView.frame) + padding, CGRectGetMinY(imgView.frame), CGRectGetWidth(rect) - CGRectGetMaxX(imgView.frame) - CGRectGetMinX(imgView.frame) - padding , imgHeight);
            
        }
            break;
        default:
            break;
    }
    UILabel * lab = [[UILabel alloc]initWithFrame:labRect];
    lab.text = title;
    lab.textColor = titleColor;
    lab.textAlignment = NSTextAlignmentCenter;
    lab.font = [UIFont systemFontOfSize:kFontSize16];
    lab.numberOfLines = 1;
    lab.lineBreakMode = NSLineBreakByTruncatingTail;
    lab.tag = kTAG_LABEL;
    
    lab.adjustsFontSizeToFitWidth = YES;
    //    lab.minimumScaleFactor = 0.5;
    
    //    DDLog(@"imgV.frame %@ labRect  %@",NSStringFromCGRect(imgV.frame),NSStringFromCGRect(labRect));
//    imgV.backgroundColor = UIColor.redColor;
//    lab.backgroundColor = UIColor.yellowColor;
//    backgroudView.backgroundColor = UIColor.greenColor;
//    backgroudView.layer.borderColor = UIColor.lineColor.CGColor;
//    backgroudView.layer.borderWidth = kW_LayerBorder;
        
    [backgroudView addSubview:imgView];
    [backgroudView addSubview:lab];
    
    [backgroudView getViewLayer];

    return backgroudView;
}

#pragma mark - otherFuntions


@end
