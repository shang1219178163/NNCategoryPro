//
//  UIImageView+Helper.h
//  ChildViewControllers
//
//  Created by BIN on 2018/1/16.
//  Copyright © 2018年 BIN. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (Helper)

/**
 [源]UIImageView创建
 */
+ (instancetype)createRect:(CGRect)rect type:(NSNumber *)type;

/**
 UIImageView(上传图片)选择图片使用
 */
+ (instancetype)createRect:(CGRect)rect type:(NSNumber *)type hasDeleteBtn:(BOOL)hasDeleteBtn;

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
- (void)loadImage:(nullable id)image defaultImg:(NSString *)imageDefault;

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

NS_ASSUME_NONNULL_END
