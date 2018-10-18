//
//  UIImageView+Helper.h
//  ChildViewControllers
//
//  Created by BIN on 2018/1/16.
//  Copyright © 2018年 BIN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (Helper)

+(UIImageView *)imgViewWithRect:(CGRect)rect imageList:(NSArray *)imageList type:(NSNumber *)type;

- (void)clipCorner:(CGFloat)radius;

- (void)loadImage:(id)image defaultImg:(NSString *)imageDefault;

@end
