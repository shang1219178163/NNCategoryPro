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

@property (nonatomic, strong) CAGradientLayer *gradientLayer;

/**
 占位视图(.无数据,网络错误)
 */
@property (nonatomic, strong) UIView *holderView;

-(void)holderView:(NSString *)title image:(NSString *)image;

-(void)addLineRect:(CGRect)rect isDash:(BOOL)isDash inView:(UIView *)inView;

+(UIView *)createLineRect:(CGRect)rect isDash:(BOOL)isDash hidden:(BOOL)hidden;

-(CALayer *)createLayerType:(NSNumber *)type;

-(CALayer *)createLayerType:(NSNumber *)type color:(UIColor *)color width:(CGFloat)width paddingScale:(CGFloat)paddingScale;

-(UIView *)createViewType:(NSNumber *)type;

-(UIView *)createViewType:(NSNumber *)type color:(UIColor *)color width:(CGFloat)width paddingScale:(CGFloat)paddingScale;

/**
 右指箭头
 */
+ (UIView *)createArrowRect:(CGRect)rect;

#pragma mark - - 类方法

+ (__kindof UIView *)createViewRect:(CGRect)rect;

+ (__kindof UILabel *)createLabelRect:(CGRect)rect type:(NSNumber *)type;
//小标志专用,例如左侧头像上的"企"
+ (__kindof UILabel *)createTipLabelWithSize:(CGSize)size tipCenter:(CGPoint)tipCenter text:(NSString *)text textColor:(UIColor *)textColor;

/**
 UITextField创建方法
 */
+ (__kindof UITextField *)createTextFieldRect:(CGRect)rect;

/**
 [简]UITextField创建方法
 */
+ (__kindof UITextField *)createTextFieldRect:(CGRect)rect placeholder:(NSString *)placeholder;

/**
 带提示的textView
 */
+ (__kindof UITextView *)createTextViewRect:(CGRect)rect;

/**
 [简]带提示的textView
 */
+ (__kindof UITextView *)createTextViewRect:(CGRect)rect placeholder:(NSString *)placeholder;

/**
 展示性质的textView,不提供编辑
 */
+ (__kindof UITextView *)createTextShowRect:(CGRect)rect;

/**
 富文本
 */
+ (__kindof UILabel *)createRichLabRect:(CGRect)rect text:(NSString *)text textTaps:(NSArray *)textTaps;
//imageView通用创建方法
+ (__kindof UIImageView *)createImgViewRect:(CGRect)rect type:(NSNumber *)type;

//选择图片使用
+ (__kindof UIImageView *)createImgViewRect:(CGRect)rect type:(NSNumber *)type hasDeleteBtn:(BOOL)hasDeleteBtn;

+ (__kindof UITextField *)createTextFieldRect:(CGRect)rect text:(NSString *)text;

+ (__kindof UIButton *)createBtnRect:(CGRect)rect title:(NSString *)title font:(CGFloat)font image:(NSString *_Nullable)image type:(NSNumber *)type;

+ (__kindof UIButton *)createBtnRect:(CGRect)rect title:(NSString *)title image:(NSString *_Nullable)image type:(NSNumber *)type;
    
+ (UIView *)createBtnViewRect:(CGRect)rect imgName:(NSString *)imgName imgHeight:(CGFloat)imgHeight title:(NSString *)title titleColor:(UIColor *)titleColor type:(NSNumber *)type;

/**
 UISegmentedControl通用创建方法
 */
+ (__kindof UISegmentedControl *)createSegmentRect:(CGRect)rect items:(NSArray *)items selectedIndex:(NSInteger)selectedIndex type:(NSNumber *)type;

/**
 UISlider通用创建方法
 */
+ (__kindof UISlider *)createSliderRect:(CGRect)rect value:(CGFloat)value minValue:(CGFloat)minValue maxValue:(CGFloat)maxValue;

/**
 UISwitch通用创建方法
 */
+ (__kindof UISwitch *)createSwitchRect:(CGRect)rect isOn:(BOOL)isOn;

+ (__kindof UITabBarItem *)createTabBarItem:(NSString *_Nullable)title image:(NSString *_Nullable)image selectedImage:(NSString *_Nullable)selectedImage;

+ (__kindof UIBarButtonItem *)createBarItem:(NSString *)obj style:(UIBarButtonItemStyle)style;

+ (__kindof UIBarButtonItem *)createBarItem:(NSString *)obj style:(UIBarButtonItemStyle)style target:(id _Nullable)target action:(SEL _Nullable)action;
/**
 [源]UITableView创建方法
 */
+ (__kindof UITableView *)createTableViewRect:(CGRect)rect style:(UITableViewStyle)style;

/**
 [源]UICollectionView创建方法
 */
+ (__kindof UICollectionView *)createCTViewRect:(CGRect)rect layout:(UICollectionViewLayout *)layout;

@end

NS_ASSUME_NONNULL_END
