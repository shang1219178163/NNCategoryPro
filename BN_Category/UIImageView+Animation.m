//
//  UIImageView+Animation.m
//  BN_Animation
//
//  Created by hsf on 2018/9/26.
//  Copyright © 2018年 whkj. All rights reserved.
//

#import "UIImageView+Animation.h"

@implementation UIImageView (Animation)

- (void)addAnimWithImageArr:(NSArray *)imageArr{

    [UIView transitionWithView:self duration:1.5f options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
        self.tag++;
        
        NSString * imgName = self.tag % 2 == 0 ? imageArr.firstObject : imageArr.lastObject;
        self.image = [UIImage imageNamed:imgName];
        
    } completion:^(BOOL finished) {
        [self addAnimWithImageArr:imageArr];
        
    }];
}

@end

