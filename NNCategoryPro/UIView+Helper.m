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

-(UIViewController *)parController{
    id responder = self;
    while (responder){
        if ([responder isKindOfClass:[UIViewController class]]){
            return responder;
        }
        responder = [responder nextResponder];
    }
    return nil;
}

#pragma mak -绘制

#pragma mark -设置部分圆角

- (UIView *)addCorners:(UIRectCorner)corners
           cornerRadii:(CGSize)cornerRadii
                 width:(CGFloat)width
                 color:(UIColor *)color{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                   byRoundingCorners:corners
                                                         cornerRadii:cornerRadii];
    // 创建遮罩层
    CAShapeLayer *maskLayer = CAShapeLayer.layer;
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;   // 轨迹
    maskLayer.borderWidth = width;
    maskLayer.borderColor = color.CGColor;
    self.layer.mask = maskLayer;
    return self;
}

/**
 上下文绘制圆角矩形
 */
- (UIImage *)drawCorners:(UIRectCorner)corners
            cornerRadii:(CGFloat)radius
            borderWidth:(CGFloat)borderWidth
            borderColor:(UIColor *)borderColor
                 bgColor:(UIColor*)bgColor{
    CGSize size = self.bounds.size;
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    CGContextRef contextRef =  UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(contextRef, borderWidth);
    CGContextSetStrokeColorWithColor(contextRef, borderColor.CGColor);
    CGContextSetFillColorWithColor(contextRef, bgColor.CGColor);
    
    CGFloat halfBorderWidth = borderWidth / 2.0;
    CGFloat width = size.width;
    CGFloat height = size.height;
    
    CGContextMoveToPoint(contextRef,
                         width - halfBorderWidth,
                         radius + halfBorderWidth);
    CGContextAddArcToPoint(contextRef,
                           width - halfBorderWidth,
                           height - halfBorderWidth,
                           width - radius - halfBorderWidth,
                           height - halfBorderWidth, radius);  // 右下角角度
    CGContextAddArcToPoint(contextRef,
                           halfBorderWidth,
                           height - halfBorderWidth,
                           halfBorderWidth,
                           height - radius - halfBorderWidth, radius); // 左下角角度
    CGContextAddArcToPoint(contextRef,
                           halfBorderWidth,
                           halfBorderWidth,
                           width - halfBorderWidth,
                           halfBorderWidth,
                           radius); // 左上角
    CGContextAddArcToPoint(contextRef,
                           width - halfBorderWidth,
                           halfBorderWidth,
                           width - halfBorderWidth,
                           radius + halfBorderWidth,
                           radius); // 右上角
    CGContextDrawPath(contextRef, kCGPathFillStroke);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (UIView *)addCorners:(UIRectCorner)corners cornerRadii:(CGSize)cornerRadii{
    return [self addCorners:corners cornerRadii:cornerRadii width:1.0 color:UIColor.whiteColor];
}


#pragma mak - -Recognizer
/**
 手势 - 单指点击
 */
- (UITapGestureRecognizer *)addGestureTap:(void(^)(UIGestureRecognizer *reco))block{
    NSString *funcAbount = NSStringFromSelector(_cmd);
    NSString *runtimeKey = RuntimeKeyFromParams(self, funcAbount);
    
    UITapGestureRecognizer *recognizer = objc_getAssociatedObject(self, CFBridgingRetain(runtimeKey));
    if (!recognizer){
        recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleActionGesture:)];
        recognizer.numberOfTapsRequired = 1;
        recognizer.numberOfTouchesRequired = 1;
//        recognizer.cancelsTouchesInView = false;
//        recognizer.delaysTouchesEnded = false;
        self.userInteractionEnabled = true;
        self.multipleTouchEnabled = true;
        [self addGestureRecognizer:recognizer];
        
        recognizer.runtimeKey = runtimeKey;
        objc_setAssociatedObject(self, CFBridgingRetain(runtimeKey), block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
    return recognizer;
}

/**
 手势 - 长按
 */
- (UILongPressGestureRecognizer *)addGestureLongPress:(void(^)(UIGestureRecognizer *reco))block forDuration:(NSTimeInterval)minimumPressDuration{
    NSString *funcAbount = [NSStringFromSelector(_cmd) stringByAppendingFormat:@",%@",@(minimumPressDuration)];
    NSString *runtimeKey = RuntimeKeyFromParams(self, funcAbount);

    UILongPressGestureRecognizer *recognizer = objc_getAssociatedObject(self, CFBridgingRetain(runtimeKey));
    if (!recognizer){
        recognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleActionGesture:)];
        recognizer.minimumPressDuration = minimumPressDuration;
        self.userInteractionEnabled = true;
        self.multipleTouchEnabled = true;
        [self addGestureRecognizer:recognizer];
        recognizer.runtimeKey = runtimeKey;
        objc_setAssociatedObject(self, CFBridgingRetain(runtimeKey), block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
    return recognizer;
}

/**
 手势 - 拖动
 */
- (UIPanGestureRecognizer *)addGesturePan:(void(^)(UIGestureRecognizer *reco))block{
    NSString *funcAbount = NSStringFromSelector(_cmd);
    NSString *runtimeKey = RuntimeKeyFromParams(self, funcAbount);

    UIPanGestureRecognizer *recognizer = objc_getAssociatedObject(self, CFBridgingRetain(runtimeKey));
    if (!recognizer){
        recognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleActionGesture:)];
        recognizer.minimumNumberOfTouches = 1;
        recognizer.maximumNumberOfTouches = 3;
        self.userInteractionEnabled = true;
        self.multipleTouchEnabled = true;
        [self addGestureRecognizer:recognizer];
        recognizer.runtimeKey = runtimeKey;
        objc_setAssociatedObject(self, CFBridgingRetain(runtimeKey), block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
    return recognizer;
}

/**
 手势 - 边缘拖动
 */
- (UIScreenEdgePanGestureRecognizer *)addGestureEdgPan:(void(^)(UIGestureRecognizer *reco))block forEdges:(UIRectEdge)edges{
    NSString *funcAbount = [NSStringFromSelector(_cmd) stringByAppendingFormat:@",%@",@(edges)];
    NSString *runtimeKey = RuntimeKeyFromParams(self, funcAbount);

    UIScreenEdgePanGestureRecognizer *recognizer = objc_getAssociatedObject(self, CFBridgingRetain(runtimeKey));
    if (!recognizer){
        recognizer = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(handleActionGesture:)];
        recognizer.edges = edges;
        self.userInteractionEnabled = true;
        self.multipleTouchEnabled = true;
        [self addGestureRecognizer:recognizer];
        recognizer.runtimeKey = runtimeKey;
        objc_setAssociatedObject(self, CFBridgingRetain(runtimeKey), block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
    return recognizer;
}

/**
 手势 - 轻扫
 */
- (UISwipeGestureRecognizer *)addGestureSwipe:(void(^)(UIGestureRecognizer *reco))block forDirection:(UISwipeGestureRecognizerDirection)direction{
    NSString *funcAbount = [NSStringFromSelector(_cmd) stringByAppendingFormat:@",%@",@(direction)];
    NSString *runtimeKey = RuntimeKeyFromParams(self, funcAbount);

    UISwipeGestureRecognizer *recognizer = objc_getAssociatedObject(self, CFBridgingRetain(runtimeKey));
    if (!recognizer) {
        recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleActionGesture:)];
        recognizer.direction = direction;
        self.userInteractionEnabled = true;
        self.multipleTouchEnabled = true;
        [self addGestureRecognizer:recognizer];
        recognizer.runtimeKey = runtimeKey;
        objc_setAssociatedObject(self, CFBridgingRetain(runtimeKey), block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
    return recognizer;
}

/**
 手势 - 捏合
 */
- (UIPinchGestureRecognizer *)addGesturePinch:(void(^)(UIGestureRecognizer *reco))block{
    NSString *funcAbount = NSStringFromSelector(_cmd);
    NSString *runtimeKey = RuntimeKeyFromParams(self, funcAbount);

    UIPinchGestureRecognizer *recognizer = objc_getAssociatedObject(self, CFBridgingRetain(runtimeKey));
    if (!recognizer){
        recognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handleActionGesture:)];
//        recognizer.scale = 1.0;
        self.userInteractionEnabled = true;
        self.multipleTouchEnabled = true;
        [self addGestureRecognizer:recognizer];
        recognizer.runtimeKey = runtimeKey;
        objc_setAssociatedObject(self, CFBridgingRetain(runtimeKey), block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
    return recognizer;
}

/**
 手势 - 旋转
 */
- (UIRotationGestureRecognizer *)addGestureRotation:(void(^)(UIGestureRecognizer *reco))block{
    NSString *funcAbount = NSStringFromSelector(_cmd);
    NSString *runtimeKey = RuntimeKeyFromParams(self, funcAbount);

    UIRotationGestureRecognizer *recognizer = objc_getAssociatedObject(self, CFBridgingRetain(runtimeKey));
    if (!recognizer){
        recognizer = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(handleActionGesture:)];
        self.userInteractionEnabled = true;
        self.multipleTouchEnabled = true;
        [self addGestureRecognizer:recognizer];
        recognizer.runtimeKey = runtimeKey;
        objc_setAssociatedObject(self, CFBridgingRetain(runtimeKey), block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
    return recognizer;
}

/**
 手势响应事件
 */
- (void)handleActionGesture:(UIGestureRecognizer *)recognizer{
    void(^block)(id sender) = objc_getAssociatedObject(self, CFBridgingRetain(recognizer.runtimeKey));

    if ([recognizer isKindOfClass:UISwipeGestureRecognizer.class]) {
        if (block)block(recognizer);
//        DDLog(@"_%@_%@_",recognizer.runtimeKey,block);
        
    }
    else if ([recognizer isKindOfClass:UIScreenEdgePanGestureRecognizer.class]) {
        //UIScreenEdgePanGestureRecognizer继承于UIPanGestureRecognizer,必须在其前边判断
        if (block) block(recognizer);
        
    }
    else if ([recognizer isKindOfClass:UITapGestureRecognizer.class]) {
        if (block) block(recognizer);

    }
    else if ([recognizer isKindOfClass:UILongPressGestureRecognizer.class]) {
        if (recognizer.state == UIGestureRecognizerStateBegan) {
            if (block) block(recognizer);
        }
    }
    else if ([recognizer isKindOfClass:UIPanGestureRecognizer.class]) {
        UIPanGestureRecognizer *sender = (UIPanGestureRecognizer *)recognizer;
        CGPoint translate = [sender translationInView:recognizer.view.superview];
        sender.view.center = CGPointMake(sender.view.center.x + translate.x, sender.view.center.y +translate.y);
        [sender setTranslation:CGPointZero inView:recognizer.view.superview];
        
        if (block) block(recognizer);
        
    }
    else if ([recognizer isKindOfClass:UIPinchGestureRecognizer.class]) {
        UIPinchGestureRecognizer *sender = (UIPinchGestureRecognizer *)recognizer;
        //捏合时保持图片位置不变
        CGPoint location = [recognizer locationInView:recognizer.view.superview];
        sender.view.center = location;
        //通过手势的缩放比例改变图片的仿射变换矩阵
        sender.view.transform = CGAffineTransformScale(sender.view.transform, sender.scale, sender.scale);
        //重置手势缩放比例
        sender.scale = 1.0;
        
        if (block) block(recognizer);
        
    }
    else if ([recognizer isKindOfClass:UIRotationGestureRecognizer.class]) {
        UIRotationGestureRecognizer *sender = (UIRotationGestureRecognizer *)recognizer;
        //改变手势view的仿射变换矩阵
        sender.view.transform = CGAffineTransformRotate(sender.view.transform, sender.rotation);
        //重置弧度
        sender.rotation = 0;
        if (block) block(recognizer);

    }
}

/**
 (弃用)给view关联点击事件(支持UIView和UIButton可继续扩展其他支持)
 */
- (void)addActionHandler:(void(^)(id obj, id item, NSInteger idx))handler{
    UIControlEvents controlEvents = [self isKindOfClass:UIButton.class] ? UIControlEventTouchUpInside : UIControlEventValueChanged;
    if ([self isKindOfClass:UIControl.class]) {
        [(UIControl *)self addTarget:self action:@selector(handleActionBtn:) forControlEvents:controlEvents];
        
    }
    else{
        UITapGestureRecognizer *tapGesture = objc_getAssociatedObject(self, _cmd);
        if (!tapGesture){
            tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleActionTapGesture:)];
            tapGesture.numberOfTapsRequired = 1;
            tapGesture.numberOfTouchesRequired = 1;
//            tapGesture.cancelsTouchesInView = NO;
//            tapGesture.delaysTouchesEnded = NO;
            
            self.userInteractionEnabled = true;
            self.multipleTouchEnabled = true;
            [self addGestureRecognizer:tapGesture];
        }
    }
    objc_setAssociatedObject(self, _cmd, handler, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

/**
 关联方法待改进
 */
- (void)handleActionBtn:(id)sender{
    void(^block)(id obj, id item, NSInteger idx) = objc_getAssociatedObject(self, @selector(addActionHandler:));
    if ([sender isKindOfClass:UIButton.class]) {
        if (block) block(sender, sender, ((UIButton *)sender).tag);

    } else if ([sender isKindOfClass:UISegmentedControl.class]) {
        UISegmentedControl *segmentCtl = sender;
        if (block) block(sender, sender, segmentCtl.selectedSegmentIndex);
    }
    else{
        if (block) block(sender, sender, ((UIControl *)sender).tag);

    }
}

/**
 关联方法待改进
 */
- (void)handleActionTapGesture:(UITapGestureRecognizer *)tapGesture{
    void(^block)(id obj, id item, NSInteger idx) = objc_getAssociatedObject(self, @selector(addActionHandler:));
    if (block){
        block(tapGesture, tapGesture.view, tapGesture.view.tag);
    }
}

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
    return [self findSubview:class];
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
    return [self findSuperView:class];
}


- (NSArray<__kindof UIView *> *)updateItems:(NSInteger)count aClassName:(NSString *)aClassName handler:(void(^)(__kindof UIView *obj))handler {
    if (count == 0) {
        return @[];
    }
    Class cls = NSClassFromString(aClassName);
    NSArray *list = [self.subviews filter:^BOOL(UIView * obj, NSUInteger idx) {
        return [obj isKindOfClass:cls.class];
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

+ (UIView *)createSectionView:(UITableView *)tableView
                         text:(NSString *)text
                textAlignment:(NSTextAlignment)textAlignment
                       height:(CGFloat)height{
    UIView * sectionView = [[UIView alloc]init];
    if (text == nil) {
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
    
    UIImageView *containView = [UIImageView createRect:rect type:@0];
    CGSize imgViewSize = CGSizeMake(kH_LABEL_SMALL, kH_LABEL_SMALL);
    CGFloat YGap = (CGRectGetHeight(rect) - imgViewSize.height*2)/2.0;
    CGFloat XGapImgView = (CGRectGetWidth(rect) - imgViewSize.width)/2.0;
    
    CGRect imgViewRect = CGRectMake(XGapImgView, YGap, imgViewSize.width, imgViewSize.height);
    UIImageView * imgView = [UIImageView createRect:imgViewRect type:@0];
    imgView.image = [UIImage imageNamed:@"img_cardAdd.png"];
    imgView.layer.backgroundColor = UIColor.whiteColor.CGColor;
    [containView addSubview:imgView];
    
    CGSize textSize = [self sizeWithText:title font:@(kFontSize14) width:CGRectGetWidth(rect)];
    CGFloat XGapLab = (CGRectGetWidth(rect) - textSize.width)/2.0;
    
    CGRect labRect = CGRectMake(XGapLab, CGRectGetMaxY(imgViewRect), textSize.width, kH_LABEL_SMALL);
    UILabel * lab = [UILabel createRect:labRect type:@2];
    lab.text = title;
    lab.tag = kTAG_LABEL;
    
    lab.textColor = UIColor.titleSubColor;
    lab.font = [UIFont systemFontOfSize:kFontSize14];
    lab.textAlignment = NSTextAlignmentCenter;
    [containView addSubview:lab];
    
    return containView;
}


+ (NNTextField *)createRect:(CGRect)rect
                placeholder:(NSString *)placeholder
                   leftView:(UIView *)leftView
                leftPadding:(CGFloat)leftPadding
                  rightView:(UIView *)rightView
               rightPadding:(CGFloat)rightPadding{
    NNTextField * textField = [NNTextField createRect:rect];
//    textField.text = text;
    textField.textAlignment = NSTextAlignmentLeft;
    textField.placeholder = placeholder;

//    UIImageView *imgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"img_cardAdd.png"]];
//    imgView.frame = CGRectMake(0, 0, 21, 21);
//    textField.leftViewPadding = 5;
    textField.leftView = leftView;
    textField.leftViewMode = UITextFieldViewModeAlways;
    textField.leftViewPadding = leftPadding;

//    UIButton * btn = [UIButton createRect:CGRectMake(0, 0, 40, textFieldHeight) title:@"搜 索" image:nil type:@2 target:self aSelector:@selector(goSearch)];
//    textField.rightViewPadding = 5;
    textField.rightViewMode = UITextFieldViewModeAlways;
    textField.rightViewPadding = rightPadding;
    textField.rightView = rightView;

    textField.backgroundColor = [UIColor whiteColor];
//    textField.backgroundColor = UIColor.greenColor;
    return textField;
}

+ (NNTextField *)createRect:(CGRect)rect
                placeholder:(NSString *)placeholder
                   leftView:(UIView *)leftView
                  rightView:(UIView *)rightView{
    return [NNTextField createRect:CGRectZero
                       placeholder:placeholder
                          leftView:leftView
                       leftPadding:kPadding
                         rightView:rightView
                      rightPadding:kPadding];
}

- (CGSize)itemSizeWithCount:(NSInteger)count
                numberOfRow:(NSInteger)numberOfRow
                    spacing:(CGFloat)spacing
                      inset:(UIEdgeInsets)inset{
    NSInteger rowCount = count % numberOfRow == 0 ? count/numberOfRow : count/numberOfRow + 1;
    CGFloat itemWidth = (CGRectGetWidth(self.bounds) - (numberOfRow-1)*spacing - inset.left - inset.right)/numberOfRow;
    CGFloat itemHeight = (CGRectGetHeight(self.bounds) - (rowCount-1)*spacing - inset.top - inset.bottom)/rowCount;
    CGSize size = CGSizeMake(itemWidth, itemHeight);
    return size;
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
        UIButton * btn = [UIButton createRect:btnRect title:title image:nil type:@0];
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
                      type:(NSNumber *)type
                   handler:(void(^)(id obj, id item, NSInteger idx))handler{
    
    NSInteger rowCount = items.count % numberOfRow == 0 ? items.count/numberOfRow : items.count/numberOfRow + 1;
    CGFloat itemWidth = (CGRectGetWidth(rect) - (numberOfRow-1)*padding)/numberOfRow;
    itemHeight = itemHeight == 0.0 ? itemWidth : itemHeight;;
    
    //
    UIView * backgroudView = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMinX(rect),
                                                                     CGRectGetMinY(rect),
                                                                     CGRectGetWidth(rect),
                                                                     rowCount * itemHeight + (rowCount - 1) * padding)];
    backgroudView.backgroundColor = UIColor.greenColor;
    
    for (NSInteger i = 0; i< items.count; i++) {
        
        CGFloat w = itemWidth;
        CGFloat h = itemHeight;
        CGFloat x = (i % numberOfRow) * (w + padding);
        CGFloat y = (i / numberOfRow) * (h + padding);
        
        NSString * title = items[i];
        CGRect itemRect = CGRectMake(x, y, w, h);
        
        UIView * view = nil;
        switch (type.integerValue) {
            case 0://uibutton
            {
                view = ({
                    UIButton * view = [UIButton createRect:itemRect title:title image:nil type:@5];
                    view.tag = i;
                    view.titleLabel.font = [UIFont systemFontOfSize:15];
                    view;
                });
            }
                break;
            case 1://UIImageVIew
            {
                view = ({
                    UIImageView *view = [UIImageView createRect:itemRect type:@0];
                    view.image = [UIImage imageNamed:title];
                    view.tag = i;
                    view;
                });
                
            }
                break;
            case 2://UILabel
            {
                view = ({
                    UILabel * view = [UILabel createRect:itemRect type:@0];
                    view.text = title;
                    view.tag = i;
                    view.font = [UIFont systemFontOfSize:15];
                    view.textAlignment = NSTextAlignmentCenter;
                    view;
                });
            }
                break;
            default:
                break;
        }
        [backgroudView addSubview:view];
        [view addActionHandler:^(id obj, id item, NSInteger idx) {
            handler(obj, item, idx);
            
        }];
        
    }
    return backgroudView;
}

/// classtype 只能为 UIView及其子类
+ (UIView *)createViewRect:(CGRect)rect
                     items:(NSArray *)items
               numberOfRow:(NSInteger)numberOfRow
                   padding:(CGFloat)padding
                     inset:(UIEdgeInsets)inset
                 classtype:(Class)classtype
                   handler:(void(^)(__kindof UIView *))handler{

    NSInteger rowCount = items.count % numberOfRow == 0 ? items.count/numberOfRow : items.count/numberOfRow + 1;
    CGFloat itemWidth = (CGRectGetWidth(rect) - (numberOfRow-1)*padding - inset.left - inset.right)/numberOfRow;
    CGFloat itemHeight = (CGRectGetHeight(rect) - (rowCount-1)*padding - inset.top - inset.bottom)/rowCount;
    //
    UIView *backgroudView = [[UIView alloc]initWithFrame:rect];
    backgroudView.backgroundColor = UIColor.systemBlueColor;
    
    for (NSInteger i = 0; i< items.count; i++) {
        CGFloat w = itemWidth;
        CGFloat h = itemHeight;
        CGFloat x = (i % numberOfRow) * (w + padding);
        CGFloat y = (i / numberOfRow) * (h + padding);
        
        NSString *title = items[i];
        CGRect itemRect = CGRectMake(x, y, itemWidth, itemHeight);
        
        UIView *view = nil;
        if ([classtype isKindOfClass: UIButton.class]) {
            view = ({
                UIButton *view = [UIButton createRect:itemRect
                                                title:title
                                                image:nil
                                                 type:@5];
                view.tag = i;
                view.titleLabel.font = [UIFont systemFontOfSize:15];
                view;
            });
        } else if ([classtype isKindOfClass: UIImageView.class]) {
            view = ({
                 UIImageView *view = [UIImageView createRect:itemRect type:@0];
                 view.image = [UIImage imageNamed:title];
                 view.tag = i;
                 view;
             });
        } else if ([classtype isKindOfClass: UILabel.class]) {
            view = ({
                UILabel *view = [UILabel createRect:itemRect type:@0];
                view.text = title;
                view.tag = i;
                view.font = [UIFont systemFontOfSize:15];
                view.textAlignment = NSTextAlignmentCenter;
                view;
            });
        }
        [backgroudView addSubview:view];
        
        if (handler) {
            handler(view);
        }
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

/**
 移除所有子视图
 */
- (void)removeAllSubViews{
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
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
