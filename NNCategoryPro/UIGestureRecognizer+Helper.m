
//
//  UIGestureRecognizer+Helper.m
//  AESCrypt-ObjC
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

/**
 手势点返回的矩形
 */
- (CGRect)cirlceRectBigCircle:(BOOL)bigCircle{
    UIGestureRecognizer * recognizer = self;
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
