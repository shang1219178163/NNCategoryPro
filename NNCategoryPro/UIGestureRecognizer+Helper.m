
//
//  UIGestureRecognizer+Helper.m
//  
//
//  Created by Bin Shang on 2019/1/4.
//

#import "UIGestureRecognizer+Helper.h"
#import <objc/runtime.h>

@implementation UIGestureRecognizer (Helper)

-(NSString *)funcName{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setFuncName:(NSString *)actionName{
    objc_setAssociatedObject(self, @selector(funcName), actionName, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)addActionBlock:(void(^)(UIGestureRecognizer *reco))block {
    if (!block) {
        return;
    }

    objc_setAssociatedObject(self, _cmd, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self action:@selector(p_invoke:)];
}

- (void)p_invoke:(UIGestureRecognizer *)sender {
    void(^block)(UIGestureRecognizer *reco) = objc_getAssociatedObject(self, @selector(addActionBlock:));
    if (block) {
        block(sender);
    }
}

/**
 手势点返回的矩形
 */
- (CGRect)cirlceRectBigCircle:(BOOL)bigCircle{
    UIGestureRecognizer *recognizer = self;
    CGPoint point = [recognizer locationInView:recognizer.view];
    CGRect circleRect = CGRectMake(point.x, point.y, 1.0, 1.0);
    if (bigCircle == false) {
        return circleRect;
    }
    CGFloat width = CGRectGetWidth(UIScreen.mainScreen.bounds);
    CGFloat height = CGRectGetHeight(UIScreen.mainScreen.bounds);
    //圆圈2--大圆
    //以point的中心为圆心大圆
    //找出到页面4个角最长的半径
    CGFloat r1 = MAX(width - point.x, point.x);
    CGFloat r2 = MAX(height - point.y, point.y);
    
    CGFloat radius = sqrt((r1 * r1) + (r2 * r2));
    CGRect bigCircleRect = CGRectInset(circleRect, -radius, -radius);
    return bigCircleRect;
}

/**
 手势point返回的圆形UIBezierPath路径
 */
- (UIBezierPath *)pathBigCircle:(BOOL)bigCircle{
    UIGestureRecognizer * recognizer = self;
    CGRect circleRect = [recognizer cirlceRectBigCircle:bigCircle];
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:circleRect];
    return path;
}

/**
 手势point返回的圆形UIBezierPath路径的CAShapeLayer
 */
- (CAShapeLayer *)layerBigCircle:(BOOL)bigCircle{
    CAShapeLayer *layer = CAShapeLayer.layer;
    layer.path = [self pathBigCircle:bigCircle].CGPath;
    return layer;
}

@end


@implementation UITapGestureRecognizer (Helper)

- (void)addActionBlock:(void(^)(UITapGestureRecognizer *reco))block {
    if (!block) {
        return;
    }

    objc_setAssociatedObject(self, _cmd, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self action:@selector(p_invoke:)];
}

- (void)p_invoke:(UITapGestureRecognizer *)sender {
    void(^block)(UITapGestureRecognizer *reco) = objc_getAssociatedObject(self, @selector(addActionBlock:));
    if (block) {
        block(sender);
    }
}

@end


@implementation UILongPressGestureRecognizer (Helper)

- (void)addActionBlock:(void(^)(UILongPressGestureRecognizer *reco))block {
    if (!block) {
        return;
    }

    objc_setAssociatedObject(self, _cmd, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self action:@selector(p_invoke:)];
}

- (void)p_invoke:(UILongPressGestureRecognizer *)sender {
    void(^block)(UILongPressGestureRecognizer *reco) = objc_getAssociatedObject(self, @selector(addActionBlock:));
    if (block) {
        block(sender);
    }
}

@end


@implementation UIPanGestureRecognizer (Helper)

- (void)addActionBlock:(void(^)(UIPanGestureRecognizer *reco))block {
    if (!block) {
        return;
    }

    objc_setAssociatedObject(self, _cmd, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self action:@selector(p_invoke:)];
}

- (void)p_invoke:(UIPanGestureRecognizer *)sender {
    void(^block)(UIPanGestureRecognizer *reco) = objc_getAssociatedObject(self, @selector(addActionBlock:));
    if (block) {
        CGPoint translate = [sender translationInView:sender.view.superview];
        sender.view.center = CGPointMake(sender.view.center.x + translate.x, sender.view.center.y +translate.y);
        [sender setTranslation:CGPointZero inView:sender.view.superview];
        
        block(sender);
    }
}

@end



@implementation UIScreenEdgePanGestureRecognizer (Helper)

- (void)addActionBlock:(void(^)(UIScreenEdgePanGestureRecognizer *reco))block {
    if (!block) {
        return;
    }

    objc_setAssociatedObject(self, _cmd, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self action:@selector(p_invoke:)];
}

- (void)p_invoke:(UIScreenEdgePanGestureRecognizer *)sender {
    void(^block)(UIScreenEdgePanGestureRecognizer *reco) = objc_getAssociatedObject(self, @selector(addActionBlock:));
    if (block) {
        block(sender);
    }
}

@end


@implementation UISwipeGestureRecognizer (Helper)

- (void)addActionBlock:(void(^)(UISwipeGestureRecognizer *reco))block {
    if (!block) {
        return;
    }

    objc_setAssociatedObject(self, _cmd, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self action:@selector(p_invoke:)];
}

- (void)p_invoke:(UISwipeGestureRecognizer *)sender {
    void(^block)(UISwipeGestureRecognizer *reco) = objc_getAssociatedObject(self, @selector(addActionBlock:));
    if (block) {
        block(sender);
    }
}

@end


@implementation UIPinchGestureRecognizer (Helper)

- (void)addActionBlock:(void(^)(UIPinchGestureRecognizer *reco))block {
    if (!block) {
        return;
    }

    objc_setAssociatedObject(self, _cmd, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self action:@selector(p_invoke:)];
}

- (void)p_invoke:(UIPinchGestureRecognizer *)sender {
    void(^block)(UIPinchGestureRecognizer *reco) = objc_getAssociatedObject(self, @selector(addActionBlock:));
    if (block) {
        //捏合时保持图片位置不变
        CGPoint location = [sender locationInView:sender.view.superview];
        sender.view.center = location;
        //通过手势的缩放比例改变图片的仿射变换矩阵
        sender.view.transform = CGAffineTransformScale(sender.view.transform, sender.scale, sender.scale);
        //重置手势缩放比例
        sender.scale = 1.0;
        
        block(sender);
    }
}

@end



@implementation UIRotationGestureRecognizer (Helper)

- (void)addActionBlock:(void(^)(UIRotationGestureRecognizer *reco))block {
    if (!block) {
        return;
    }

    objc_setAssociatedObject(self, _cmd, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self action:@selector(p_invoke:)];
}

- (void)p_invoke:(UIRotationGestureRecognizer *)sender {
    void(^block)(UIRotationGestureRecognizer *reco) = objc_getAssociatedObject(self, @selector(addActionBlock:));
    if (block) {
        //改变手势view的仿射变换矩阵
        sender.view.transform = CGAffineTransformRotate(sender.view.transform, sender.rotation);
        //重置弧度
        sender.rotation = 0;
        
        block(sender);
    }
}

@end

