//
//  UIImageView+Animation.m
//  BNAnimation
//
//  Created by BIN on 2018/9/26.
//  Copyright © 2018年 whkj. All rights reserved.
//

#import "UIImageView+Animation.h"

@implementation UIImageView (Animation)

- (void)addFlipAnimtion:(UIImage *)image backImage:(UIImage *)backImage{
    [UIView transitionWithView:self
                      duration:1.5f
                       options:UIViewAnimationOptionTransitionFlipFromLeft
                    animations:^{
        self.tag++;
        NSString * imgName = self.tag % 2 == 0 ? image : backImage;
        self.image = [UIImage imageNamed:imgName];
        
    } completion:^(BOOL finished) {
        if (finished) {
            [self addFlipAnimtion:image backImage:backImage];
        }
    }];
}

@end

