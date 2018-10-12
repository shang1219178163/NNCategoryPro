//
//  UIView+AddView.h
//  HuiZhuBang
//
//  Created by BIN on 2017/7/31.
//  Copyright © 2017年 WeiHouKeJi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (AddView)

@property (nonatomic, copy) void(^segmentViewBlock)(NSInteger selectIndex);
@property (nonatomic, copy) void(^actionWithBlock)(NSInteger);

- (void)addLineWithRect:(CGRect)rect isDash:(BOOL)isDash tag:(NSInteger)tag inView:(UIView *)inView;

+ (UIView *)createLineWithRect:(CGRect)rect isDash:(BOOL)isDash hidden:(BOOL)hidden tag:(NSInteger)tag;

-(CALayer *)createLayerType:(NSNumber *)type;

-(CALayer *)createLayerType:(NSNumber *)type color:(UIColor *)color width:(CGFloat)width paddingScale:(CGFloat)paddingScale;

-(UIView *)createViewType:(NSNumber *)type;

-(UIView *)createViewType:(NSNumber *)type color:(UIColor *)color width:(CGFloat)width paddingScale:(CGFloat)paddingScale;

/**
 右指箭头
 */
+ (UIView *)createArrowWithRect:(CGRect)rect;

#pragma mark - - 类方法

/**
 UIView通用创建方法
 */
+ (UIView *)createViewWithRect:(CGRect)rect tag:(NSInteger)tag;

/**
 UILabel通用创建方法
 */
+ (UILabel *)createLabelWithRect:(CGRect)rect text:(id)text textColor:(UIColor *)textColor tag:(NSInteger)tag patternType:(NSString *)patternType font:(CGFloat)fontSize  backgroudColor:(UIColor *)backgroudColor alignment:(NSTextAlignment)alignment;

/**
 UILabel小标志专用,例如左侧头像上的"企"
 */
+ (UILabel *)createTipLabelWithSize:(CGSize)size tipCenter:(CGPoint)tipCenter text:(NSString *)text textColor:(UIColor *)textColor tag:(NSInteger)tag font:(CGFloat)fontSize backgroudColor:(UIColor *)backgroudColor alignment:(NSTextAlignment)alignment;

/**
 UIImageView通用创建方法
 */
+ (UIImageView *)createImgViewWithRect:(CGRect)rect image:(id)image tag:(NSInteger)tag patternType:(NSString *)patternType;

/**
 UIImageView多图片加手势
 */
+ (UIImageView *)createImageViewRect:(CGRect)rect image:(id)image tag:(NSInteger)tag target:(id)target aSelector:(SEL)aSelector;

/**
 UIImageView(上传图片)选择图片使用
 */
+ (UIImageView *)createImgViewWithRect:(CGRect)rect image:(id)image tag:(NSInteger)tag patternType:(NSString *)patternType hasDeleteBtn:(BOOL)hasDeleteBtn;

/**
 UITextField通用创建方法
 */
+ (UITextField *)createTextFieldWithRect:(CGRect)rect text:(NSString *)text placeholder:(NSString *)placeholder font:(CGFloat)fontSize textAlignment:(NSTextAlignment)textAlignment keyboardType:(UIKeyboardType)keyboardType tag:(NSInteger)tag;

/**
 UIButton通用创建方法
 */
+ (UIButton *)createBtnWithRect:(CGRect)rect title:(NSString *)title font:(CGFloat)fontSize image:(NSString *)image tag:(NSInteger)tag patternType:(NSString *)patternType target:(id)target aSelector:(SEL)aSelector;

/**
 CustomSegment通用创建方法
 */
+ (UIView *)createCustomSegmentWithTitleArr:(NSArray *)titleArr rect:(CGRect)rect tag:(NSInteger)tag selectedIndex:(NSInteger)selectedIndex font:(CGFloat)fontSize isBottom:(BOOL)isBottom;

/**
 BtnView通用创建方法
 */
+ (UIView *)createBtnViewWithRect:(CGRect)rect imgName:(NSString *)imgName imgHeight:(CGFloat)imgHeight title:(NSString *)title titleColor:(UIColor *)titleColor patternType:(NSString *)patternType;

/**
 UISegmentedControl通用创建方法
 */
+ (UISegmentedControl *)createSegmentWithRect:(CGRect)rect titles:(NSArray *)titleArr textColor:(UIColor *)textColor backgroudColor:(UIColor *)backgroudColor selectedIndex:(NSInteger)selectedIndex tagert:(id)target aSelector:(SEL)aSelector;

/**
 UISwitch通用创建方法
 */
+ (UISwitch *)createSwitchWithRect:(CGRect)rect isOn:(BOOL)isOn;

/**
 UISegmentedControl通用创建方法(无边框)
 */
+ (UISegmentedControl *)createSegmentCtlWithRect:(CGRect)rect items:(NSArray *)items selectedIndex:(NSInteger)selectedIndex type:(NSString *)type;

@end
