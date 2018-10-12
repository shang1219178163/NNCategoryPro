
//
//  UIView+Animation.m
//  HuiZhuBang
//
//  Created by BIN on 2018/5/9.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//

#import "UIView+Animation.h"

#import <objc/runtime.h>
#import "NSMutableArray+Helper.h"
#import "CALayer+Helper.h"
#import "UIImage+Helper.h"

#import "CAAnimationGroup+Helper.h"
#import "CABasicAnimation+Helper.h"
#import "CAKeyframeAnimation+Helper.h"


@interface UIView()<CAAnimationDelegate>

@end

@implementation UIView (Animation)

- (void)BN_aimationBigValues:(NSArray *)values{
    
    values = values ? : @[@1.6,];
    
    NSTimeInterval duration = 1.0/(values.count + 1);
    __block NSTimeInterval start;
    
    [UIView animateKeyframesWithDuration:0.5 delay:0 options:UIViewKeyframeAnimationOptionLayoutSubviews animations:^{
        for (NSInteger i = 0; i < values.count; i++) {
            CGFloat scale = [values[i] floatValue];
            
            start = i > 0 ? start + duration : 0;
            [UIView addKeyframeWithRelativeStartTime:start relativeDuration:duration animations:^{
                self.transform = CGAffineTransformMakeScale(scale, scale);
                
            }];
        }
        
        [UIView addKeyframeWithRelativeStartTime:start relativeDuration:duration animations:^{
            self.transform = CGAffineTransformIdentity;
            
        }];
        
    } completion:nil];
    
}

- (CAAnimationGroup *)addAnimationBigShapeWithColor:(UIColor *)color{
    UIColor *stroke = color ? : UIColor.redColor;
    UIView * view = self;
    CABasicAnimation *borderAnim = [CABasicAnimation animationWithKeyPath:@"borderColor"];
    borderAnim.fromValue = (id)UIColor.clearColor.CGColor;
    borderAnim.toValue = (id)UIColor.redColor.CGColor;
    borderAnim.duration = 0.5f;
    [view.layer addAnimation:borderAnim forKey:nil];
    
    
    CGRect pathFrame = CGRectMake(-CGRectGetMidX(view.bounds), -CGRectGetMidY(view.bounds), view.bounds.size.width, view.bounds.size.height);
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:pathFrame cornerRadius:view.layer.cornerRadius];
    
    // accounts for left/right offset and contentOffset of scroll view
    CGPoint shapePosition = [view.superview.superview convertPoint:view.center fromView:view.superview];
    
    CAShapeLayer *circleShape = CAShapeLayer.layer;
    circleShape.path = path.CGPath;
    circleShape.position = shapePosition;
    circleShape.fillColor = stroke.CGColor;
    circleShape.opacity = 0;
    circleShape.strokeColor = stroke.CGColor;
    circleShape.lineWidth = 2;
    
    [view.superview.superview.layer addSublayer:circleShape];
    
    CABasicAnimation *scaleAnim = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnim.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    scaleAnim.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(2.5, 2.5, 1)];
    
    CABasicAnimation *alphaAnim = [CABasicAnimation animationWithKeyPath:@"opacity"];
    alphaAnim.fromValue = @1;
    alphaAnim.toValue = @0;
    
    CAAnimationGroup *groupAnim = [CAAnimationGroup animation];
    groupAnim.animations = @[scaleAnim, alphaAnim];
    groupAnim.duration = 0.5f;
    groupAnim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    [circleShape addAnimation:groupAnim forKey:nil];
    return groupAnim;
}

- (void)animationWithTransition:(UIViewAnimationTransition)transition duration:(CGFloat)duration{
    [UIView animateWithDuration:duration animations:^{
        // 详见UIViewAnimationCurve
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationTransition:transition forView:self cache:YES];
        
    }];
}

- (void)addAnimLoginHandler:(void(^)(void))handler{
    UIView *sender = self;
    CALayer *layer0 = [sender.layer addAnimMask:@"mask"];
    CAAnimation * anim0 = [layer0 animationForKey:@"mask"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(anim0.duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [layer0 removeFromSuperlayer];
        
        CALayer *layer1 = [sender.layer addAnimPackup:@"Packup"];
        CAAnimation * anim1 = [layer1 animationForKey:@"Packup"];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(anim1.duration* NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [layer1 removeFromSuperlayer];
            sender.hidden = YES;
            CALayer *layer2 = [sender.superview.layer addAnimLoading:@"loading" duration:3];
            CAAnimation * anim2 = [layer2 animationForKey:@"loading"];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(anim2.duration* NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [layer2 removeAllAnimations];
                [layer2 removeFromSuperlayer];
                
                sender.hidden = NO;
                
                handler();
            });
        });
    });
    
}

#pragma mark - - ShopingCart

- (NSMutableArray *)keepList{
    NSMutableArray * list = objc_getAssociatedObject(self, _cmd);
    if (list == nil) {
        list = [NSMutableArray array];
        objc_setAssociatedObject(self, _cmd, list, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
    }
    return list;
}

-(void)setKeepList:(NSMutableArray *)keepList{
    objc_setAssociatedObject(self, @selector(keepList), keepList, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(NSMutableArray *)cacheList{
    NSMutableArray * list = objc_getAssociatedObject(self, _cmd);
    if (list == nil) {
        list = [NSMutableArray array];
        objc_setAssociatedObject(self, _cmd, list, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
    }
    return list;
}

- (void)setCacheList:(NSMutableArray *)cacheList{
    objc_setAssociatedObject(self, @selector(cacheList), cacheList, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CALayer *)shipLabyerWithList:(NSMutableArray *)cacheList sender:(UIView *)sender{
    UIImage * image = [UIImage screenshotFromView:sender];

    CALayer *shipLabyer = nil;
    if (cacheList.count > 0) {
        shipLabyer = cacheList.firstObject;
        [cacheList removeObject:shipLabyer];
    }
    else {
        
        shipLabyer = CALayer.layer;
        shipLabyer.contentsScale = UIScreen.mainScreen.scale;
        shipLabyer.opacity = 1.0;
//        shipLabyer.backgroundColor = UIColor.redColor.CGColor;
        //        shipLabyer.frame = sender.frame;
        //        shipLabyer.transform = CATransform3DMakeRotation(M_PI_2, 0, 0, 1);
    }
    shipLabyer.contents = (__bridge id _Nullable)(image.CGImage);
    //    shipLabyer.backgroundColor = sender.backgroundColor.CGColor;
    //    shipLabyer.backgroundColor = UIColor.cyanColor.CGColor;
    shipLabyer.backgroundColor = sender.noClearColor.CGColor;
    return shipLabyer;
}

- (UIColor *)noClearColor{
    UIView *view = self;
    
    UIView * supView = view.superview;
    while (CGColorEqualToColor(supView.backgroundColor.CGColor, UIColor.clearColor.CGColor)) {
        supView = supView.superview;
        
    }
    UIColor * color = supView.backgroundColor;
    return color;
    
}


- (CAAnimationGroup *)addAnimCartWithSender:(UIView *)sender pointEnd:(CGPoint)pointEnd{
    CGRect rect = [self convertRect:sender.frame fromView:sender.superview];
    //    DDLog(@"%@_%@_%@",NSStringFromCGRect(rect),NSStringFromCGPoint(sender.center),NSStringFromCGPoint(sender.layer.position));
    
    CALayer *shipLabyer = [self shipLabyerWithList:self.cacheList sender:sender];
    shipLabyer.frame = rect;
    
    [self.layer addSublayer:shipLabyer];
    [self.keepList addObject:shipLabyer];
    
    CGPoint start = sender.center;
    CGPoint end = pointEnd;
    CGFloat cpx = (start.x + end.x)/2.0;
    CGFloat cpy = -30;
    
    //    创建一个CGPathRef对象，就是动画的路线
    CGMutablePathRef pathRef = CGPathCreateMutable();
    //    设置开始位置
    CGPathMoveToPoint(pathRef, NULL, sender.center.x, sender.center.y);//移动到起始点
    CGPathAddQuadCurveToPoint(pathRef, NULL, cpx, cpy, end.x, end.y);//添加移动曲线
    //CGPathAddCurveToPoint(pathRef, nil, CGFloat cp1x, CGFloat cp1y, CGFloat cp2x, CGFloat cp2y, CGFloat x, CGFloat y)
    
    //路径动画
    CAKeyframeAnimation *keyframeAnim = [CAKeyframeAnimation animPath:pathRef duration:1 autoreverses:NO repeatCount:1];
    
    //旋转动画
    CABasicAnimation* rotationAnim = [CABasicAnimation animKeyPath:kTransformRotationZ duration:1.5 fromValue:@(0) toValue:@(M_PI * 2.0) autoreverses:NO repeatCount:1 fillMode:kCAFillModeForwards removedOnCompletion:NO functionName:kCAMediaTimingFunctionEaseIn];
    
    //缩放动画
    CABasicAnimation* scaleAnim = [CABasicAnimation animKeyPath:kTransformScale duration:1.5 fromValue:@(1.0) toValue:@(0.1) autoreverses:NO repeatCount:1 fillMode:kCAFillModeForwards removedOnCompletion:NO functionName:kCAMediaTimingFunctionEaseIn];
    
    NSArray * animList = @[keyframeAnim,rotationAnim,scaleAnim];
    CAAnimationGroup * groupAnim = [CAAnimationGroup animList:animList duration:1.5 autoreverses:NO repeatCount:1];
    groupAnim.delegate = self;
    [shipLabyer addAnimation:groupAnim forKey:@"groupAnim"];
    return groupAnim;
}
#pragma mark - -CAAnimation
- (void)animationDidStart:(CAAnimation *)anim{
    
    
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
   
    CALayer *layer = self.keepList.firstObject;
    [layer removeAllAnimations];
    [self.cacheList addSafeObjct:layer];
    [layer removeFromSuperlayer];
    [self.keepList removeObject:layer];
    
    
}


@end
