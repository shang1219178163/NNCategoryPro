//
//  UIView+AddView.h
//  
//
//  Created by BIN on 2017/7/31.
//  Copyright © 2017年 SHANG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (AddView)

@property (nonatomic, copy) void(^segmentViewBlock)(NSInteger selectIndex);
@property (nonatomic, copy) void(^actionWithBlock)(NSInteger);

- (void)addLineRect:(CGRect)rect isDash:(BOOL)isDash tag:(NSInteger)tag inView:(UIView *)inView;

+ (UIView *)createLineRect:(CGRect)rect isDash:(BOOL)isDash hidden:(BOOL)hidden tag:(NSInteger)tag;

-(CALayer *)createLayerType:(NSNumber *)type;

-(CALayer *)createLayerType:(NSNumber *)type color:(UIColor *)color width:(CGFloat)width paddingScale:(CGFloat)paddingScale;

-(UIView *)createViewType:(NSNumber *)type;

-(UIView *)createViewType:(NSNumber *)type color:(UIColor *)color width:(CGFloat)width paddingScale:(CGFloat)paddingScale;

/**
 右指箭头
 */
+ (UIView *)createArrowRect:(CGRect)rect;

#pragma mark - - 类方法

/**
 UIView通用创建方法
 */
+ (UIView *)createViewRect:(CGRect)rect tag:(NSInteger)tag;

/**
 UILabel通用创建方法
 */
+ (UILabel *)createLabelRect:(CGRect)rect text:(id)text textColor:(UIColor *)textColor tag:(NSInteger)tag type:(NSNumber *)type font:(CGFloat)fontSize  backgroudColor:(UIColor *)backgroudColor alignment:(NSTextAlignment)alignment;

/**
 UILabel小标志专用,例如左侧头像上的"企"
 */
+ (UILabel *)createTipLabelWithSize:(CGSize)size tipCenter:(CGPoint)tipCenter text:(NSString *)text textColor:(UIColor *)textColor tag:(NSInteger)tag font:(CGFloat)fontSize backgroudColor:(UIColor *)backgroudColor alignment:(NSTextAlignment)alignment;

/**
 UIImageView通用创建方法
 */
+ (UIImageView *)createImgViewRect:(CGRect)rect image:(id)image tag:(NSInteger)tag type:(NSNumber *)type;

/**
 UIImageView多图片加手势
 */
+ (UIImageView *)createImageViewRect:(CGRect)rect image:(id)image tag:(NSInteger)tag target:(id)target aSelector:(SEL)aSelector;

/**
 UIImageView(上传图片)选择图片使用
 */
+ (UIImageView *)createImgViewRect:(CGRect)rect image:(id)image tag:(NSInteger)tag type:(NSNumber *)type hasDeleteBtn:(BOOL)hasDeleteBtn;

/**
 UITextField通用创建方法
 */
+ (UITextField *)createTextFieldRect:(CGRect)rect text:(NSString *)text placeholder:(NSString *)placeholder font:(CGFloat)fontSize textAlignment:(NSTextAlignment)textAlignment keyboardType:(UIKeyboardType)keyboardType tag:(NSInteger)tag;

/**
 UIButton通用创建方法
 */
+ (UIButton *)createBtnRect:(CGRect)rect title:(NSString *)title font:(CGFloat)fontSize image:(NSString *)image tag:(NSInteger)tag type:(NSNumber *)type target:(id)target aSelector:(SEL)aSelector;

/**
 CustomSegment通用创建方法
 */
+ (UIView *)createCustomSegmentWithTitleArr:(NSArray *)titleArr rect:(CGRect)rect tag:(NSInteger)tag selectedIndex:(NSInteger)selectedIndex font:(CGFloat)fontSize isBottom:(BOOL)isBottom;

/**
 BtnView通用创建方法
 */
+ (UIView *)createBtnViewRect:(CGRect)rect imgName:(NSString *)imgName imgHeight:(CGFloat)imgHeight title:(NSString *)title titleColor:(UIColor *)titleColor type:(NSNumber *)type;

/**
 UISegmentedControl通用创建方法
 */
+ (UISegmentedControl *)createSegmentRect:(CGRect)rect items:(NSArray *)items selectedIndex:(NSInteger)selectedIndex type:(NSNumber *)type;

/**
 UISlider通用创建方法
 */
+ (UISlider *)createSliderRect:(CGRect)rect value:(CGFloat)value minValue:(CGFloat)minValue maxValue:(CGFloat)maxValue;

/**
 UISwitch通用创建方法
 */
+ (UISwitch *)createSwitchRect:(CGRect)rect isOn:(BOOL)isOn;

@end
