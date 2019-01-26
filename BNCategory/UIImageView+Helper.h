//
//  UIImageView+Helper.h
//  ChildViewControllers
//
//  Created by BIN on 2018/1/16.
//  Copyright © 2018年 BIN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (Helper)

/**
 gift效果

 @param type 不同的创建方式
 */
+(UIImageView *)imgViewRect:(CGRect)rect imageList:(NSArray *)imageList type:(NSNumber *)type;


/**
 切圆形

 */
- (void)clipCorner:(CGFloat)radius;

/**
 通用image加载方式

 */
- (void)loadImage:(id)image defaultImg:(NSString *)imageDefault;

/**
 单图全屏展示
 */
-(void)showImageEnlarge;

/**
 默认渲染AlwaysTemplate方式
 */
-(void)renderTintColor:(UIColor *)tintColor;

/**
 渲染
 */
-(void)renderTintColor:(UIColor *)tintColor mode:(UIImageRenderingMode)mode;
    
@end
