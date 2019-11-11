
//
//  UIImageView+Helper.m
//  ChildViewControllers
//
//  Created by BIN on 2018/1/16.
//  Copyright © 2018年 BIN. All rights reserved.
//

#import "UIImageView+Helper.h"

#import "NNGloble.h"
#import "UIView+Helper.h"
#import "UILabel+Helper.h"
#import "UIImage+Helper.h"
#import "NSObject+Helper.h"

#import "FLAnimatedImage.h"
#import "CABasicAnimation+Helper.h"

#import <SDWebImage/UIImageView+WebCache.h>

@implementation UIImageView (Helper)

/**
 [源]UIImageView创建
 */
+ (instancetype)createRect:(CGRect)rect type:(NSNumber *)type{
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
            UILabel * labelTip = [UILabel createTipWithSize:CGSizeMake(textWH, textWH) tipCenter:tipCenter text:text textColor:UIColor.themeColor];
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
+ (instancetype)createRect:(CGRect)rect type:(NSNumber *)type hasDeleteBtn:(BOOL)hasDeleteBtn{
    UIImageView *imgView = [self createRect:rect type:type];
    
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


+(UIImageView *)imgViewRect:(CGRect)rect imageList:(NSArray *)imageList type:(NSNumber *)type{
    UIImageView *imgView = nil;
    switch (type.integerValue) {
        case 0:
        {
            UIImage *image = [[UIImage imageNamed:imageList.firstObject] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
            image = [UIImage imageNamed:[imageList firstObject]];
            imgView = [[UIImageView alloc] initWithImage:image];
            imgView.frame = rect;
            
            CABasicAnimation *anim = [CABasicAnimation animKeyPath:@"transform.rotation" duration:10 fromValue:@(0) toValue:@(M_PI*2) autoreverses:NO repeatCount:10];
            [imgView.layer addAnimation:anim forKey:nil];
        }
            break;
        case 1:
        {
            NSString  *filePath = [[NSBundle bundleWithPath:NSBundle.mainBundle.bundlePath]pathForResource:@"loading" ofType:@"gif"];
            FLAnimatedImage *image = [FLAnimatedImage animatedImageWithGIFData:[NSData dataWithContentsOfFile:filePath]];
            imgView = [[FLAnimatedImageView alloc] initWithFrame:rect];
            ((FLAnimatedImageView *)imgView).animatedImage = image;
        }
            break;
        default:
        {
            UIImage * image = [UIImage imageNamed:imageList.firstObject];
            
            imgView = [[UIImageView alloc] initWithFrame:rect];
            imgView.image = image;
            NSMutableArray *marr = [NSMutableArray array];
            for (NSInteger i = 0; i < imageList.count; i++) {
                UIImage *image = [UIImage imageNamed:imageList[i]];
                [marr addObject:image];
            }
            imgView.animationImages = marr;
            imgView.animationDuration = 0.8;
            imgView.animationRepeatCount = 0;
            [imgView startAnimating];
            
        }
            break;
    }
    return imgView;
}

-(void)clipCorner:(CGFloat)radius{
    UIImage * image = [self.image imageAddCornerWithRadius:radius andSize:self.bounds.size];
    self.image = image;
}

-(void)loadImage:(id)image defaultImg:(NSString *)imageDefault{
    if (!image) {
        self.image = [UIImage imageNamed:imageDefault];
        return;
    }
    
    if ([image isKindOfClass:[UIImage class]]) {
        self.image = image;
        return;
    }
    
    if ([image isKindOfClass:[NSData class]]) {
        self.image = [UIImage imageWithData:image];
        return;
    }
    
    if ([image isKindOfClass:[NSString class]]) {
        if ([image hasPrefix:@"http"]) {
            [self sd_setImageWithURL:[NSURL URLWithString:image] placeholderImage:[UIImage imageNamed:imageDefault]];
        }
        else {
            self.image = [UIImage imageNamed:image] ? : [UIImage imageNamed:imageDefault];
        }
    }
}

-(void)showImageEnlarge{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(enlargeImageView:)];
    self.userInteractionEnabled = YES;
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    [self addGestureRecognizer:tap];
    
    [self enlargeImageView:tap];
}

-(void)enlargeImageView:(UITapGestureRecognizer *)tapAvatar{
    CGFloat kHeight = UIScreen.mainScreen.bounds.size.height;
    CGFloat kWidth = UIScreen.mainScreen.bounds.size.width;
    
    UIImageView *avatarImageView = (UIImageView *)tapAvatar.view;
    UIImage *image = avatarImageView.image;
    
    UIWindow *window = UIApplication.sharedApplication.keyWindow;
    
    UIView *backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWidth, kHeight)];
    
    CGRect oldframe = [avatarImageView convertRect:avatarImageView.bounds toView:window];
    
    backgroundView.backgroundColor = UIColor.blackColor;
    backgroundView.alpha = 1;
    backgroundView.tag = 1000;
    
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:oldframe];
    imageView.image = image;
    imageView.tag = 1001;
    [backgroundView addSubview:imageView];
    
    [window insertSubview:backgroundView atIndex:1];
    //
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideImageView:)];
    [backgroundView addGestureRecognizer:tap];
    
    [UIView animateWithDuration:0.15 animations:^{
        imageView.frame = CGRectMake(0,
                                     (kHeight - image.size.height*kWidth/image.size.width)/2,
                                     kWidth,
                                     image.size.height*kWidth/image.size.width);
        
        backgroundView.backgroundColor = UIColor.blackColor;
        backgroundView.alpha = 1;
    } completion:^(BOOL finished) {
        
    }];
}

-(void)hideImageView:(UITapGestureRecognizer *)tap{
    UIView *backgroundView = tap.view;
    UIImageView *imageView = (UIImageView*)[tap.view viewWithTag:1001];
    
    [UIView animateWithDuration:0.15 animations:^{
        imageView.frame = imageView.frame;
        backgroundView.alpha = 0;
        
    } completion:^(BOOL finished) {
        [backgroundView removeFromSuperview];
        
    }];
}

-(void)renderTintColor:(UIColor *)tintColor{
    [self renderTintColor:tintColor mode:UIImageRenderingModeAlwaysOriginal];
}

-(void)renderTintColor:(UIColor *)tintColor mode:(UIImageRenderingMode)mode {
    self.tintColor = tintColor;
    self.image = [self.image imageWithRenderingMode:mode];
}

@end
