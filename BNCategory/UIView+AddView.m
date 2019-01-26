//
//  UIView+AddView.m
//  
//
//  Created by BIN on 2017/7/31.
//  Copyright © 2017年 SHANG. All rights reserved.
//

#import "UIView+AddView.h"
#import <objc/runtime.h>

#import "BNGloble.h"

#import "NSObject+Helper.h"
#import "UIView+Helper.h"
#import "UIImage+Helper.h"
#import "UIImageView+Helper.h"

#import <SDWebImage/UIImageView+WebCache.h>

@interface UIView (addView)

@property (nonatomic, strong) NSArray * selectedArr;
@property (nonatomic, assign) NSInteger selectedIndex;

@end

@implementation UIView (AddView)

@dynamic actionWithBlock;
@dynamic segmentViewBlock;

- (void)addLineRect:(CGRect)rect isDash:(BOOL)isDash tag:(NSInteger)tag inView:(UIView *)inView{
    if (!isDash) {
        if (![inView viewWithTag:tag]) {
            UIView * lineView = [[UIView alloc]initWithFrame:rect];
            //            lineView.backgroundColor = [Utilities colorWithHexString:@"#d2d2d2"];
            lineView.backgroundColor = UIColor.lineColor;
            
            [inView addSubview:lineView];
        } else {
            UIView * linView = (UIView *)[inView viewWithTag:tag];
            linView.frame = rect;
        }
        
    } else {
        if (![inView viewWithTag:tag]) {
            UIImageView *imgView = [[UIImageView alloc]initWithFrame:rect];
            imgView.tag = tag;
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

        } else {
            UIImageView * imageView = (UIImageView *)[inView viewWithTag:tag];
            imageView.frame = rect;
            imageView.backgroundColor = UIColor.clearColor;
            
            UIGraphicsBeginImageContext(imageView.frame.size);   //开始画线
            [imageView.image drawInRect:CGRectMake(0, 0, CGRectGetWidth(imageView.frame), CGRectGetHeight(imageView.frame))];
            CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);  //设置线条终点形状
            
            CGFloat lengths[] = {3,1.5};
            CGContextRef line = UIGraphicsGetCurrentContext();
            CGContextSetStrokeColorWithColor(line, UIColor.lightGrayColor.CGColor);
            
            CGContextSetLineDash(line, 0, lengths, 2);  //画虚线
            CGContextMoveToPoint(line, 0, 0);    //开始画线
            CGContextAddLineToPoint(line, CGRectGetMaxX(imageView.frame), 0);
            CGContextStrokePath(line);
            
            imageView.image = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();

        }
    }
}

+ (UIView *)createLineRect:(CGRect)rect isDash:(BOOL)isDash hidden:(BOOL)hidden tag:(NSInteger)tag{
    if (!isDash) {
        UIView * lineView = [[UIView alloc]initWithFrame:rect];
        lineView.backgroundColor = UIColor.lineColor;
        lineView.hidden = hidden;
        return lineView;
    } else {
        
        UIImageView *imgView = [[UIImageView alloc]initWithFrame:rect];
        imgView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        imgView.tag = tag;
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

    UIImageView * imgViewRight = [UIView createImgViewRect:rect image:imageStrRight tag:kTAG_IMGVIEW type:@0];
    return imgViewRight;
}

#pragma mark - -类方法

/**
 [源]UIView创建
 */
+ (UIView *)createViewRect:(CGRect)rect tag:(NSInteger)tag{
    UIView * backgroundView = [[UIView alloc]initWithFrame:rect];
    backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    backgroundView.tag = tag;
    return backgroundView;
}

/**
 [源]UILabel创建
 */
+ (UILabel *)createLabelRect:(CGRect)rect text:(id)text font:(CGFloat)font tag:(NSInteger)tag type:(NSNumber *)type
{
    NSAssert([text isKindOfClass: NSString.class] || [text isKindOfClass: NSAttributedString.class], @"数据格式不对");
    UILabel * label = [[UILabel alloc] initWithFrame:rect];
    label.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    label.font = [UIFont systemFontOfSize:font];
    if ([text isKindOfClass:[NSAttributedString class]]){
        label.attributedText = text;
    } else {
        label.text = text;
    }
    label.tag = tag;
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
+ (UILabel *)createTipLabelWithSize:(CGSize)size tipCenter:(CGPoint)tipCenter text:(NSString *)text textColor:(UIColor *)textColor tag:(NSInteger)tag
{
    UILabel * label = [UIView createLabelRect:CGRectMake(0, 0, size.width, size.height) text:text font:16 tag:tag type:@1];
    label.center = tipCenter;
    label.textColor = textColor;
    label.textAlignment = NSTextAlignmentCenter;
    return label;
}

/**
 [源]UIImageView创建
 */
+ (UIImageView *)createImgViewRect:(CGRect)rect image:(id)image tag:(NSInteger)tag type:(NSNumber *)type{
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:rect];
    imgView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    imgView.contentMode = UIViewContentModeScaleAspectFit;
    imgView.userInteractionEnabled = YES;
    imgView.tag = tag;
   
    [imgView loadImage:image defaultImg:kIMG_defaultFailed_S];
            
    switch (type.integerValue) {
        case 1://圆形
        {
            imgView.contentMode = UIViewContentModeScaleToFill;
            [imgView addCornersAll];

        }
            break;
        case 2://带右下角icon
        {
            //小标志
            NSString * text = @"企";
            CGSize textSize = [self sizeWithText:text font:@(kFZ_Third) width:kScreenWidth];
            CGFloat textWH = textSize.height > textSize.width ? textSize.height :textSize.width;
            textWH += 5;
            CGFloat offsetXY = CGRectGetHeight(rect)/2.0 * sin(45 * M_PI/180.0);
            CGPoint tipCenter = CGPointMake(CGRectGetHeight(rect)/2.0 + offsetXY, CGRectGetHeight(rect)/2.0 + offsetXY);
            //
            UILabel * labelTip = [UIView createTipLabelWithSize:CGSizeMake(textWH, textWH) tipCenter:tipCenter text:text textColor:UIColor.themeColor tag:kTAG_LABEL];
            [imgView addSubview:labelTip];
            
        }
            break;
        case 3://圆角矩形
        {
            imgView.contentMode = UIViewContentModeScaleToFill;
            [imgView addCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(5, 5)];

        }
            break;
        default:
            break;
    }
    return imgView;
}

/**
 UIImageView(上传图片)选择图片使用
 */
+ (UIImageView *)createImgViewRect:(CGRect)rect image:(id)image tag:(NSInteger)tag type:(NSNumber *)type hasDeleteBtn:(BOOL)hasDeleteBtn
{
    UIImageView *imgView = [UIView createImgViewRect:rect image:image tag:tag type:type];
    
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
+ (UITextField *)createTextFieldRect:(CGRect)rect text:(NSString *)text tag:(NSInteger)tag
{
    UITextField * textField = [[UITextField alloc]initWithFrame:rect];
    textField.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    textField.tag = tag;
    
    textField.text = text;
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
    //        textField.layer.borderWidth = 1;  // 给图层添加一个有色边框
    //        textField.layer.borderColor = [UtilityHelper colorWithHexString:@"d2d2d2"].CGColor;
    textField.backgroundColor = UIColor.whiteColor;
//    textField.backgroundColor = UIColor.clearColor;
    
    return textField;
}

/**
 [源]UIButton创建
 */
+ (UIButton *)createBtnRect:(CGRect)rect title:(NSString *)title font:(CGFloat)font image:(NSString *)image tag:(NSInteger)tag type:(NSNumber *)type{
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    
    btn.frame = rect;
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:font];
    btn.titleLabel.adjustsFontSizeToFitWidth = YES;
    
    btn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    btn.tag = tag;
    
    switch (type.integerValue) {
        case 0://白色背景黑色字体圆角
        {
            btn.layer.masksToBounds = YES;
            btn.layer.cornerRadius = CGRectGetHeight(rect)/10;
            btn.layer.borderColor = UIColor.lineColor.CGColor;
            btn.layer.borderWidth = 1;
            
            [btn setTitleColor:UIColor.titleColor forState:UIControlStateNormal];
            [btn setBackgroundImage:UIImageColor(UIColor.whiteColor) forState:UIControlStateNormal];
            
        }
            break;
        case 1://橘色背景白色字体无圆角
        {
            [btn setBackgroundImage:UIImageColor(UIColor.btnColor_N) forState:UIControlStateNormal];
            [btn setBackgroundImage:UIImageColor(UIColor.btnColor_H) forState:UIControlStateHighlighted];
            [btn setBackgroundImage:UIImageColor(UIColor.btnColor_D) forState:UIControlStateDisabled];
            
            [btn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
            
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
            
        }
            break;
        case 4://橘色背景白色字体圆角
        {
            btn.layer.masksToBounds = YES;
            btn.layer.cornerRadius = CGRectGetHeight(rect)/10;
            //            btn.layer.borderColor = UIColor.btnColor_N.CGColor;
            //            btn.layer.borderWidth = kW_LayerBorder;
            
            [btn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
            [btn setBackgroundImage:UIImageColor(UIColor.themeColor) forState:UIControlStateNormal];
            
        }
            break;
        case 5://白色背景黑色字体无圆角无边框
        {
            [btn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
            
            
        }
            break;
        case 6://白色背景黑色字体无圆角
        {
            btn.layer.masksToBounds = YES;
            btn.layer.cornerRadius = CGRectGetHeight(rect)/10.0;
            
            btn.layer.borderColor = UIColor.lineColor.CGColor;
            btn.layer.borderWidth = kW_LayerBorder;
            
            [btn setTitleColor:UIColor.titleColor forState:UIControlStateNormal];
            [btn setBackgroundImage:UIImageColor(UIColor.whiteColor) forState:UIControlStateNormal];
            
        }
            break;
        case 7://白色背景橘色字体圆角
        {
            btn.layer.masksToBounds = YES;
            btn.layer.cornerRadius = CGRectGetHeight(rect)/10.0;
            
            btn.layer.borderColor = UIColor.btnColor_N.CGColor;
            btn.layer.borderWidth = kW_LayerBorder;
            
            [btn setTitleColor:UIColor.btnColor_N forState:UIControlStateNormal];
            
        }
            break;
        case 8://蓝色背景白色字体颜色圆角
        {
            btn.layer.masksToBounds = YES;
            btn.layer.cornerRadius = CGRectGetHeight(rect)/10;
            
            [btn setBackgroundImage:UIImageColor(UIColor.themeColor) forState:UIControlStateNormal];
            [btn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
            
        }
            break;
        case 9://白色背景橘色字体
        {
            [btn setTitleColor:UIColor.orangeColor forState:UIControlStateNormal];
            
        }
            break;
        case 10://红色背景白色字体
        {
            [btn setBackgroundImage:UIImageColor(UIColor.redColor) forState:UIControlStateNormal];
            [btn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
            
            [btn showLayerColor:UIColor.redColor];
        }
            break;
        case 11://
        {
            [btn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
            [btn setBackgroundImage:UIImageColor(UIColor.backgroudColor) forState:UIControlStateNormal];
            
            [btn setTitleColor:UIColor.whiteColor forState:UIControlStateSelected];
            [btn setBackgroundImage:UIImageColor(UIColor.themeColor) forState:UIControlStateSelected];
            
        }
            break;
        default:
            break;
    }
    return btn;
}

/**
 BtnView创建
 */
+ (UIView *)createBtnViewRect:(CGRect)rect imgName:(NSString *)imgName imgHeight:(CGFloat)imgHeight title:(NSString *)title titleColor:(UIColor *)titleColor type:(NSNumber *)type
{

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
    lab.font = [UIFont systemFontOfSize:kFZ_Second];
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
+ (UISegmentedControl *)createSegmentRect:(CGRect)rect items:(NSArray *)items selectedIndex:(NSInteger)selectedIndex type:(NSNumber *)type{
    UISegmentedControl *view = [[UISegmentedControl alloc] initWithItems:items];
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
                                    NSForegroundColorAttributeName :   UIColor.blackColor,
                                    NSFontAttributeName            :   [UIFont systemFontOfSize:15],
                                    
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
                                       NSFontAttributeName:[UIFont boldSystemFontOfSize:15],
                                       NSForegroundColorAttributeName:UIColor.blackColor,
                                       };
            
            NSDictionary *attDic_H = @{
                                       NSFontAttributeName:[UIFont boldSystemFontOfSize:18],
                                       NSForegroundColorAttributeName:UIColor.themeColor,
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
                                        NSForegroundColorAttributeName : UIColor.blackColor,
                                        NSFontAttributeName:[UIFont systemFontOfSize:15.0f],
                                        
                                        };
            
            // 选中状态下
            NSDictionary * attDic_H = @{
                                        NSForegroundColorAttributeName : UIColor.themeColor,
                                        NSFontAttributeName : [UIFont boldSystemFontOfSize:18.0f],
                                        
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
                                    NSFontAttributeName            :   [UIFont systemFontOfSize:15],
                                    
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
+ (UISlider *)createSliderRect:(CGRect)rect value:(CGFloat)value minValue:(CGFloat)minValue maxValue:(CGFloat)maxValue{
    UISlider *view = [[UISlider alloc] initWithFrame:rect];
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
+ (UISwitch *)createSwitchRect:(CGRect)rect isOn:(BOOL)isOn{
    UISwitch *view = [[UISwitch alloc]initWithFrame:rect];
    view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    view.on = isOn;//设置初始为ON的一边
    view.onTintColor = UIColor.themeColor;
//    view.tintColor = UIColor.whiteColor;
    
    return view;
}



@end
