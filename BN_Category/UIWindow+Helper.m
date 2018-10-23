//
//  UIWindow+Helper.m
//  ProductTemplet
//
//  Created by hsf on 2018/9/30.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "UIWindow+Helper.h"

#import "BN_Globle.h"
#import "UIView+Toast.h"
#import "NSObject+Helper.h"
#import "UIImageView+Helper.h"
#import "MBProgressHUD.h"
//#import "PopoverView.h"


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
    UIImageView * imgView = [UIImageView imgViewWithRect:rect imageList:imageList type:@1];
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
        
        //        [keyWindow makeToast:msg duration:kAnimationDuration_Toast position:position style:style];
        // Make toast with an image, title, and completion block
        [keyWindow makeToast:msg
                    duration:kAnimationDuration_Toast
                    position:position
                       title:nil
                       image:[UIImage imageNamed:image]
                       style:style
                  completion:completion];
    });
}

//+ (void)showPopByView:(UIView *)pointView items:(NSArray<NSDictionary *> *)items handler:(BlockPopoverView)handler{
//    
//    dispatch_async(dispatch_get_main_queue(), ^{
//        //        UIWindow *keyWindow = UIApplication.sharedApplication.keyWindow;
//        
//        PopoverView *view = [PopoverView popoverView];
//        view.arrowStyle = PopoverViewArrowStyleRound;
//        view.style = PopoverViewStyleDark;
//        
//        [view showToView:pointView items:items];
//        view.blockView = handler;
//        
//    });
//}


@end

