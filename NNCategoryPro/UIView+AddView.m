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

#import "CAGradientLayer+Helper.h"

#import <SDWebImage/UIImageView+WebCache.h>

@implementation UIView (AddView)

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
    UIImageView * imgViewRight = [UIImageView createImgViewRect:rect type:@0];
    imgViewRight.image = [UIImage imageNamed:imageStrRight];
    return imgViewRight;
}

#pragma mark - -类方法

/**
 [源]UIView创建
 */
+ (__kindof UIView *)createViewRect:(CGRect)rect{
    assert([self isSubclassOfClass: UIImageView.class]);
    UIView * backgroundView = [[self alloc]initWithFrame:rect];
    backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    return backgroundView;
}

/**
 [源]UILabel创建
 */
+ (__kindof UILabel *)createLabelRect:(CGRect)rect type:(NSNumber *)type{
    assert([self isSubclassOfClass: UILabel.class]);
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

//    label.backgroundColor = UIColor.greenColor;
//    label.backgroundColor = UIColor.whiteColor;
    
//    label.layer.borderWidth = kW_LayerBorder;
//    label.layer.borderColor = UIColor.blueColor.CGColor;

    return label;
}

/**
 UILabel小标志专用,例如左侧头像上的"企"
 */
+ (__kindof UILabel *)createTipLabelWithSize:(CGSize)size tipCenter:(CGPoint)tipCenter text:(NSString *)text textColor:(UIColor *)textColor{
    UILabel * label = [self createLabelRect:CGRectMake(0, 0, size.width, size.height) type:@1];
    label.center = tipCenter;
    label.textColor = textColor;
    label.textAlignment = NSTextAlignmentCenter;
    return label;
}

/**
 [源]UIImageView创建
 */
+ (__kindof UIImageView *)createImgViewRect:(CGRect)rect type:(NSNumber *)type{
    assert([self isSubclassOfClass: UIImageView.class]);
    UIImageView *view = [[self alloc] initWithFrame:rect];
    view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    view.contentMode = UIViewContentModeScaleAspectFit;
    view.userInteractionEnabled = YES;

//    [view loadImage:image defaultImg:kIMG_defaultFailed_S];
    
    switch (type.integerValue) {
        case 1://圆形
        {
            view.contentMode = UIViewContentModeScaleToFill;
            [view addCornersAll];

        }
            break;
        case 2://带右下角icon
        {
            //小标志
            NSString * text = @"企";
            CGSize textSize = [self sizeWithText:text font:@(kFontSize14) width:kScreenWidth];
            CGFloat textWH = textSize.height > textSize.width ? textSize.height :textSize.width;
            textWH += 5;
            CGFloat offsetXY = CGRectGetHeight(rect)/2.0 * sin(45 * M_PI/180.0);
            CGPoint tipCenter = CGPointMake(CGRectGetHeight(rect)/2.0 + offsetXY, CGRectGetHeight(rect)/2.0 + offsetXY);
            //
            UILabel * labelTip = [UILabel createTipLabelWithSize:CGSizeMake(textWH, textWH) tipCenter:tipCenter text:text textColor:UIColor.themeColor];
            [view addSubview:labelTip];
            
        }
            break;
        case 3://圆角矩形
        {
            view.contentMode = UIViewContentModeScaleToFill;
            [view addCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(5, 5)];

        }
            break;
        default:
            break;
    }
    return view;
}

/**
 UIImageView(上传图片)选择图片使用
 */
+ (__kindof UIImageView *)createImgViewRect:(CGRect)rect type:(NSNumber *)type hasDeleteBtn:(BOOL)hasDeleteBtn{
    assert([self isSubclassOfClass: UIImageView.class]);
    UIImageView *imgView = [self createImgViewRect:rect type:type];
    
    CGSize btnSize = CGSizeMake(25, 25);
    UIButton * deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    deleteBtn.frame = CGRectMake(CGRectGetWidth(rect) - btnSize.width, 0, btnSize.width, btnSize.height);
    [deleteBtn setImage:[UIImage imageNamed:kIMG_pictureDelete] forState:UIControlStateNormal];
    //    deleteBtn.imageEdgeInsets = UIEdgeInsetsMake(-10, 0, 0, -10);
    deleteBtn.tag = kTAG_BTN;
    deleteBtn.alpha = 0.6;
    [imgView addSubview:deleteBtn];

    deleteBtn.hidden = !hasDeleteBtn;

    return imgView;
}

/**
 [源]UITextField创建
 */
+ (__kindof UITextField *)createTextFieldRect:(CGRect)rect{
    assert([self isSubclassOfClass: UITextField.class]);
    UITextField * textField = [[self alloc]initWithFrame:rect];
    textField.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    textField.placeholder = @"请输入";
    textField.textAlignment = NSTextAlignmentLeft;
    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
    textField.keyboardAppearance = UIKeyboardAppearanceDefault;
    textField.keyboardType = UIReturnKeyDone;
    
    //        textField.returnKeyType = UIReturnKeyDone;
    //        textField.clearButtonMode = UITextFieldViewModeAlways;
    
    textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    textField.autocorrectionType = UITextAutocorrectionTypeNo;
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;//清楚键
    textField.borderStyle = UITextBorderStyleRoundedRect;

    textField.backgroundColor = UIColor.whiteColor;
//    textField.backgroundColor = UIColor.clearColor;
    
    return textField;
}

+ (__kindof UITextField *)createTextFieldRect:(CGRect)rect placeholder:(NSString *)placeholder{
    UITextField *textField = [self createTextFieldRect:rect];
    textField.placeholder = placeholder;
    return textField;
}

/**
 [源]UITextView创建
 */
+ (__kindof UITextView *)createTextViewRect:(CGRect)rect{
    assert([self isSubclassOfClass: UITextView.class]);
    
    UITextView *textView = [[self alloc] initWithFrame:rect];
    textView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    textView.font = [UIFont systemFontOfSize:15];
    textView.textAlignment = NSTextAlignmentLeft;
    
    textView.keyboardAppearance = UIKeyboardAppearanceDefault;
    textView.keyboardType = UIReturnKeyDefault;
    
    textView.autocorrectionType = UITextAutocorrectionTypeNo;
    textView.autocapitalizationType = UITextAutocapitalizationTypeNone;
    
    textView.layer.borderWidth = 0.5;
    textView.layer.borderColor = UIColor.lineColor.CGColor;
    [textView scrollRectToVisible:rect animated:YES];
    //    textView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    
    //    textView.backgroundColor = UIColor.whiteColor;
    //    textView.backgroundColor = UIColor.clearColor;
    
    return textView;
}

+ (__kindof UITextView *)createTextViewRect:(CGRect)rect placeholder:(NSString *)placeholder{
    UITextView *textView = [self createTextViewRect:rect];
    textView.placeHolderTextView.text = placeholder;
    textView.placeHolderTextView.textColor = UIColor.titleSubColor;
    return textView;
}

/**
 不可编辑UITextView创建
 */
+ (__kindof UITextView *)createTextShowRect:(CGRect)rect{
    UITextView *textView = [self createTextViewRect:rect];
    
    textView.contentOffset = CGPointMake(0, 8);//textView文本显示区域距离顶部为8像素
    textView.editable = NO;
    textView.dataDetectorTypes = UIDataDetectorTypeAll;
    //    textView.layer.borderWidth = 0.5;
    //    textView.layer.borderColor = UIColor.redColor.CGColor;
    
    return textView;
}

/**
 [源]UIButton创建
 */
+ (__kindof UIButton *)createBtnRect:(CGRect)rect title:(NSString *)title image:(NSString *_Nullable)image type:(NSNumber *)type{
    assert([self isSubclassOfClass: UIButton.class]);
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    
    btn.frame = rect;
    [btn setTitle:title forState:UIControlStateNormal];
//    btn.titleLabel.adjustsFontSizeToFitWidth = YES;
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    
    btn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    switch (type.integerValue) {
        case 1://主题背景白色字体无圆角
        {
            [btn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
            [btn setBackgroundImage:UIImageColor(UIColor.themeColor) forState:UIControlStateNormal];
            
        }
            break;
        case 2://白色背景灰色字体无边框
        {
            [btn setTitleColor:UIColor.titleSubColor forState:UIControlStateNormal];
        }
            break;
        case 3://地图定位按钮一类
        {
            [btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
            [btn setBackgroundImage:UIImageColor(UIColor.lightGrayColor) forState:UIControlStateDisabled];
            btn.adjustsImageWhenHighlighted = false;
        }
            break;
        case 4://白色背景主题色字体和边框
        {
            [btn setTitleColor:UIColor.themeColor forState:UIControlStateNormal];
            btn.layer.borderColor = UIColor.themeColor.CGColor;
            btn.layer.borderWidth = kW_LayerBorder;
            
        }
            break;
        case 5://白色背景主题字体无边框
        {
            [btn setTitleColor:UIColor.themeColor forState:UIControlStateNormal];
            
        }
            break;
        case 6://红色背景白色字体
        {
            [btn setBackgroundImage:UIImageColor(UIColor.redColor) forState:UIControlStateNormal];
            [btn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
            
            [btn showLayerColor:UIColor.redColor];
        }
            break;
        case 7://灰色背景黑色字体无边框
        {
            [btn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
            [btn setBackgroundImage:UIImageColor(UIColor.backgroudColor) forState:UIControlStateNormal];
            
            [btn setTitleColor:UIColor.whiteColor forState:UIControlStateSelected];
            [btn setBackgroundImage:UIImageColor(UIColor.themeColor) forState:UIControlStateSelected];
            
        }
            break;
        case 8://白色背景红色字体无边框
        {
            [btn setTitleColor:UIColor.redColor forState:UIControlStateNormal];
        }
            break;
        default:
        {
            //白色背景黑色字体灰色边框
            [btn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
            btn.layer.borderColor = UIColor.lineColor.CGColor;
            btn.layer.borderWidth = 1;
        }
            break;
    }
    return btn;
    
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

#pragma mark - - otherFuntions

/**
 [源]UISegmentedControl创建方法
 */
+ (__kindof UISegmentedControl *)createSegmentRect:(CGRect)rect items:(NSArray *)items selectedIndex:(NSInteger)selectedIndex type:(NSNumber *)type{
    assert([self isSubclassOfClass: UISegmentedControl.class]);

    UISegmentedControl *view = [[self alloc] initWithItems:items];
    view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    view.frame = rect;
    
    view.selectedSegmentIndex = selectedIndex < items.count ? selectedIndex : 0;
    switch (type.integerValue) {
        case 1:
        {
            view.tintColor = UIColor.themeColor;
            view.backgroundColor = UIColor.whiteColor;
            
            view.layer.borderWidth = 1;
            view.layer.borderColor = UIColor.whiteColor.CGColor;
            
            NSDictionary * dict = @{
                                    NSForegroundColorAttributeName: UIColor.blackColor,
                                    NSFontAttributeName:            [UIFont systemFontOfSize:15],
                                    
                                    };
            
            [view setTitleTextAttributes:dict forState:UIControlStateNormal];
            [view setDividerImage:UIImageColor(UIColor.whiteColor) forLeftSegmentState:UIControlStateNormal rightSegmentState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
            
        }
            break;
        case 2:
        {
            view.tintColor = UIColor.whiteColor;
            view.backgroundColor = UIColor.whiteColor;
            
            NSDictionary *attDic_N = @{
                                       NSFontAttributeName:             [UIFont boldSystemFontOfSize:15],
                                       NSForegroundColorAttributeName:  UIColor.blackColor,
                                       };
            
            NSDictionary *attDic_H = @{
                                       NSFontAttributeName:             [UIFont boldSystemFontOfSize:18],
                                       NSForegroundColorAttributeName:  UIColor.themeColor,
                                       };
            
            [view setTitleTextAttributes:attDic_N forState:UIControlStateNormal];
            [view setTitleTextAttributes:attDic_H forState:UIControlStateSelected];
            
        }
            break;
        case 3:
        {
            //背景透明,只有标题颜色
            // 去掉颜色,现在整个segment偶看不到,可以相应点击事件
            view.tintColor = UIColor.clearColor;
            view.backgroundColor = UIColor.lineColor;
            
            // 正常状态下
            NSDictionary * attDic_N = @{
                                        NSForegroundColorAttributeName: UIColor.blackColor,
                                        NSFontAttributeName:            [UIFont systemFontOfSize:15.0f],
                                        
                                        };
            
            // 选中状态下
            NSDictionary * attDic_H = @{
                                        NSForegroundColorAttributeName: UIColor.themeColor,
                                        NSFontAttributeName:            [UIFont boldSystemFontOfSize:18.0f],
                                        
                                        };
            [view setTitleTextAttributes:attDic_N forState:UIControlStateNormal];
            [view setTitleTextAttributes:attDic_H forState:UIControlStateSelected];
        }
            break;
        default:
        {
            view.tintColor = UIColor.themeColor;
            view.backgroundColor = UIColor.whiteColor;
            
            NSDictionary * dict = @{
                                    NSFontAttributeName:    [UIFont systemFontOfSize:15],
                                    
                                    };
            
            [view setTitleTextAttributes:dict forState:UIControlStateNormal];
        }
            break;
    }
    return view;
}
/**
 [源]UISlider创建方法
 */
+ (__kindof UISlider *)createSliderRect:(CGRect)rect value:(CGFloat)value minValue:(CGFloat)minValue maxValue:(CGFloat)maxValue{
    assert([self isSubclassOfClass: UISlider.class]);

    UISlider *view = [[self alloc] initWithFrame:rect];
    view.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    view.minimumValue = minValue;
    view.maximumValue = maxValue;
    view.value = value;
    
    view.minimumTrackTintColor = UIColor.themeColor;
//    view.maximumTrackTintColor = UIColor.redColor;
//    view.thumbTintColor = UIColor.yellowColor;
    return view;
}
/**
 [源]UISwitch创建方法
 */
+ (__kindof UISwitch *)createSwitchRect:(CGRect)rect isOn:(BOOL)isOn{
    assert([self isSubclassOfClass: UISwitch.class]);

    UISwitch *view = [[self alloc]initWithFrame:rect];
    view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    view.on = isOn;//设置初始为ON的一边
    view.onTintColor = UIColor.themeColor;
//    view.tintColor = UIColor.whiteColor;
    
    return view;
}

+ (__kindof UITabBarItem *)createTabBarItem:(NSString *_Nullable)title image:(NSString *_Nullable)image selectedImage:(NSString *_Nullable)selectedImage{
    assert([self isSubclassOfClass: UITabBarItem.class]);

    UITabBarItem *tabBarItem = [[self alloc]initWithTitle:title image:[UIImage imageNamed:image] selectedImage:[UIImage imageNamed:selectedImage]];
    return tabBarItem;
}

/**
 导航栏 UIBarButtonItem
 */
+ (__kindof UIBarButtonItem *)createBarItem:(NSString *)obj style:(UIBarButtonItemStyle)style{
    return [self createBarItem:obj style:style target:nil action:nil];
}

/**
 [源] 导航栏 UIBarButtonItem
 */
+ (__kindof UIBarButtonItem *)createBarItem:(NSString *)obj style:(UIBarButtonItemStyle)style target:(id _Nullable)target action:(SEL _Nullable)action{
    assert([self isSubclassOfClass: UIBarButtonItem.class]);

    if ([UIImage imageNamed:obj]) {
        UIBarButtonItem* barItem = [[self alloc] initWithImage:[[UIImage imageNamed:obj] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] style:style target:target action:action];
        return barItem;
    }
    UIBarButtonItem* barItem = [[self alloc] initWithTitle:obj style:style target:target action:action];
    return barItem;
}

/**
 [源]UITableView创建方法
 */
+ (__kindof UITableView *)createTableViewRect:(CGRect)rect style:(UITableViewStyle)style{
    assert([self isSubclassOfClass: UITableView.class]);
    
    UITableView *view = [[self alloc] initWithFrame:rect style:style];
    view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    view.separatorInset = UIEdgeInsetsZero;
    view.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    view.rowHeight = 70;
    view.backgroundColor = UIColor.backgroudColor;
    view.tableFooterView = [[UIView alloc]init];
    view.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    [view registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    
    return view;
}

/**
 [源]UICollectionView创建方法
 */
+ (__kindof UICollectionView *)createCTViewRect:(CGRect)rect layout:(UICollectionViewLayout *)layout{
    assert([self isSubclassOfClass: UICollectionView.class]);
    
    UICollectionView *view = [[self alloc]initWithFrame:rect collectionViewLayout:layout];
    view.backgroundColor = [UIColor whiteColor];
    view.showsVerticalScrollIndicator = false;
    view.showsHorizontalScrollIndicator = false;
    view.scrollsToTop = false;
    view.pagingEnabled = true;

    return view;
}

@end
