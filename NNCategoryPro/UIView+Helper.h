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

//typedef void(^BlockView)(UIView *view,id item, id obj);

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Helper)

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

///辅助属性
@property (nonatomic, assign) BOOL selected;

- (UITapGestureRecognizer *)addGestureTap:(void(^)(UITapGestureRecognizer *reco))block;

- (UILongPressGestureRecognizer *)addGestureLongPress:(void(^)(UILongPressGestureRecognizer *reco))block forDuration:(NSTimeInterval)minimumPressDuration;

- (UIPanGestureRecognizer *)addGesturePan:(void(^)(UIPanGestureRecognizer *reco))block;

- (UIScreenEdgePanGestureRecognizer *)addGestureEdgPan:(void(^)(UIScreenEdgePanGestureRecognizer *reco))block forEdges:(UIRectEdge)edges;

- (UISwipeGestureRecognizer *)addGestureSwipe:(void(^)(UISwipeGestureRecognizer *reco))block forDirection:(UISwipeGestureRecognizerDirection)direction;

- (UIPinchGestureRecognizer *)addGesturePinch:(void(^)(UIPinchGestureRecognizer *reco))block;

- (UIRotationGestureRecognizer *)addGestureRotation:(void(^)(UIRotationGestureRecognizer *reco))block;

+ (void)getSub:(UIView *)view andLevel:(NSInteger)level;

- (void)getViewLayer;

- (__kindof UIView *)findSubview:(NSString *)name resursion:(BOOL)resursion;

- (NSArray<__kindof UIView *> *)findSubviewType:(Class)cls;

- (NSArray<__kindof UIView *> *)findSubview:(NSString *)name;

- (__kindof UIView *)findSuperViewType:(Class)cls;

- (__kindof UIView *)findSuperView:(NSString *)name;

- (void)removeAllSubViews;

- (NSArray<__kindof UIView *> *)updateItems:(NSInteger)count aClassName:(NSString *)aClassName handler:(void(^)(__kindof UIView *obj))handler;

- (NSArray<__kindof UIButton *> *)updateButtonItems:(NSInteger)count aClassName:(NSString *)aClassName handler:(void(^)(__kindof UIButton *obj))handler;

- (void)animationCycle:(void(^)(CGAffineTransform))transform animated:(BOOL)animated completion:(void (^ __nullable)(BOOL finished))completion;
    
+ (UIView *)createSectionView:(UITableView *)tableView
                         text:(NSString *)text
                textAlignment:(NSTextAlignment)textAlignment
                       height:(CGFloat)height;

/**
 上传证件类VIew
 */
+ (UIImageView *)createCardViewRect:(CGRect)rect
                              title:(NSString *)title
                             target:(id)target
                          aSelector:(SEL)aSelector;

///密集子元素尺寸
+ (UIView *)createViewRect:(CGRect)rect
                  elements:(NSArray *)elements
               numberOfRow:(NSInteger)numberOfRow
                viewHeight:(CGFloat)viewHeight
                   padding:(CGFloat)padding;

+ (UIView *)createViewRect:(CGRect)rect
                     items:(NSArray *)items
               numberOfRow:(NSInteger)numberOfRow
                itemHeight:(CGFloat)itemHeight
                   padding:(CGFloat)padding
                   handler:(void(^)(UIButton *sender))handler;

/**
 向屏幕倾斜
 */
+ (void)transformStateEventWithView:(UIView *)view;

/**
 圆角
 */
+ (void)setCutCirculayWithView:(UIImageView *)view cornerRadius:(CGFloat)cornerRadius type:(NSNumber *)type;

/**
 毛玻璃背景
 @param effect UIBlurEffectStyle
 @param view 控件父视图
 @return 返回毛玻璃效果的视图
 tips:不要在UIVisuaEffectView实例化View上面直接添加subViews，应该将需要添加的子视图添加到其contentView上。同时，尽量避免将UIVisualEffectView对象的alpha值设置为小于1.0的值，因为创建半透明的视图会导致系统在离屏渲染时去对UIVisualEffectView对象及所有的相关的子视图做混合操作,比较消耗性能。
 */
+ (UIVisualEffectView *)createBlurViewEffect:(UIBlurEffectStyle)effect subView:(UIView *)view;

- (void)addCircleLayerColor:(UIColor *)layColor layerWidth:(CGFloat)layerWidth;

//- (NSIndexPath *)getCellIndexPath:(UITableView *)tableView;

//信任值展示,无点击手势
//+ (id)getStarViewRect:(CGRect)rect rateStyle:(NSString *)rateStyle currentScore:(CGFloat)currentScore;

@end

NS_ASSUME_NONNULL_END
