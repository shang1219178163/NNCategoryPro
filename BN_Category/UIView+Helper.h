//
//  UIView+Helper.h
//  HuiZhuBang
//
//  Created by BIN on 2017/8/15.
//  Copyright © 2017年 WeiHouKeJi. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UIColor+Helper.h"
#import "UIView+AddView.h"

@class BN_TextField,BN_TextView;

typedef void(^BlockView)(UIView * view,id item, id obj);

@interface UIView (Helper)

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;

@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGSize size;

@property (nonatomic, assign, readonly) CGFloat top;
@property (nonatomic, assign, readonly) CGFloat left;
@property (nonatomic, assign, readonly) CGFloat bottom;
@property (nonatomic, assign, readonly) CGFloat right;

@property (nonatomic, copy)BlockView blockView;

//@property (nonatomic, assign, getter=isSelected) BOOL selected;
@property (nonatomic, assign) BOOL selected;

@property (nonatomic, strong, readonly) UIViewController * parController;

- (UIView *)addCorners:(UIRectCorner)corners cornerRadii:(CGSize)cornerRadii width:(CGFloat)width color:(UIColor *)color;

- (UIView *)addCorners:(UIRectCorner)corners cornerRadii:(CGSize)cornerRadii;

- (UIView *)addCorners:(UIRectCorner)corners width:(CGFloat)width color:(UIColor *)color;

- (UIView *)addCornersAll;

/**
 添加各种手势
 @param type 手势类型
 @return view
 */
- (UIView *)addRecognizerWithTarget:(id)target
                          aSelector:(SEL)aSelector
                               type:(NSString *)type;


/**
 给view关联点击事件(支持UIView和UIButton可继续扩展其他支持)
 @param handler 返回响应对象
 */
- (void)addActionHandler:(void(^)(id obj, id item, NSInteger idx))handler;

/**
 寻找特定类型控件
 */
+ (id)getControl:(NSString *)control view:(UIView *)view;

/**
 获取所有子视图
 */
+ (void)getSub:(UIView *)view andLevel:(NSInteger)level;

/**
 给所有自视图加框
 */
- (void)getViewLayer;

/**
 (弃用)显示textfield边框
 */
- (void)showLayer;

- (void)showLayerColor:(UIColor *)layerColor;

/**
 上传证件类VIew
 */
+ (UIImageView *)createCardViewWithRect:(CGRect)rect title:(NSString *)title image:(id)image tag:(NSInteger)tag target:(id)target aSelector:(SEL)aSelector;
//+ (UIView *)createCardViewWithRect:(CGRect)rect title:(NSString *)title image:(NSString *)image tag:(NSInteger)tag;

/**
 BN_TextField创建方法
 */
+ (BN_TextField *)createTextFieldWithRect:(CGRect)rect text:(NSString *)text placeholder:(NSString *)placeholder font:(NSInteger)fontSize textAlignment:(NSTextAlignment)textAlignment keyboardType:(UIKeyboardType)keyboardType;

/**
 搜索框
 */
+ (BN_TextField *)createTextFieldWithRect:(CGRect)rect text:(NSString *)text placeholder:(NSString *)placeholder font:(NSInteger)fontSize textAlignment:(NSTextAlignment)textAlignment keyboardType:(UIKeyboardType)keyboardType leftView:(UIView *)leftView leftPadding:(CGFloat)leftPadding rightView:(UIView *)rightView rightPadding:(CGFloat)rightPadding;


/**
 带提示的textView
 */
+ (BN_TextView *)createTextViewWithRect:(CGRect)rect text:(NSString *)text placeholder:(NSString *)placeholder font:(CGFloat)fontSize textAlignment:(NSTextAlignment)textAlignment keyType:(UIKeyboardType)keyboardType;

/**
 展示性质的textView,不提供编辑
 */
+ (UITextView *)createTextShowWithRect:(CGRect)rect text:(id)text font:(CGFloat)fontSize textAlignment:(NSTextAlignment)textAlignment;

/**
 富文本
 */
+ (UILabel *)createRichLabWithRect:(CGRect)rect text:(NSString *)text textTaps:(NSArray *)textTaps;


/**
 图片+文字
 */
+ (UIView *)getImgLabViewRect:(CGRect)rect image:(id)image text:(id)text imgViewSize:(CGSize)imgViewSize tag:(NSInteger)tag;

/**
 信任值展示,无点击手势
 默认五颗星星
 */
+ (id)getStarViewRect:(CGRect)rect rateStyle:(NSString *)rateStyle currentScore:(CGFloat)currentScore;

+ (UIView *)createViewWithRect:(CGRect)rect elements:(NSArray *)elements numberOfRow:(NSInteger)numberOfRow viewHeight:(CGFloat)viewHeight padding:(CGFloat)padding;

+ (UIView *)createViewWithRect:(CGRect)rect items:(NSArray *)items numberOfRow:(NSInteger)numberOfRow itemHeight:(CGFloat)itemHeight padding:(CGFloat)padding type:(NSNumber *)type handler:(void(^)(id obj, id item, NSInteger idx))handler;

/**
 弃用
 */
- (void)setOriginX:(CGFloat)originX;
/**
 弃用
 */
- (void)setOriginY:(CGFloat)originY;
/**
 弃用
 */
- (void)setHeight:(CGFloat)height originY:(CGFloat)originY;

/**
 向屏幕倾斜
 */
+ (void)transformStateEventWithView:(UIView *)view;

/**
 圆角
 */
+ (void)setCutCirculayWithView:(UIImageView *)view cornerRadius:(CGFloat )cornerRadius patternType:(NSString *)patternType;


//- (void)tapActionWithView:(void (^) (UIView * view))tapClick;
//- (void)tapView:(UIView* )view tapClick:(void (^) (UIView *View))tapClick;


/**
 毛玻璃背景

 @param effect UIBlurEffectStyle
 @param view 控件父视图
 @return 返回毛玻璃效果的视图
 
 tips:不要在UIVisuaEffectView实例化View上面直接添加subViews，应该将需要添加的子视图添加到其contentView上。同时，尽量避免将UIVisualEffectView对象的alpha值设置为小于1.0的值，因为创建半透明的视图会导致系统在离屏渲染时去对UIVisualEffectView对象及所有的相关的子视图做混合操作,比较消耗性能。
 */
+ (UIVisualEffectView *)createBlurViewEffect:(UIBlurEffectStyle)effect subView:(UIView *)view;

- (void)addCircleLayerColor:(UIColor *)layColor layerWidth:(CGFloat)layerWidth;

- (void)removeAllSubViews;

- (NSIndexPath *)getCellIndexPathByTableView:(UITableView *)tableView;

- (UITableViewCell *)getClickViewCell;

//信任值展示,无点击手势
//+ (id)getStarViewRect:(CGRect)rect rateStyle:(NSString *)rateStyle currentScore:(CGFloat)currentScore;

@end
