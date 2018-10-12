//
//  UIImageView+ClickImageEnlarge.m
//  Test
//
//  Created by ibokan on 14-4-1.
//  Copyright (c) 2014年 ibokan. All rights reserved.
//

#import "UIImageView+ClickImageEnlarge.h"

static CGRect oldframe;
static const CGFloat kAnimateDuration = 0.0;

@implementation UIImageView (ClickImageEnlarge)

-(void)showImageEnlarge{
    
    UITapGestureRecognizer *tapAvatar = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(enlargeImageView:)];
    self.userInteractionEnabled = YES;
    tapAvatar.numberOfTapsRequired = 1;
    tapAvatar.numberOfTouchesRequired = 1;
    [self addGestureRecognizer:tapAvatar];
    
    if (self.gestureRecognizers.count != 0) {
//        DDLog(@"%@",self.gestureRecognizers);
    }
    [self enlargeImageView:tapAvatar];
}
/*
-(void)showImage:(UIImageView *)avatarImageView{
    
    UITapGestureRecognizer *tapAvatar = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(enlargeImageView:)];
    avatarImageView.userInteractionEnabled = YES;
    tapAvatar.numberOfTapsRequired = 1;
    tapAvatar.numberOfTouchesRequired = 1;
    [avatarImageView addGestureRecognizer:tapAvatar];
}
 */
-(void)enlargeImageView:(UITapGestureRecognizer *)tapAvatar{
    
    UIImageView *avatarImageView = (UIImageView *)tapAvatar.view;
    UIImage *image = avatarImageView.image;
    
    UIWindow *window = UIApplication.sharedApplication.keyWindow;
    
    UIView *backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height)];
    
    oldframe = [avatarImageView convertRect:avatarImageView.bounds toView:window];
    
    backgroundView.backgroundColor = UIColor.blackColor;
    backgroundView.alpha = 1;
    //
    backgroundView.tag = 1000;
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:oldframe];
    imageView.image = image;
    imageView.tag = 1001;
    
    [backgroundView addSubview:imageView];
    
//    window.backgroundColor = UIColor.yellowColor;
    [window insertSubview:backgroundView atIndex:1];
    //
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideImageView:)];
    [backgroundView addGestureRecognizer:tap];
    
    [UIView animateWithDuration:kAnimateDuration animations:^{
        
        imageView.frame=CGRectMake(0,(UIScreen.mainScreen.bounds.size.height-image.size.height*UIScreen.mainScreen.bounds.size.width/image.size.width)/2, UIScreen.mainScreen.bounds.size.width, image.size.height*UIScreen.mainScreen.bounds.size.width/image.size.width);
        
        backgroundView.backgroundColor = UIColor.blackColor;
        backgroundView.alpha = 1;
    } completion:^(BOOL finished) {
        
    }];
    
}
-(void)hideImageView:(UITapGestureRecognizer*)tap{
    
    UIView *backgroundView = tap.view;
    UIImageView *imageView = (UIImageView*)[tap.view viewWithTag:1001];
    
    [UIView animateWithDuration:kAnimateDuration animations:^{
        
        imageView.frame = oldframe;
        backgroundView.alpha = 0;
    } completion:^(BOOL finished) {
        
        [backgroundView removeFromSuperview];
    }];
}

@end

