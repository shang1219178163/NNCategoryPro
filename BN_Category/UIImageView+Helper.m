
//
//  UIImageView+Helper.m
//  ChildViewControllers
//
//  Created by BIN on 2018/1/16.
//  Copyright © 2018年 BIN. All rights reserved.
//

#import "UIImageView+Helper.h"

#import "BN_Globle.h"
#import "UIImage+Helper.h"
#import "NSObject+Helper.h"

#import "FLAnimatedImage.h"
#import "CABasicAnimation+Helper.h"

#import <SDWebImage/UIImageView+WebCache.h>

@implementation UIImageView (Helper)

+(UIImageView *)imgViewWithRect:(CGRect)rect imageList:(NSArray *)imageList type:(NSNumber *)type{
    
    UIImageView *imgView = nil;
    switch ([type integerValue]) {
        case 0:
        {
            UIImage *image = [[UIImage imageNamed:[imageList firstObject]] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
            image = [UIImage imageNamed:[imageList firstObject]];
            imgView = [[UIImageView alloc] initWithImage:image];
            imgView.frame = rect;
            
            
            CABasicAnimation *anim = [CABasicAnimation animKeyPath:@"transform.rotation" duration:10 fromValue:@(0) toValue:@(M_PI*2) autoreverses:NO repeatCount:10];
            [imgView.layer addAnimation:anim forKey:nil];
        }
            break;
        case 1:
        {
            UIImage * image = [UIImage imageNamed:[imageList firstObject]];
            
            imgView = [[UIImageView alloc] initWithFrame:rect];
            imgView.image = image;
            NSMutableArray *marr = [NSMutableArray arrayWithCapacity:0];
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
        case 2:
        {
            NSString  *filePath = [[NSBundle bundleWithPath:[[NSBundle mainBundle] bundlePath]]pathForResource:@"loading" ofType:@"gif"];
            FLAnimatedImage *image = [FLAnimatedImage animatedImageWithGIFData:[NSData dataWithContentsOfFile:filePath]];
            imgView = [[FLAnimatedImageView alloc] initWithFrame:rect];
            ((FLAnimatedImageView *)imgView).animatedImage = image;
        }
            break;
        default:
            break;
    }
    return imgView;
}

- (void)clipCorner:(CGFloat)radius{
    UIImage * image = [self.image imageAddCornerWithRadius:radius andSize:self.bounds.size];
    self.image = image;
}

- (void)loadImage:(id)image defaultImg:(NSString *)imageDefault{
//    NSParameterAssert([image isKindOfClass:[NSString class]] || [image isKindOfClass:[UIImage class]]);
    if (!image || ![image validObject]) {
        self.image = [UIImage imageNamed:imageDefault];
        return;
    }
    
    if ([image isKindOfClass:[UIImage class]]) {
        self.image = image;
        return;
    }
    
    if ([image isKindOfClass:[NSString class]]) {
        if ([image hasPrefix:@"http"]) {
            self.image = [UIImage imageNamed:imageDefault];//占位
            
            imageDefault = imageDefault ? : kIMAGE_default_failed_S;//
            [self sd_setImageWithURL:image placeholderImage:[UIImage imageNamed:imageDefault]];//
            
        }
        else{
            self.image = [UIImage imageNamed:image];
            
        }
    }
    
}


@end
