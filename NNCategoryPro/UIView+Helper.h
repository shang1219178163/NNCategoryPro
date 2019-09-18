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

@class NNTextField;

typedef void(^BlockView)(UIView * view,id item, id obj);

NS_ASSUME_NONNULL_BEGIN

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
/// text是否有效
@property (nonatomic, assign, readonly) BOOL validText;

- (UIView *)addCorners:(UIRectCorner)corners cornerRadii:(CGSize)cornerRadii width:(CGFloat)width color:(UIColor *)color;

- (UIImage *)drawCorners:(UIRectCorner)corners
             cornerRadii:(CGFloat)radius
             borderWidth:(CGFloat)borderWidth
             borderColor:(UIColor *)borderColor
                 bgColor:(UIColor*)bgColor;
    
- (UIView *)addCorners:(UIRectCorner)corners cornerRadii:(CGSize)cornerRadii;

- (UIView *)addCorners:(UIRectCorner)corners width:(CGFloat)width color:(UIColor *)color;

- (UIView *)addCornersAll;


- (UITapGestureRecognizer *)addGestureTap:(void(^)(UIGestureRecognizer *reco))block;

- (UILongPressGestureRecognizer *)addGestureLongPress:(void(^)(UIGestureRecognizer *reco))block forDuration:(NSTimeInterval)minimumPressDuration;

- (UIPanGestureRecognizer *)addGesturePan:(void(^)(UIGestureRecognizer *reco))block;

- (UIScreenEdgePanGestureRecognizer *)addGestureEdgPan:(void(^)(UIGestureRecognizer *reco))block forEdges:(UIRectEdge)edges;

- (UISwipeGestureRecognizer *)addGestureSwipe:(void(^)(UIGestureRecognizer *reco))block forDirection:(UISwipeGestureRecognizerDirection)direction;

- (UIPinchGestureRecognizer *)addGesturePinch:(void(^)(UIGestureRecognizer *reco))block;

- (UIRotationGestureRecognizer *)addGestureRotation:(void(^)(UIGestureRecognizer *reco))block;

- (void)addActionHandler:(void(^)(id obj, id item, NSInteger idx))handler;

+ (id)getControl:(NSString *)control view:(UIView *)view;

+ (void)getSub:(UIView *)view andLevel:(NSInteger)level;

- (void)getViewLayer;

- (void)showLayerColor:(UIColor *)layerColor;

- (void)imageToSavedPhotosAlbum:(void(^)(NSError *error))block;

+ (UIView *)createSectionView:(UITableView *)tableView text:(NSString *)text textAlignment:(NSTextAlignment)textAlignment height:(CGFloat)height;

/**
 上传证件类VIew
 */
+ (UIImageView *)createCardViewRect:(CGRect)rect title:(NSString *)title image:(id)image tag:(NSInteger)tag target:(id)target aSelector:(SEL)aSelector;

/**
 搜索框
 */
+ (NNTextField *)createTextFieldRect:(CGRect)rect placeholder:(NSString *)placeholder leftView:(UIView *)leftView leftPadding:(CGFloat)leftPadding rightView:(UIView *)rightView rightPadding:(CGFloat)rightPadding;

/**
 [简]搜索框
 */
+ (NNTextField *)createTextFieldRect:(CGRect)rect placeholder:(NSString *)placeholder leftView:(UIView *)leftView rightView:(UIView *)rightView;

/**
 信任值展示,无点击手势
 默认五颗星星
 */
//+ (id)getStarViewRect:(CGRect)rect rateStyle:(NSString *)rateStyle currentScore:(CGFloat)currentScore;
/// 获取密集子视图的总高度
+ (CGFloat)UIGroupViewHeight:(NSInteger)count numberOfRow:(NSInteger)numberOfRow padding:(CGFloat)padding itemHeight:(CGFloat)itemHeight;

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

- (NSIndexPath *)getCellIndexPath:(UITableView *)tableView;

- (UITableViewCell *)getClickViewCell;

- (id)asoryView:(NSString *)unitString;

//信任值展示,无点击手势
//+ (id)getStarViewRect:(CGRect)rect rateStyle:(NSString *)rateStyle currentScore:(CGFloat)currentScore;

@end

NS_ASSUME_NONNULL_END
