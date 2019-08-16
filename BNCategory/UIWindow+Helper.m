//
//  UIWindow+Helper.m
//  ProductTemplet
//
//  Created by BIN on 2018/9/30.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "UIWindow+Helper.h"

#import "BNGloble.h"
#import "UIView+Toast.h"
#import "NSObject+Helper.h"
#import "UIImageView+Helper.h"
#import "MBProgressHUD.h"
//#import "PopoverView.h"
#import "UIView+Helper.h"


@implementation UIWindow (Helper)

+ (void)showHUDAddedToView:(UIView *)view animated:(BOOL)animated{
    
    UIWindow * keyWindow = UIApplication.sharedApplication.keyWindow;
    if ([MBProgressHUD HUDForView:keyWindow]) {
        MBProgressHUD * hud = [MBProgressHUD HUDForView:keyWindow];
        dispatch_async(dispatch_get_main_queue(), ^{
            [hud hideAnimated:YES];
            
        });
    }
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:keyWindow animated:animated];
    //    hud.label.text = NSLocalizedString(kMsg_NetWorkRequesting, @"HUD loading title");
    
    //自定义动画
    hud.mode = MBProgressHUDModeCustomView;
    
    NSArray * imageList = @[@"loading0",@"loading1",@"loading2",@"loading3",@"loading4",@"loading5",@"loading6",@"loading7",];
    
    CGRect rect = CGRectMake(0, 0, 25, 25);
    UIImageView * imgView = [UIImageView imgViewRect:rect imageList:imageList type:@1];
    hud.customView = imgView;

}

+ (void)showHUDinView:(UIView *)inView animated:(BOOL)animated{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        UIWindow * keyWindow = UIApplication.sharedApplication.keyWindow;
        if ([MBProgressHUD HUDForView:inView]) {
            MBProgressHUD * hud = [MBProgressHUD HUDForView:inView];
            [hud hideAnimated:YES];
        }
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:keyWindow animated:animated];
        hud.label.text = NSLocalizedString(kMsg_NetWorkRequesting, @"HUD loading title");
        
    });
}

+ (void)showToastWithTips:(NSString *)tips place:(id)place{
    [self showToastWithTips:tips image:nil place:place completion:nil];
    
}

+ (void)showToastWithTips:(NSString *)tips place:(id)place completion:(void(^)(BOOL didTap))completion{
    [self showToastWithTips:tips image:nil place:place completion:completion];
}

+ (void)showToastWithTips:(NSString *)tips success:(NSNumber *)success place:(id)place completion:(void(^)(BOOL didTap))completion{
    NSString *image = [success isEqualToNumber:@1]  ?   @"MBHUD_Info"   :   @"MBHUD_Error";
    [self showToastWithTips:tips image:image place:place completion:completion];
}

+ (void)showToastWithTips:(NSString *)tips image:(id)image place:(id)place completion:(void(^)(BOOL didTap))completion{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        UIWindow *keyWindow = UIApplication.sharedApplication.keyWindow;
        
        if ([MBProgressHUD HUDForView:keyWindow]) {
            MBProgressHUD * hud = [MBProgressHUD HUDForView:keyWindow];
            [hud hideAnimated:YES];
        }
        NSString * msg = tips ? tips : kMsg_NetWorkFailed;
        
        //添加在window上可以通用于多个导航控制器的情况
        NSString * position = (NSString *)CSToastPositionCenter;
        NSDictionary * dict = @{
                                @"0" : CSToastPositionTop,
                                @"1" : CSToastPositionCenter,
                                @"2" : CSToastPositionBottom,
                                };
        if ([place isKindOfClass:[NSNumber class]] && [dict.allKeys containsObject:[place stringValue]]){
            position = dict[[place stringValue]];
            
        }
        else if ([place isKindOfClass:[NSValue class]]){
            position = [place pointerValue];
            
        }
        
        CSToastStyle *style = [[CSToastStyle alloc] initWithDefaultStyle];
        style.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];//white 0-1为黑到白,alpha透明度
        style.titleColor = UIColor.whiteColor;
        style.cornerRadius = 5.0;
        style.imageSize = CGSizeMake(20, 20);
        //或者(白底黑字)
        //        style.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.5];
        //        style.titleColor = UIColor.blackColor;
        //        style.messageColor = UIColor.blackColor;
        
        //        [keyWindow makeToast:msg duration:kDurationToast position:position style:style];
        // Make toast with an image, title, and completion block
        [keyWindow makeToast:msg
                    duration:kDurationToast
                    position:position
                       title:nil
                       image:[UIImage imageNamed:image]
                       style:style
                  completion:completion];
    });
}

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
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(width - imgSize.width, (height - imgSize.height - 30)/2.0, imgSize.width, imgSize.height + 30)];
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

