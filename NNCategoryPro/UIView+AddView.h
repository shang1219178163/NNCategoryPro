//
//  UIView+AddView.h
//  
//
//  Created by BIN on 2017/7/31.
//  Copyright © 2017年 SHANG. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (AddView)

@property (nonatomic, strong) UIView *lineTop;
@property (nonatomic, strong) UIView *lineBottom;

@property (nonatomic, strong) CAGradientLayer *gradientLayer;

/**
 占位视图(.无数据,网络错误)
 */
@property (nonatomic, strong) UIView *holderView;

- (void)holderView:(NSString *)title image:(NSString *_Nullable)image;

- (void)addLineDashLayerColor:(UIColor *)color
                        width:(CGFloat)width
                  dashPattern:(NSArray <NSNumber *>*_Nullable)dashPattern
                 cornerRadius:(CGFloat)cornerRadius;

- (void)addLineRect:(CGRect)rect isDash:(BOOL)isDash inView:(UIView *)inView;

+ (UIView *)createLineRect:(CGRect)rect isDash:(BOOL)isDash hidden:(BOOL)hidden;

- (CALayer *)createLayerType:(NSNumber *)type;

- (CALayer *)createLayerType:(NSNumber *)type
                      color:(UIColor *)color
                      width:(CGFloat)width
               paddingScale:(CGFloat)paddingScale;

- (UIView *)createViewType:(NSNumber *)type;

- (UIView *)createViewType:(NSNumber *)type color:(UIColor *)color width:(CGFloat)width paddingScale:(CGFloat)paddingScale;

- (UIView *)addCorners:(UIRectCorner)corners
           cornerRadii:(CGSize)cornerRadii
                 width:(CGFloat)width
                 color:(UIColor *)color;

- (UIImage *)drawCorners:(UIRectCorner)corners
             cornerRadii:(CGFloat)radius
             borderWidth:(CGFloat)borderWidth
             borderColor:(UIColor *)borderColor
                 bgColor:(UIColor *)bgColor;
    
- (UIView *)addCorners:(UIRectCorner)corners cornerRadii:(CGSize)cornerRadii;
@end

NS_ASSUME_NONNULL_END
