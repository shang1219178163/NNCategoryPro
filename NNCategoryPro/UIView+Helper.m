//
//  UIView+Helper.m
//  
//
//  Created by BIN on 2017/8/15.
//  Copyright © 2017年 SHANG. All rights reserved.
//

#import "UIView+Helper.h"
#import <objc/runtime.h>

#import <NNGloble/NNGloble.h>
#import "NSObject+Helper.h"
#import "NSBundle+Helper.h"
#import "NSArray+Helper.h"

#import "UIButton+Helper.h"
#import "UIControl+Helper.h"
#import "UIImageView+Helper.h"
#import "UILabel+Helper.h"
#import "UIGestureRecognizer+Helper.h"
#import "UITextField+Helper.h"
#import "UITextView+Helper.h"
#import "UIView+AddView.h"

@implementation UIView (Helper)

- (CGFloat)originX{
    return CGRectGetMinX(self.frame);
}

- (void)setOriginX:(CGFloat)originX{
    CGRect rect = self.frame;
    rect.origin.x = originX;
    self.frame = rect;
}

- (CGFloat)originY{
    return CGRectGetMinY(self.frame);
}

- (void)setOriginY:(CGFloat)originY{
    CGRect rect = self.frame;
    rect.origin.y = originY;
    self.frame = rect;
}

- (CGFloat)sizeWidth{
    return CGRectGetWidth(self.frame);
}

- (void)setSizeWidth:(CGFloat)sizeWidth{
    CGRect rect = self.frame;
    rect.size.width = sizeWidth;
    self.frame = rect;
}

- (CGFloat)sizeHeight{
    return CGRectGetHeight(self.frame);
}

- (void)setSizeHeight:(CGFloat)sizeHeight{
    CGRect rect = self.frame;
    rect.size.height = sizeHeight;
    self.frame = rect;
}

- (CGPoint)origin{
    return self.frame.origin;
}

- (void)setOrigin:(CGPoint)origin{
    CGRect rect = self.frame;
    rect.origin = origin;
    self.frame = rect;
}

- (CGSize)size{
    return self.frame.size;
}

- (void)setSize:(CGSize)size{
    CGRect rect = self.frame;
    rect.size = size;
    self.frame = rect;
}

- (CGFloat)minX{
    return CGRectGetMinX(self.frame);
}

- (CGFloat)midX{
    return CGRectGetMidX(self.frame);
}

- (CGFloat)maxX{
    return CGRectGetMaxX(self.frame);
}

- (CGFloat)minY{
    return CGRectGetMinY(self.frame);
}

- (CGFloat)midY{
    return CGRectGetMidY(self.frame);
}

- (CGFloat)maxY{
    return CGRectGetMaxY(self.frame);
}

- (BOOL)selected{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setSelected:(BOOL)selected{
    objc_setAssociatedObject(self, @selector(selected), @(selected), OBJC_ASSOCIATION_ASSIGN);
}


#pragma mak - -Recognizer
/**
 手势 - 单指点击
 */
- (UITapGestureRecognizer *)addGestureTap:(void(^)(UITapGestureRecognizer *reco))block{
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:nil action:nil];
    recognizer.numberOfTapsRequired = 1;
    recognizer.numberOfTouchesRequired = 1;
//        recognizer.cancelsTouchesInView = false;
//        recognizer.delaysTouchesEnded = false;
    self.userInteractionEnabled = true;
    self.multipleTouchEnabled = true;
    [self addGestureRecognizer:recognizer];

    [recognizer addActionBlock:block];
    return recognizer;
}

/**
 手势 - 长按
 */
- (UILongPressGestureRecognizer *)addGestureLongPress:(void(^)(UILongPressGestureRecognizer *reco))block forDuration:(NSTimeInterval)minimumPressDuration{
    UILongPressGestureRecognizer *recognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:nil action:nil];
    recognizer.minimumPressDuration = minimumPressDuration;
    self.userInteractionEnabled = true;
    self.multipleTouchEnabled = true;
    [self addGestureRecognizer:recognizer];
    
    [recognizer addActionBlock:block];
    return recognizer;
}

/**
 手势 - 拖动
 */
- (UIPanGestureRecognizer *)addGesturePan:(void(^)(UIPanGestureRecognizer *reco))block{
    UIPanGestureRecognizer *recognizer = [[UIPanGestureRecognizer alloc] initWithTarget:nil action:nil];
    recognizer.minimumNumberOfTouches = 1;
    recognizer.maximumNumberOfTouches = 3;
    self.userInteractionEnabled = true;
    self.multipleTouchEnabled = true;
    [self addGestureRecognizer:recognizer];

    [recognizer addActionBlock:block];
    return recognizer;
}

/**
 手势 - 边缘拖动
 */
- (UIScreenEdgePanGestureRecognizer *)addGestureEdgPan:(void(^)(UIScreenEdgePanGestureRecognizer *reco))block forEdges:(UIRectEdge)edges{
    UIScreenEdgePanGestureRecognizer *recognizer = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:nil action:nil];
    recognizer.edges = edges;
    self.userInteractionEnabled = true;
    self.multipleTouchEnabled = true;
    [self addGestureRecognizer:recognizer];
    
    [recognizer addActionBlock:block];
    return recognizer;
}

/**
 手势 - 轻扫
 */
- (UISwipeGestureRecognizer *)addGestureSwipe:(void(^)(UISwipeGestureRecognizer *reco))block forDirection:(UISwipeGestureRecognizerDirection)direction{
    UISwipeGestureRecognizer *recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:nil action:nil];
    recognizer.direction = direction;
    self.userInteractionEnabled = true;
    self.multipleTouchEnabled = true;
    [self addGestureRecognizer:recognizer];

    [recognizer addActionBlock:block];
    return recognizer;
}

/**
 手势 - 捏合
 */
- (UIPinchGestureRecognizer *)addGesturePinch:(void(^)(UIPinchGestureRecognizer *reco))block{
    UIPinchGestureRecognizer *recognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:nil action:nil];
//        recognizer.scale = 1.0;
    self.userInteractionEnabled = true;
    self.multipleTouchEnabled = true;
    [self addGestureRecognizer:recognizer];

    [recognizer addActionBlock:block];
    return recognizer;
}

/**
 手势 - 旋转
 */
- (UIRotationGestureRecognizer *)addGestureRotation:(void(^)(UIRotationGestureRecognizer *reco))block{
    UIRotationGestureRecognizer *recognizer = [[UIRotationGestureRecognizer alloc] initWithTarget:nil action:nil];
    self.userInteractionEnabled = true;
    self.multipleTouchEnabled = true;
    [self addGestureRecognizer:recognizer];

    [recognizer addActionBlock:block];
    return recognizer;
}

#pragma mak -funtions

/**
 获取所有子视图(需要注意的是，我的level设置是从1开始的，这与方法中加空格时变量 i 起始的值是相呼应的，要改就要都改。)
 */
+ (void)getSub:(UIView *)view andLevel:(NSInteger)level {
    NSArray *subviews = [view subviews];
    if ([subviews count] == 0) return;
    for (UIView *subview in subviews) {
        
        NSString *blank = @"";
        for (NSInteger i = 1; i < level; i++) {
            blank = [NSString stringWithFormat:@"  %@", blank];
        }
        NSLog(@"%@%ld: %@", blank, (long)level, subview.class);
        [self getSub:subview andLevel:(level+1)];
        
    }
}

/**
 给所有自视图加框
 */
- (void)getViewLayer{
    NSArray *subviews = self.subviews;
    if (subviews.count == 0) return;
    for (UIView *subview in subviews) {
        subview.layer.borderWidth = kW_LayerBorder;
        
        #if DEBUG
        subview.layer.borderColor = UIColor.blueColor.CGColor;
        #else
        subview.layer.borderColor = UIColor.clearColor.CGColor;
        #endif
        [subview getViewLayer];
    }
}

- (__kindof UIView *)findSubview:(NSString *)name resursion:(BOOL)resursion{
    Class class = NSClassFromString(name);
    for (UIView *subview in self.subviews) {
        if ([subview isKindOfClass: class]) {
            return subview;
        }
    }
    
    if (resursion) {
        for (UIView *subview in self.subviews) {
            UIView *tempView = [subview findSubview:name resursion:resursion];
            if (tempView) {
                return tempView;
            }
        }
    }
    return nil;
}


- (NSArray<__kindof UIView *> *)findSubviewType:(Class)cls{
    NSMutableArray *marr = [NSMutableArray array];
    for (UIView *view in self.subviews){
        if ([view isKindOfClass: cls]){
            [marr addObject:view];
        }
    }
    return marr.copy;
}

- (NSArray<__kindof UIView *> *)findSubview:(NSString *)name{
    Class class = NSClassFromString(name);
    return [self findSubviewType:class];
}

- (__kindof UIView *)findSuperViewType:(Class)cls{
    UIView *supView = self.superview;
    while (![supView isKindOfClass: cls]) {
        supView = supView.superview;
    }
    return supView;
}

- (__kindof UIView *)findSuperView:(NSString *)name{
    Class class = NSClassFromString(name);
    return [self findSuperViewType:class];
}

/**
 移除所有子视图
 */
- (void)removeAllSubViews{
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
}

- (NSArray<__kindof UIView *> *)updateItems:(NSInteger)count aClassName:(NSString *)aClassName handler:(void(^)(__kindof UIView *obj))handler {
    if (count == 0) {
        return @[];
    }
    Class cls = NSClassFromString(aClassName);
    NSArray *list = [self.subviews filter:^BOOL(UIView * obj, NSUInteger idx) {
        return [obj isMemberOfClass:cls.class];
    }];
    
    if (list.count == count) {
        [list enumerateObjectsUsingBlock:^(UIView * obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (handler) {
                handler(obj);
            }
        }];
        return list;
    }
    
    for (UIView *view in self.subviews) {
        if ([view isMemberOfClass:cls]) {
            [view removeFromSuperview];
        }
    }
    NSMutableArray *marr = [NSMutableArray array];
    for (NSInteger i = 0; i < count; i++) {
        UIView *subview = [[cls alloc]init];
        subview.tag = i;
        
        [self addSubview:subview];
        [marr addObject:subview];
        if (handler) {
            handler(subview);
        }
    }
    return marr;
}

- (NSArray<__kindof UIButton *> *)updateButtonItems:(NSInteger)count aClassName:(NSString *)aClassName handler:(void(^)(__kindof UIButton *obj))handler {
    return [self updateItems:count aClassName:aClassName handler:^(__kindof UIView * _Nonnull obj) {
        if (![obj isKindOfClass:UIButton.class]) {
            return;
        }
//        NSString *clsName = NSStringFromClass(obj.class);
        UIButton *sender = (UIButton *)obj;
        if (![sender titleForState:UIControlStateNormal]) {
            sender.titleLabel.font = [UIFont systemFontOfSize:15];
            NSString *title = [NSString stringWithFormat:@"%@%@", aClassName, @(obj.tag)];
            [sender setTitle:title forState:UIControlStateNormal];
            [sender setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        }
        if (handler) {
            handler(obj);
        }
    }];
}

/// [源] 往返旋转图像
- (void)animationCycle:(void(^)(CGAffineTransform))transform animated:(BOOL)animated completion:(void (^ __nullable)(BOOL finished))completion{
    CGFloat duration = animated ? 0.3 : 0;
    [UIView animateWithDuration:duration animations:^{
        if (CGAffineTransformIsIdentity(self.transform) == true) {
            transform(self.transform);
        } else {
            self.transform = CGAffineTransformIdentity;
        }
    } completion:completion];
}

+ (UIView *)createSectionView:(UITableView *)tableView
                         text:(NSString *)text
                textAlignment:(NSTextAlignment)textAlignment
                       height:(CGFloat)height{
    UIView *sectionView = [[UIView alloc]init];
    if (!text) {
        return sectionView;
    }
    
    CGRect rect = CGRectMake(kX_GAP, 0, CGRectGetWidth(tableView.frame) - kX_GAP*2, height);
    UILabel *view = [[UILabel alloc] initWithFrame:rect];
    view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    view.font = [UIFont systemFontOfSize:16];
    view.userInteractionEnabled = true;
    view.lineBreakMode = NSLineBreakByTruncatingTail;
    view.adjustsFontSizeToFitWidth = YES;
//        label.backgroundColor = UIColor.greenColor;
    view.text = text;
    view.textAlignment = textAlignment;

    [sectionView addSubview:view];
    return sectionView;
}


+ (UIImageView *)createCardViewRect:(CGRect)rect
                              title:(NSString *)title
                             target:(id)target
                          aSelector:(SEL)aSelector{
    
    UIImageView *containView = [UIImageView createRect:rect];
    CGSize imgViewSize = CGSizeMake(kH_LABEL_SMALL, kH_LABEL_SMALL);
    CGFloat YGap = (CGRectGetHeight(rect) - imgViewSize.height*2)/2.0;
    CGFloat XGapImgView = (CGRectGetWidth(rect) - imgViewSize.width)/2.0;
    
    CGRect imgViewRect = CGRectMake(XGapImgView, YGap, imgViewSize.width, imgViewSize.height);
    UIImageView * imgView = [UIImageView createRect:imgViewRect];
    imgView.image = [UIImage imageNamed:@"img_cardAdd.png"];
    imgView.layer.backgroundColor = UIColor.whiteColor.CGColor;
    [containView addSubview:imgView];
    
    CGSize textSize = [self sizeWithText:title font:@(kFontSize14) width:CGRectGetWidth(rect)];
    CGFloat XGapLab = (CGRectGetWidth(rect) - textSize.width)/2.0;
    
    CGRect labRect = CGRectMake(XGapLab, CGRectGetMaxY(imgViewRect), textSize.width, kH_LABEL_SMALL);
    UILabel *lab = [UILabel createRect:labRect type:NNLabelTypeFitWidth];
    lab.text = title;
    lab.tag = kTAG_LABEL;
    
    lab.textColor = UIColor.titleColor9;
    lab.font = [UIFont systemFontOfSize:kFontSize14];
    lab.textAlignment = NSTextAlignmentCenter;
    [containView addSubview:lab];
    
    return containView;
}

+ (UIView *)createViewRect:(CGRect)rect
                  elements:(NSArray *)elements
               numberOfRow:(NSInteger)numberOfRow
                viewHeight:(CGFloat)viewHeight
                   padding:(CGFloat)padding{
    NSInteger rowCount = elements.count % numberOfRow == 0 ? elements.count/numberOfRow : elements.count/numberOfRow + 1;
    //
    UIView *backgroudView = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMinX(rect),
                                                                    CGRectGetMinY(rect),
                                                                    CGRectGetWidth(rect),
                                                                    rowCount * viewHeight + (rowCount - 1) * padding)];
    backgroudView.backgroundColor = UIColor.greenColor;
    
    CGSize viewSize = CGSizeMake((CGRectGetWidth(backgroudView.frame) - (numberOfRow-1)*padding)/numberOfRow, viewHeight);
    for (NSInteger i = 0; i< elements.count; i++) {
        
        CGFloat w = viewSize.width;
        CGFloat h = viewSize.height;
        CGFloat x = (w + padding) * (i % numberOfRow);
        CGFloat y = (h + padding) * (i / numberOfRow);
        
        NSString * title = elements[i];
        CGRect btnRect = CGRectMake(x, y, w, h);
        UIButton *btn = [UIButton createRect:btnRect title:title type:NNButtonTypeTitleBlack];
        btn.tag = kTAG_BTN+i;
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        [backgroudView addSubview:btn];
    }
    return backgroudView;
}

+ (UIView *)createViewRect:(CGRect)rect
                     items:(NSArray *)items
               numberOfRow:(NSInteger)numberOfRow
                itemHeight:(CGFloat)itemHeight
                   padding:(CGFloat)padding
                   handler:(void(^)(UIButton *sender))handler{
    
    NSInteger rowCount = items.count % numberOfRow == 0 ? items.count/numberOfRow : items.count/numberOfRow + 1;
    CGFloat itemWidth = (CGRectGetWidth(rect) - (numberOfRow-1)*padding)/numberOfRow;
    itemHeight = itemHeight == 0.0 ? itemWidth : itemHeight;;
    CGFloat height = rowCount * itemHeight + (rowCount - 1) * padding;
    //
    UIView *backgroudView = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMinX(rect),
                                                                     CGRectGetMinY(rect),
                                                                     CGRectGetWidth(rect),
                                                                     height)];
    backgroudView.backgroundColor = UIColor.greenColor;
    
    for (NSInteger i = 0; i< items.count; i++) {
        CGFloat w = itemWidth;
        CGFloat h = itemHeight;
        CGFloat x = (i % numberOfRow) * (w + padding);
        CGFloat y = (i / numberOfRow) * (h + padding);
        
        NSString *title = items[i];
        CGRect itemRect = CGRectMake(x, y, w, h);
        
        UIButton *sender = ({
            UIButton *sender = [UIButton buttonWithType:UIButtonTypeCustom];
            [sender setTitleColor:UIColor.themeColor forState:UIControlStateNormal];
            sender.titleLabel.font = [UIFont systemFontOfSize:15];
            sender.tag = i;
            sender;
        });
        [sender setTitle:title forState:UIControlStateNormal];
        sender.frame = itemRect;
        [sender addActionHandler:handler forControlEvents:UIControlEventTouchUpInside];
        [backgroudView addSubview:sender];
    }
    return backgroudView;
}

//向屏幕倾斜
+ (void)transformStateEventWithView:(UIView *)view {
    
    // 初始化3D变换,获取默认值
    CATransform3D perspectiveTransform = CATransform3DIdentity;
    // 透视
    perspectiveTransform.m34 = -1.0/500.0;
    
    // 位移
    //    perspectiveTransform = CATransform3DTranslate(perspectiveTransform, 30, -35, 0);
    // 空间旋转
    //    perspectiveTransform = CATransform3DRotate(perspectiveTransform, [Math radianFromDegree:30], 0.75, 1, -0.5);
    perspectiveTransform = CATransform3DRotate(perspectiveTransform, (10) * M_PI / 180.f, -1, 0, 0);
    
    // 缩放变换
    //    perspectiveTransform = CATransform3DScale(perspectiveTransform, 0.75, 0.75, 0.75);
    
    view.layer.transform              = perspectiveTransform;
    view.layer.allowsEdgeAntialiasing = YES; // 抗锯齿
    //    view.layer.speed                  = 0.5;
    
    view.layer.shadowOffset = CGSizeMake(0, 5);
    view.layer.shadowColor = UIColor.blackColor.CGColor;
    view.layer.shadowOpacity = 1;//阴影透明度，默认0
    view.layer.shadowRadius = 2;//阴影半径，默认3
}

#pragma make - -圆角
//通过Graphics 和 BezierPath 设置圆角
+ (void)setCutCirculayWithView:(UIImageView *)view cornerRadius:(CGFloat)cornerRadius type:(NSNumber *)type{
    switch (type.integerValue) {
        case 0:
        {
            //通过Graphics 和 BezierPath 设置圆角
            UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, UIScreen.mainScreen.scale);
            [[UIBezierPath bezierPathWithRoundedRect:view.bounds cornerRadius:cornerRadius] addClip];
            [view drawRect:view.bounds];
            
            view.image = UIGraphicsGetImageFromCurrentImageContext();
            // 结束
            UIGraphicsEndImageContext();

        }
            break;
        case 1:
        {
            // 创建BezierPath 并设置角 和 半径 这里只设置了 左上 和 右上
            UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:view.bounds
                                                       byRoundingCorners:UIRectCornerAllCorners
                                                             cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
            CAShapeLayer *layer = CAShapeLayer.layer;
            layer.frame = view.bounds;
            layer.path = path.CGPath;
            view.layer.mask = layer;
        }
            break;
        case 2:
        {
            
        }
            break;
        default:
            break;
    }
}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    UITouch *touch = [touches anyObject];
//    CGPoint point = [touch locationInView:self];
//}

+ (UIVisualEffectView *)createBlurViewEffect:(UIBlurEffectStyle)effect subView:(UIView *)view{
    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    if (effect) {
        blur = [UIBlurEffect effectWithStyle:effect];
    }
//    UIVibrancyEffect *vibrancy = [UIVibrancyEffect effectForBlurEffect:blur];
    UIVisualEffectView *visualView = [[UIVisualEffectView alloc]initWithEffect:blur];
    
    visualView.frame = view.bounds;
//    visualView.layer.masksToBounds = YES;
//    visualView.layer.cornerRadius = CGRectGetHeight(visualView.frame);
    
    //把要添加的视图加到毛玻璃上
    [visualView.contentView addSubview:view];
    return visualView;
}

- (void)addCircleLayerColor:(UIColor *)layColor layerWidth:(CGFloat)layerWidth{
    
    CGPoint center = self.center;
    //半径
    CGFloat radius = sqrt(pow(CGRectGetWidth(self.frame), 2) + pow(CGRectGetHeight(self.frame), 2))/2.0 + layerWidth*2;
    
    //创建贝塞尔路径
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center
                                                        radius:radius
                                                    startAngle:(-0.5f*M_PI)
                                                      endAngle:1.5f*M_PI
                                                     clockwise:YES];
    //添加背景圆环
    CAShapeLayer *layer = CAShapeLayer.layer;
    layer.frame = self.bounds;
    layer.fillColor =  UIColor.clearColor.CGColor;
    layer.strokeColor = UIColor.themeColor.CGColor;
    layer.lineWidth = layerWidth;
    layer.path = path.CGPath;
    layer.strokeEnd = 1;
    [self.superview.layer addSublayer:layer];
}

//- (NSIndexPath *)getCellIndexPath:(UITableView *)tableView{
//    UITableViewCell *cell = [self findSuperView: @"UITableViewCell"];
//    NSIndexPath *indexPath = [tableView indexPathForRowAtPoint:cell.center];
////    DDLog(@"%@",indexPath);
//    return indexPath;
//}

////信任值展示,无点击手势
//+ (id)getStarViewRect:(CGRect)rect rateStyle:(NSString *)rateStyle currentScore:(CGFloat)currentScore{
//    //默认五颗星星
//    BNStarRateView *starRateView = [[BNStarRateView alloc] initWithFrame:rect];
//    switch ([rateStyle integerValue]) {
//        case 0:
//        {
//            starRateView.rateStyle = WholeStar;
//
//        }
//            break;
//        case 1:
//        {
//            starRateView.rateStyle = HalfStar;
//
//        }
//            break;
//        case 2:
//        {
//            starRateView.rateStyle = IncompleteStar;
//
//        }
//            break;
//        default:
//            break;
//    }
//
//    starRateView.currentScore = currentScore/100.0 * 5;
//    starRateView.backgroundColor = UIColor.clearColor;
//    starRateView.userInteractionEnabled = NO;
//
//    return starRateView;
//}

@end


@implementation UIView (ScreenEdgePan)

-(UIView *)showView{
    id obj = objc_getAssociatedObject(self, _cmd);
    if (obj) {
        return obj;
    }

    UIView *view = [[UIView alloc]initWithFrame:UIScreen.mainScreen.bounds];
    view.backgroundColor = UIColor.redColor;
    view.alpha = .5;
    
    CGRect frame = view.frame;
    frame.origin.x = -CGRectGetWidth(UIScreen.mainScreen.bounds);// 将x值改成负的屏幕宽度,默认就在屏幕的左边
    view.frame = frame;
        // 因为该view是盖在所有的view身上,所以应该添加到window上
    [UIApplication.sharedApplication.keyWindow addSubview:view];
    
    // 添加轻扫手势  -- 滑回
    UISwipeGestureRecognizer *recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(closeShowView:)];
    recognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    [view addGestureRecognizer:recognizer];
 
    objc_setAssociatedObject(self, _cmd, view, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    return view;
}

- (void)setShowView:(UIView *)showView{
    objc_setAssociatedObject(self, @selector(showView), showView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)addRecognizerEdgPan:(void(^)(UIScreenEdgePanGestureRecognizer *recognizer))block{
    UIScreenEdgePanGestureRecognizer *recoginzer = objc_getAssociatedObject(self, _cmd);
    if (!recoginzer) {
        // 添加边缘手势
        UIScreenEdgePanGestureRecognizer *recoginzer = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(p_handleActionRecognizerEdgPan:)];
        // 指定左边缘滑动
        recoginzer.edges = UIRectEdgeLeft;

        self.userInteractionEnabled = true;
        [self addGestureRecognizer:recoginzer];

        objc_setAssociatedObject(self, _cmd, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
}

- (void)p_handleActionRecognizerEdgPan:(UIScreenEdgePanGestureRecognizer *)recognizer{
    void(^block)(UIScreenEdgePanGestureRecognizer *recognizer) = objc_getAssociatedObject(self, @selector(addRecognizerEdgPan:));
    if (block) block(recognizer);

    if (![UIApplication.sharedApplication.keyWindow.subviews containsObject:self.showView]) {
        [UIApplication.sharedApplication.keyWindow addSubview:self.showView];
    }
    [self followScreenEdgePan:recognizer];
}

- (void)followScreenEdgePan:(UIScreenEdgePanGestureRecognizer *)recognizer{
    // 让view跟着手指去移动
    // frame的x应该为多少??应该获取到手指的x值
    // 取到手势在当前控制器视图中识别的位置
    CGPoint point = [recognizer locationInView:self];
//    NSLog(@"%@", NSStringFromCGPoint(point));
    CGRect frame = self.showView.frame;
    // 更改adView的x值. 手指的位置 - 屏幕宽度
    frame.origin.x = point.x - CGRectGetWidth(UIScreen.mainScreen.bounds);
    self.showView.frame = frame;
    
    if (recognizer.state == UIGestureRecognizerStateEnded || recognizer.state == UIGestureRecognizerStateCancelled) {
        // 判断当前广告视图在屏幕上显示是否超过一半
        if (CGRectContainsPoint(self.frame, self.showView.center)) {
            // 如果超过,那么完全展示出来
            frame.origin.x = 0;
        } else {
            // 如果没有,隐藏
            frame.origin.x = -CGRectGetWidth(UIScreen.mainScreen.bounds);
        }
        [UIView animateWithDuration:0.25 animations:^{
            self.showView.frame = frame;
        }];
    }
}

- (void)closeShowView:(UISwipeGestureRecognizer *)recognizer {
    [UIView animateWithDuration:0.25 animations:^{
        CGRect frame = recognizer.view.frame;
        frame.origin.x = -CGRectGetWidth(UIScreen.mainScreen.bounds);
        recognizer.view.frame = frame;
    }];
}


@end
