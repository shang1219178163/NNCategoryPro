//
//  UIView+Helper.h
//  
//
//  Created by BIN on 2017/8/15.
//  Copyright © 2017年 SHANG. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UIColor+Helper.h"
#import "UIView+AddView.h"

@class BN_TextField;

typedef void(^BlockView)(UIView * view,id item, id obj);

@interface UIView (Helper)

//与自动布局类库属性重名冲突,废弃
//@property (nonatomic, assign) CGFloat x;
//@property (nonatomic, assign) CGFloat y;
//@property (nonatomic, assign) CGFloat width;
//@property (nonatomic, assign) CGFloat height;

@property (nonatomic, assign) CGFloat originX;
@property (nonatomic, assign) CGFloat originY;
@property (nonatomic, assign) CGFloat sizeWidth;
@property (nonatomic, assign) CGFloat sizeHeight;

@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGSize size;

@property (nonatomic, assign, readonly) CGFloat minX;
@property (nonatomic, assign, readonly) CGFloat midX;
@property (nonatomic, assign, readonly) CGFloat maxX;

@property (nonatomic, assign, readonly) CGFloat minY;
@property (nonatomic, assign, readonly) CGFloat midY;
@property (nonatomic, assign, readonly) CGFloat maxY;


@property (nonatomic, copy)BlockView blockView;

//@property (nonatomic, assign, getter=isSelected) BOOL selected;
@property (nonatomic, assign) BOOL selected;

@property (nonatomic, strong, readonly) UIViewController * parController;

- (UIView *)addCorners:(UIRectCorner)corners cornerRadii:(CGSize)cornerRadii width:(CGFloat)width color:(UIColor *)color;

- (UIView *)addCorners:(UIRectCorner)corners cornerRadii:(CGSize)cornerRadii;

- (UIView *)addCorners:(UIRectCorner)corners width:(CGFloat)width color:(UIColor *)color;

- (UIView *)addCornersAll;


- (UITapGestureRecognizer *)addGestureTap:(void(^)(UIGestureRecognizer * sender))block;

- (UILongPressGestureRecognizer *)addGestureLongPress:(void(^)(UIGestureRecognizer * sender))block forDuration:(NSTimeInterval)minimumPressDuration;

- (UIPanGestureRecognizer *)addGesturePan:(void(^)(UIGestureRecognizer * sender))block;

- (UIScreenEdgePanGestureRecognizer *)addGestureEdgPan:(void(^)(UIGestureRecognizer * sender))block forEdges:(UIRectEdge)edges;

- (UISwipeGestureRecognizer *)addGestureSwipe:(void(^)(UIGestureRecognizer * sender))block forDirection:(UISwipeGestureRecognizerDirection)direction;

- (UIPinchGestureRecognizer *)addGesturePinch:(void(^)(UIGestureRecognizer * sender))block;

- (UIRotationGestureRecognizer *)addGestureRotation:(void(^)(UIGestureRecognizer * sender))block;

- (void)addActionHandler:(void(^)(id obj, id item, NSInteger idx))handler;

+ (id)getControl:(NSString *)control view:(UIView *)view;


+ (void)getSub:(UIView *)view andLevel:(NSInteger)level;

- (void)getViewLayer;

- (void)showLayerColor:(UIColor *)layerColor;

/**
 上传证件类VIew
 */
+ (UIImageView *)createCardViewRect:(CGRect)rect title:(NSString *)title image:(id)image tag:(NSInteger)tag target:(id)target aSelector:(SEL)aSelector;
//+ (UIView *)createCardViewRect:(CGRect)rect title:(NSString *)title image:(NSString *)image tag:(NSInteger)tag;

/**
 BN_TextField创建方法
 */
+ (BN_TextField *)createTextFieldRect:(CGRect)rect text:(NSString *)text placeholder:(NSString *)placeholder font:(NSInteger)fontSize textAlignment:(NSTextAlignment)textAlignment keyboardType:(UIKeyboardType)keyboardType;

/**
 搜索框
 */
+ (BN_TextField *)createTextFieldRect:(CGRect)rect text:(NSString *)text placeholder:(NSString *)placeholder font:(NSInteger)fontSize textAlignment:(NSTextAlignment)textAlignment keyboardType:(UIKeyboardType)keyboardType leftView:(UIView *)leftView leftPadding:(CGFloat)leftPadding rightView:(UIView *)rightView rightPadding:(CGFloat)rightPadding;


/**
 带提示的textView
 */
+ (UITextView *)createTextViewRect:(CGRect)rect text:(NSString *)text placeholder:(NSString *)placeholder font:(CGFloat)fontSize textAlignment:(NSTextAlignment)textAlignment keyType:(UIKeyboardType)keyboardType;

/**
 展示性质的textView,不提供编辑
 */
+ (UITextView *)createTextShowRect:(CGRect)rect text:(id)text font:(CGFloat)fontSize textAlignment:(NSTextAlignment)textAlignment;

/**
 富文本
 */
+ (UILabel *)createRichLabRect:(CGRect)rect text:(NSString *)text textTaps:(NSArray *)textTaps;


/**
 图片+文字
 */
+ (UIView *)getImgLabViewRect:(CGRect)rect image:(id)image text:(id)text imgViewSize:(CGSize)imgViewSize tag:(NSInteger)tag;

/**
 信任值展示,无点击手势
 默认五颗星星
 */
+ (id)getStarViewRect:(CGRect)rect rateStyle:(NSString *)rateStyle currentScore:(CGFloat)currentScore;

+ (UIView *)createViewRect:(CGRect)rect elements:(NSArray *)elements numberOfRow:(NSInteger)numberOfRow viewHeight:(CGFloat)viewHeight padding:(CGFloat)padding;

+ (UIView *)createViewRect:(CGRect)rect items:(NSArray *)items numberOfRow:(NSInteger)numberOfRow itemHeight:(CGFloat)itemHeight padding:(CGFloat)padding type:(NSNumber *)type handler:(void(^)(id obj, id item, NSInteger idx))handler;

/**
 向屏幕倾斜
 */
+ (void)transformStateEventWithView:(UIView *)view;

/**
 圆角
 */
+ (void)setCutCirculayWithView:(UIImageView *)view cornerRadius:(CGFloat )cornerRadius type:(NSNumber *)type;


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

- (id)asoryView:(NSString *)unitString;

//信任值展示,无点击手势
//+ (id)getStarViewRect:(CGRect)rect rateStyle:(NSString *)rateStyle currentScore:(CGFloat)currentScore;

@end
