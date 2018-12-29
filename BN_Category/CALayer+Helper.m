//
//  CALayer+Helper.m
//  BN_AlertView
//
//  Created by BIN on 2018/9/10.
//  Copyright © 2018年 SouFun. All rights reserved.
//

#import "CALayer+Helper.h"

#import "NSObject+Helper.h"
#import "CABasicAnimation+Helper.h"

#import "CAShapeLayer+Helper.h"
#import "CAAnimationGroup+Helper.h"

@implementation CALayer (Helper)

- (void)getLayer{
    NSArray *subviews = self.sublayers;
    if (subviews.count == 0) return;
    for (CALayer *subview in subviews) {
        subview.borderWidth = 0.5;
        subview.borderColor = UIColor.blueColor.CGColor;
        //        subview.borderColor = UIColor.clearColor.CGColor;
        
        [subview getLayer];
        
    }
}

- (void)removeAllSubLayers{
    self.sublayers = nil;//sublayers不是可变数组
  
}


+ (CALayer *)createRect:(CGRect)rect image:(id)image{
    
    NSParameterAssert([image isKindOfClass:[NSString class]] || [image isKindOfClass:[UIImage class]]);
    if ([image isKindOfClass:[NSString class]]) {
        image = [UIImage imageNamed:image];
    }
    
    CALayer *layer = [CALayer layer];
    layer.frame = rect;
    
    layer.contents = (__bridge id _Nullable)(((UIImage *)image).CGImage);
    layer.contentsScale = UIScreen.mainScreen.scale;
    layer.rasterizationScale = YES;
    return layer;
}

- (CAShapeLayer *)createCircleLayer{
    
    CALayer *view = self;
    CAShapeLayer *layer = ({
        
        //创建矩形圆角正方形路径
        UIBezierPath * path   = [UIBezierPath bezierPathWithRoundedRect:view.bounds cornerRadius:0];
        
        //创建圆路径
        UIBezierPath * pathOutside = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, CGRectGetHeight(view.frame) , CGRectGetHeight(view.frame))];
        
        CGPoint point = CGPointMake(view.position.x - CGRectGetMinX(view.frame), view.position.y - CGRectGetMinY(view.frame));
        //内部弧路径
        UIBezierPath * pathInside  = [UIBezierPath bezierPathWithArcCenter:point
                                                                    radius:CGRectGetHeight(view.frame)*0.35
                                                                startAngle:1.5 * M_PI
                                                                  endAngle:1.8 * M_PI
                                                                 clockwise:NO];
        [pathInside addLineToPoint:point];
        [pathInside closePath];
        
        //合体
        [path appendPath:pathOutside];
        //        [path appendPath:pathInside];
        
        CAShapeLayer * layer = CAShapeLayer.layer;
        layer.frame         = view.bounds;
        layer.path           = path.CGPath;
        //        layer.fillColor      = [UIColor colorWithWhite:0 alpha:0.5].CGColor;
        layer.fillColor      = UIColor.whiteColor.CGColor;
        
        layer.fillRule       = kCAFillRuleEvenOdd;  //重点， 填充规则
        
        layer;
    });
    [view addSublayer:layer];
    return layer;
}

- (CAShapeLayer *)createAppCircleProgressWithStartAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle{
    
    CALayer *view = self;
    CAShapeLayer *layer = ({
        
        //创建矩形圆角正方形路径
        UIBezierPath * path   = [UIBezierPath bezierPathWithRoundedRect:view.bounds cornerRadius:0];
        
        //创建圆路径
        UIBezierPath * pathOutside = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, CGRectGetHeight(view.frame) , CGRectGetHeight(view.frame))];
        
        CGPoint point = CGPointMake(view.position.x - CGRectGetMinX(view.frame), view.position.y - CGRectGetMinY(view.frame));
        //内部弧路径
        UIBezierPath * pathInside  = [UIBezierPath bezierPathWithArcCenter:point
                                                                    radius:CGRectGetHeight(view.frame)*0.35
                                                                startAngle:startAngle
                                                                  endAngle:endAngle
                                                                 clockwise:NO];
        [pathInside addLineToPoint:point];
        [pathInside closePath];
        
        //合体
        [path appendPath:pathOutside];
        [path appendPath:pathInside];
        
        CAShapeLayer * layer = CAShapeLayer.layer;
        layer.frame         = view.bounds;
        layer.path           = path.CGPath;
        //        layer.fillColor      = [UIColor colorWithWhite:0 alpha:0.5].CGColor;
        layer.fillColor      = UIColor.whiteColor.CGColor;
        
        layer.fillRule       = kCAFillRuleEvenOdd;  //重点， 填充规则
        
        layer;
    });
    [view addSublayer:layer];
    return layer;
}

- (CAShapeLayer *)clipCorners:(UIRectCorner)corners radius:(CGFloat)radius{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                   byRoundingCorners:corners
                                                         cornerRadii:CGSizeMake(radius, radius)];
    // 创建遮罩层
    CAShapeLayer *maskLayer = CAShapeLayer.layer;
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;   // 轨迹
    self.mask = maskLayer;
    return (CAShapeLayer *)self;
}

- (void)addAnimation:(CAAnimation *)anim forKey:(NSString *)key anchorPoint:(CGPoint)anchorPoint{
    
//    anim.delegate = self;
//    anim.removedOnCompletio

    self.anchorPoint = anchorPoint;
    [self addAnimation:anim forKey:key];
    //    [self.layer removeAllAnimations];

}

- (void)addAnimationDefaultWithType:(NSNumber *)type{
    
    NSValue * fromValue = [NSValue valueWithCGPoint:self.position];
    // 终止位置
    NSValue * toValue = [NSValue valueWithCGPoint:CGPointMake(self.position.x + 100, self.position.y)];
    // 添加动画
    
    switch (type.integerValue) {
        case 1:
        {
            //move
            CABasicAnimation *animation = [CABasicAnimation animKeyPath:kTransformPosition duration:2.5 fromValue:fromValue toValue:toValue autoreverses:NO repeatCount:2];
            [self addAnimation:animation forKey:@"move"];

        }
            break;
        case 2:
        {
            //rotation
            CABasicAnimation *animation = [CABasicAnimation animKeyPath:kTransformRotationZ duration:2.5 fromValue:@(0.0) toValue:@(2 * M_PI) autoreverses:NO repeatCount:2];
            [self addAnimation:animation forKey:@"rotation"];
            
        }
            break;
        case 3:
        {
            //zoom
            CABasicAnimation *animation = [CABasicAnimation animKeyPath:kTransformScale duration:2.5 fromValue:@(1.0) toValue:@(1.5) autoreverses:NO repeatCount:2];
            [self addAnimation:animation forKey:@"scale"];
            
        }
            break;
        case 4:
        {
            //弹簧效果
            CASpringAnimation *animation = [CASpringAnimation animationWithKeyPath:@"position"];
            
            animation.beginTime = CACurrentMediaTime() + 1;// 1秒后执行
            animation.damping = 2;// 阻尼系数（此值越大弹框效果越不明显）
            animation.stiffness = 50;// 刚度系数（此值越大弹框效果越明显）
            animation.mass = 1;// 质量大小（越大惯性越大）
            animation.initialVelocity = 10;// 初始速度
            
            animation.fromValue = [NSValue valueWithCGPoint:self.position];// 开始位置
            animation.toValue = [NSValue valueWithCGPoint:CGPointMake(self.position.x, self.position.y + 50)];// 终止位置
            animation.duration = animation.settlingDuration;// 持续时间
            
            [self addAnimation:animation forKey:@"spring"];
        }
            break;
        case 5:
        {
            // 动画组
            CAAnimationGroup *group = [CALayer animationGroup];
            // 添加动画
            [self addAnimation:group forKey:@"group"];
            
        }
            break;
        case 6:
        {
           
            //永久闪烁
            CABasicAnimation *animation = [CABasicAnimation animKeyPath:kTransformOpacity duration:2.5 fromValue:@(1.0) toValue:@(0.0) autoreverses:NO repeatCount:MAXFLOAT];
            animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];///没有的话是均匀的动画。
            [self addAnimation:animation forKey:@"opacity"];
            
            
        }
            break;
        case 7:
        {
            //旋转
            CABasicAnimation *animation = [self rotation:2 degree:CGDegreesFromRadian(90) direction:1 repeatCount:CGFLOAT_MAX];
            [self addAnimation:animation forKey:nil];

        }
            break;
        case 8:
        {
            
            
            
        }
            break;
        default:
            break;
    }
    
}

+ (CAAnimationGroup *)animationGroup{
    // x方向平移
    CABasicAnimation *animation1 = [CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
    // 平移100
    animation1.toValue = @(100);
    
    // 绕Z轴中心旋转
    CABasicAnimation *animation2 = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    // 起始角度
    animation2.fromValue = [NSNumber numberWithFloat:0.0];
    // 终止角度
    animation2.toValue = [NSNumber numberWithFloat:2 * M_PI];
    
    // 比例缩放
    CABasicAnimation *animation3 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    // 终止scale
    animation3.toValue = @(0.5);
    
    // 动画组
    CAAnimationGroup *group = [CAAnimationGroup animation];
    // 1秒后执行
    group.beginTime = CACurrentMediaTime() + 1;
    // 持续时间
    group.duration = 2.5;
    // 重复次数
    group.repeatCount = 2;
    // 动画结束是否恢复原状
    group.removedOnCompletion = YES;
    // 动画组
    group.animations = [NSArray arrayWithObjects:animation1, animation2, animation3, nil];
    // 添加动画
    return group;
}


#pragma mark ====旋转动画======
- (CABasicAnimation *)rotation:(float)dur degree:(float)degree direction:(int)direction repeatCount:(int)repeatCount{
    CATransform3D rotationTransform = CATransform3DMakeRotation(degree, 0, 0, direction);
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation.toValue = [NSValue valueWithCATransform3D:rotationTransform];
    animation.duration  =  dur;
    animation.autoreverses = NO;
    animation.cumulative = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.repeatCount = repeatCount;
    
    return animation;
    
}


- (void)addAnimationRotation{
    CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    //让其在z轴旋转
    animation.toValue = @(M_PI*2.0);//旋转角度
    animation.duration = 1;//旋转周期
    animation.cumulative = YES;//旋转累加角度
    animation.repeatCount = CGFLOAT_MAX;//旋转次数
    animation.autoreverses = NO;
    //锚点设置为图片中心，绕中心抖动
    //    self.layer.anchorPoint = CGPointMake(0.5, 0.5);
    [self addAnimation:animation forKey:@"rotationAnimation"];
    
    //    [self.layer removeAllAnimations];
}

- (void)addAnimationRotationPath{
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    //矩形的中心就是圆心
    CGRect rect = CGRectMake(10, 20, 400, 300);
    anim.duration = 5;
    //绕此圆中心转
    anim.path = CFAutorelease(CGPathCreateWithEllipseInRect(rect, NULL));
    anim.calculationMode = kCAAnimationPaced;
    anim.rotationMode = kCAAnimationRotateAuto;
    [self addAnimation:anim forKey:@"round"];
}


#pragma mark- -addAnim

- (CAShapeLayer *)addAnimMask:(NSString *)animKey{
    CALayer *sender = self;
    CGPathRef path = [UIBezierPath bezierPathWithRect:CGRectMake(CGRectGetWidth(sender.bounds) / 2, 0, 1, CGRectGetHeight(sender.bounds))].CGPath;//不初始化则无动画效果
    CAShapeLayer *shapeLayer = [CAShapeLayer layerWithSender:sender path:path fillColor:UIColor.whiteColor strokeColor:UIColor.whiteColor opacity:0.3];
    [sender addSublayer:shapeLayer];
    
    
    CGPathRef toValue = [UIBezierPath bezierPathWithRect:sender.bounds].CGPath;
    CABasicAnimation *anim = [CABasicAnimation animKeyPath:kTransformPath duration:0.5 fromValue:nil toValue:(__bridge id)toValue autoreverses:NO repeatCount:1];
    [shapeLayer addAnimation:anim forKey:animKey];
    
    return shapeLayer;
}

- (CAShapeLayer *)addAnimPackup:(NSString *)animKey{
    CALayer *sender = self;
    
    CAShapeLayer *maskLayer = CAShapeLayer.layer;
    maskLayer.frame = sender.bounds;
    sender.mask = maskLayer;
    
    //path动画
    CGPoint point = CGPointMake(CGRectGetWidth(sender.bounds) / 2, CGRectGetHeight(sender.bounds) / 2);
    CGPathRef fromValue = [UIBezierPath bezierPathWithArcCenter:point radius:CGRectGetWidth(sender.bounds) / 2 startAngle:0 endAngle:M_PI * 2 clockwise:YES].CGPath;
    CGPathRef toValue = [UIBezierPath bezierPathWithArcCenter:point radius:1 startAngle:0 endAngle:M_PI * 2 clockwise:YES].CGPath;
    CABasicAnimation *pathAnim = [CABasicAnimation animKeyPath:kTransformPath duration:0.3 fromValue:(__bridge id)(fromValue) toValue:(__bridge id)(toValue) autoreverses:NO repeatCount:1];
    
    CAAnimationGroup *groupAnim = [CAAnimationGroup animList:@[pathAnim] duration:0.3 autoreverses:NO repeatCount:1];
    [maskLayer addAnimation:groupAnim forKey:animKey];
    
    return maskLayer;
}

- (CAShapeLayer *)addAnimLoading:(NSString *)animKey duration:(CFTimeInterval)duration{
    CALayer *sender = self;
    
    CAShapeLayer *shapeLayer =  ({
        CAShapeLayer *layer = CAShapeLayer.layer;
        layer.position = sender.position;
        layer.bounds = CGRectMake(0, 0, 50, 50);
        layer.backgroundColor = UIColor.clearColor.CGColor;
        layer.strokeColor = UIColor.redColor.CGColor;
        layer.fillColor = UIColor.clearColor.CGColor;
        layer.lineWidth = 5.f;
        UIBezierPath *storkePath = [UIBezierPath bezierPathWithOvalInRect:layer.bounds];
        layer.path = storkePath.CGPath;
        layer.strokeStart = 0;
        layer.strokeEnd = 0.1;
        
        layer;
    });
    
    [sender addSublayer:shapeLayer];
    
    //旋转动画
    CABasicAnimation *rotateAnim = [CABasicAnimation animKeyPath:kTransformRotationZ duration:1 fromValue:nil toValue:@(M_PI * 2) autoreverses:NO repeatCount:CGFLOAT_MAX];
    
    //stroke动画
    CABasicAnimation *storkeAnim = [CABasicAnimation animKeyPath:kTransformStrokeEnd duration:2.0 fromValue:nil toValue:@1 autoreverses:NO repeatCount:CGFLOAT_MAX];
    
    CAAnimationGroup *groupAnim = [CAAnimationGroup animList:@[rotateAnim, storkeAnim] duration:duration autoreverses:NO repeatCount:CGFLOAT_MAX];
    [shapeLayer addAnimation:groupAnim forKey:animKey];
    
    return shapeLayer;
    
}

@end
