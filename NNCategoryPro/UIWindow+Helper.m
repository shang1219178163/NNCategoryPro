//
//  UIWindow+Helper.m
//  ProductTemplet
//
//  Created by BIN on 2018/9/30.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "UIWindow+Helper.h"
#import "UIView+Helper.h"

@implementation UIWindow (Helper)

- (UIButton *)showFeedbackView:(UIImage *)image title:(NSString *)title{
    UIWindow *window = self;
    UIView *view = [window viewWithTag:9999];
    if (view) {
        [window bringSubviewToFront:view];
        return [window viewWithTag:992];
    }
    
    UIView *containView = ({
        CGFloat width = window.frame.size.width;
        CGFloat height = window.frame.size.height;
        
        CGSize imgSize = CGSizeMake(width/5.0, height/5.0);
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(width - imgSize.width, (height - imgSize.height - 30)/2.0, imgSize.width, imgSize.height + 30)];
        view.tag = 9999;
        view.backgroundColor = [UIColor.blackColor colorWithAlphaComponent:0.6];
        
        [view addGestureSwipe:^(UIGestureRecognizer * _Nonnull reco) {
            [UIView animateWithDuration:0.35 animations:^{
                reco.view.transform = CGAffineTransformMakeTranslation(reco.view.transform.tx + imgSize.width, reco.view.transform.ty);
            } completion:^(BOOL finished) {
                if (finished) {
                    [reco.view removeFromSuperview];
                }
            }];
        } forDirection:UISwipeGestureRecognizerDirectionRight];
        
        UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, imgSize.width, imgSize.height)];
        imgView.tag = 991;
        imgView.image = image;
        imgView.layer.borderColor = UIColor.grayColor.CGColor;
        imgView.layer.borderWidth = 0.5;
        [view addSubview:imgView];
        
        title = title ? : @"求助反馈";
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = 992;
        btn.frame = CGRectMake(0, imgSize.height, imgSize.width, 30);
        [btn setTitle:title forState:UIControlStateNormal];
        [btn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        [view addSubview:btn];
        
        view;
    });
    [window addSubview:containView];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [containView removeFromSuperview];
    });
    
    return [window viewWithTag:992];
}

@end

