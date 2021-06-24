//
//  CALayer+Helper.m
//  BNAlertView
//
//  Created by BIN on 2018/9/10.
//  Copyright © 2018年 SouFun. All rights reserved.
//

#import "CALayer+Helper.h"
#import "NSObject+Helper.h"
#import "CABasicAnimation+Helper.h"

@implementation CALayer (Helper)

- (void)getLayer{
#if DEBUG
    NSArray *subviews = self.sublayers;
    if (subviews.count == 0) return;
    for (CALayer *subview in subviews) {
        subview.borderWidth = 0.5;
        subview.borderColor = UIColor.blueColor.CGColor;
        [subview getLayer];
    }
#endif
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
        
        CAShapeLayer *layer = CAShapeLayer.layer;
        layer.frame = view.bounds;
        layer.path  = path.CGPath;
        //        layer.fillColor      = [UIColor colorWithWhite:0 alpha:0.5].CGColor;
        layer.fillColor = UIColor.whiteColor.CGColor;
        
        layer.fillRule  = kCAFillRuleEvenOdd;  //重点， 填充规则
        
        layer;
    });
    [view addSublayer:layer];
    return layer;
}

- (CAShapeLayer *)createAppCircleProgressWithStartAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle{
    
    CALayer *view = self;
    CAShapeLayer *layer = ({
        
        //创建矩形圆角正方形路径
        UIBezierPath *path   = [UIBezierPath bezierPathWithRoundedRect:view.bounds cornerRadius:0];
        
        //创建圆路径
        UIBezierPath *pathOutside = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, CGRectGetHeight(view.frame) , CGRectGetHeight(view.frame))];
        
        CGPoint point = CGPointMake(view.position.x - CGRectGetMinX(view.frame), view.position.y - CGRectGetMinY(view.frame));
        //内部弧路径
        UIBezierPath *pathInside  = [UIBezierPath bezierPathWithArcCenter:point
                                                                    radius:CGRectGetHeight(view.frame)*0.35
                                                                startAngle:startAngle
                                                                  endAngle:endAngle
                                                                 clockwise:NO];
        [pathInside addLineToPoint:point];
        [pathInside closePath];
        
        //合体
        [path appendPath:pathOutside];
        [path appendPath:pathInside];
        
        CAShapeLayer *layer = CAShapeLayer.layer;
        layer.frame = view.bounds;
        layer.path  = path.CGPath;
//        layer.fillColor      = [UIColor colorWithWhite:0 alpha:0.5].CGColor;
        layer.fillColor = UIColor.whiteColor.CGColor;
        
        layer.fillRule  = kCAFillRuleEvenOdd;  //重点， 填充规则
        
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
    
    NSValue *fromValue = [NSValue valueWithCGPoint:self.position];
    // 终止位置
    NSValue *toValue = [NSValue valueWithCGPoint:CGPointMake(self.position.x + 100, self.position.y)];
    // 添加动画
    
    switch (type.integerValue) {
        case 1:
        {
            //move
            CABasicAnimation *animation = [CABasicAnimation animKeyPath:kTransformPosition
                                                               duration:2.5
                                                              fromValue:fromValue
                                                                toValue:toValue
                                                           autoreverses:NO
                                                            repeatCount:2];
            [self addAnimation:animation forKey:@"move"];

        }
            break;
        case 2:
        {
            //rotation
            CABasicAnimation *animation = [CABasicAnimation animKeyPath:kTransformRotationZ
                                                               duration:2.5
                                                              fromValue:@(0.0)
                                                                toValue:@(2 * M_PI)
                                                           autoreverses:NO
                                                            repeatCount:2];
            [self addAnimation:animation forKey:@"rotation"];
            
        }
            break;
        case 3:
        {
            //zoom
            CABasicAnimation *animation = [CABasicAnimation animKeyPath:kTransformScale
                                                               duration:2.5
                                                              fromValue:@(1.0)
                                                                toValue:@(1.5)
                                                           autoreverses:NO
                                                            repeatCount:2];
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
            CABasicAnimation *animation = [CABasicAnimation
                                           animKeyPath:kTransformOpacity
                                           duration:2.5
                                           fromValue:@(1.0)
                                           toValue:@(0.0)
                                           autoreverses:NO
                                           repeatCount:MAXFLOAT];
            animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];///没有的话是均匀的动画。
            [self addAnimation:animation forKey:@"opacity"];
        }
            break;
        case 7:
        {
            //旋转
            CABasicAnimation *animation = [self rotation:2
                                                  degree:CGDegreesFromRadian(90)
                                               direction:1
                                             repeatCount:CGFLOAT_MAX];
            [self addAnimation:animation forKey:nil];

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
- (CABasicAnimation *)rotation:(float)dur
                        degree:(float)degree
                     direction:(int)direction
                   repeatCount:(int)repeatCount{
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


- (void)addAnimationFadeDuration:(float)duration functionName:(CAMediaTimingFunctionName)functionName{
    CATransition *transition = [[CATransition alloc] init];
      
    bool isValid = [CABasicAnimation.functionNames containsObject:functionName];
    transition.timingFunction = [CAMediaTimingFunction functionWithName: isValid ? functionName : kCAMediaTimingFunctionEaseIn];
    transition.type = kCATransitionFade;
    transition.duration = 0.5;
    transition.removedOnCompletion = YES;
    [self addAnimation:transition forKey:@"change_view_controller"];

//    UIWindow *keyWindow = UIApplication.sharedApplication.delegate.window;
//    [keyWindow.layer addAnimation:transition forKey:@"change_view_controller"];
}

- (void)addAnimationFadeDuration:(float)duration{
    [self addAnimationFadeDuration:duration functionName:kCAMediaTimingFunctionEaseIn];
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
    CAShapeLayer *shapeLayer = [CAShapeLayer layerWithSender:sender
                                                        path:path
                                                   fillColor:UIColor.whiteColor
                                                 strokeColor:UIColor.whiteColor
                                                     opacity:0.3];
    [sender addSublayer:shapeLayer];
    
    
    CGPathRef toValue = [UIBezierPath bezierPathWithRect:sender.bounds].CGPath;
    CABasicAnimation *anim = [CABasicAnimation animKeyPath:kTransformPath
                                                  duration:0.5
                                                 fromValue:nil
                                                   toValue:(__bridge id)toValue
                                              autoreverses:NO
                                               repeatCount:1];
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
    CABasicAnimation *pathAnim = [CABasicAnimation animKeyPath:kTransformPath
                                                      duration:0.3
                                                     fromValue:(__bridge id)(fromValue)
                                                       toValue:(__bridge id)(toValue)
                                                  autoreverses:NO
                                                   repeatCount:1];
    
    CAAnimationGroup *groupAnim = [CAAnimationGroup animList:@[pathAnim]
                                                    duration:0.3
                                                autoreverses:NO
                                                 repeatCount:1];
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
    CABasicAnimation *rotateAnim = [CABasicAnimation animKeyPath:kTransformRotationZ
                                                        duration:1
                                                       fromValue:nil
                                                         toValue:@(M_PI * 2)
                                                    autoreverses:NO
                                                     repeatCount:CGFLOAT_MAX];
    
    //stroke动画
    CABasicAnimation *storkeAnim = [CABasicAnimation animKeyPath:kTransformStrokeEnd
                                                        duration:2.0
                                                       fromValue:nil
                                                         toValue:@1
                                                    autoreverses:NO
                                                     repeatCount:CGFLOAT_MAX];
    
    CAAnimationGroup *groupAnim = [CAAnimationGroup animList:@[rotateAnim, storkeAnim]
                                                    duration:duration
                                                autoreverses:NO
                                                 repeatCount:CGFLOAT_MAX];
    [shapeLayer addAnimation:groupAnim forKey:animKey];
    
    return shapeLayer;
}

@end


@implementation CAShapeLayer (Helper)

+(CAShapeLayer *)layerWithRect:(CGRect)rect
                          path:(CGPathRef)path
                     strokeEnd:(CGFloat)strokeEnd
                     fillColor:(UIColor *)fillColor
                   strokeColor:(UIColor *)strokeColor
                     lineWidth:(CGFloat)lineWidth{
    
    //初始化一个实例对象
    CAShapeLayer *layer = CAShapeLayer.layer;
    
    layer.frame        = rect;  //设置大小
    //        layer.position      = self.view.center;            //设置中心位置
    layer.path          = [UIBezierPath bezierPathWithOvalInRect:layer.bounds].CGPath; //设置绘制路径
    layer.strokeEnd     = strokeEnd;        //设置轮廓结束位置
    layer.fillColor     = fillColor.CGColor;   //设置填充颜色
    layer.strokeColor   = strokeColor.CGColor;      //设置划线颜色
    layer.lineWidth     = lineWidth;          //设置线宽
    layer.lineCap       = @"round";    //设置线头形状
    return layer;
}

+(CAShapeLayer *)layerWithSender:(CALayer *)sender
                            path:(CGPathRef)path
                       fillColor:(UIColor *)fillColor
                     strokeColor:(UIColor *)strokeColor
                         opacity:(CGFloat)opacity{
    
    //初始化一个实例对象
    CAShapeLayer *layer = CAShapeLayer.layer;
    layer.frame        = sender.bounds;;  //设置大小
    //        layer.position      = self.view.center;            //设置中心位置
    layer.fillColor     = fillColor.CGColor;   //设置填充颜色
    layer.strokeColor   = strokeColor.CGColor;      //设置划线颜色
    layer.backgroundColor = UIColor.clearColor.CGColor;
    
    layer.opacity = opacity;
    layer.path = path;
    
    return layer;
}

/**
 虚线边框
 */
+(CAShapeLayer *)layerLineDashWithSender:(CALayer *)sender
                             strokeColor:(UIColor *)strokeColor
                               lineWidth:(CGFloat)lineWidth
                         lineDashPattern:(NSArray<NSNumber *> *)lineDashPattern{

    CAShapeLayer *layer = CAShapeLayer.layer;
    layer.strokeColor = strokeColor.CGColor;
    layer.fillColor = nil;
    
    layer.path = [UIBezierPath bezierPathWithRect:sender.bounds].CGPath;
    layer.frame = sender.bounds;
    
    layer.lineCap = @"square";
    layer.lineWidth = lineWidth > 0.0 ? lineWidth : 1.0;
    layer.lineDashPattern = lineDashPattern ? : @[@4, @2];
    [sender addSublayer:layer];
    return layer;
}

+(CAShapeLayer *)layerWithPath:(UIBezierPath *)path{
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.path = path.CGPath;
    return layer;
}

@end


@interface CAShapeLayer (Helper)

+(CAShapeLayer *)layerWithRect:(CGRect)rect
                          path:(CGPathRef)path
                     strokeEnd:(CGFloat)strokeEnd
                     fillColor:(UIColor *)fillColor
                   strokeColor:(UIColor *)strokeColor
                     lineWidth:(CGFloat)lineWidth;

+(CAShapeLayer *)layerWithSender:(CALayer *)sender
                            path:(CGPathRef)path
                       fillColor:(UIColor *)fillColor
                     strokeColor:(UIColor *)strokeColor
                         opacity:(CGFloat)opacity;

+(CAShapeLayer *)layerLineDashWithSender:(CALayer *)sender
                             strokeColor:(UIColor *)strokeColor
                               lineWidth:(CGFloat)lineWidth
                         lineDashPattern:(NSArray<NSNumber *> *)lineDashPattern;

+(CAShapeLayer *)layerWithPath:(UIBezierPath *)path;

@end


@implementation CAGradientLayer (Helper)

+(CAGradientLayer *)layerWithRect:(CGRect)rect
                           colors:(NSArray *)colors
                            start:(CGPoint)start
                              end:(CGPoint)end{
    
    CAGradientLayer *layer = CAGradientLayer.layer;
    layer.frame = rect;
    layer.colors = colors;
    //45度变色(由lightColor－>white)
    layer.startPoint = start;
    layer.endPoint = end;

    return layer;
}

@end


@implementation CAEmitterLayer (Helper)

+ (CAEmitterLayer *)layerWithSize:(CGSize)size positon:(CGPoint)position cells:(NSArray<CAEmitterCell *> *)cells{
    
    CAEmitterLayer *emitterLayer = CAEmitterLayer.layer;
    
    emitterLayer.emitterSize = size;//发射器大小，因为emitterShape设置成线性所以高度可以设置成0，
    emitterLayer.emitterPosition = position;//发射器中心点

    emitterLayer.emitterShape = kCAEmitterLayerLine;//发射器形状为线性
    emitterLayer.emitterMode = kCAEmitterLayerOutline;//从发射器边缘发出
    emitterLayer.renderMode = kCAEmitterLayerAdditive;//混合渲染效果

    emitterLayer.emitterCells = cells;//设置粒子组
    return emitterLayer;
}

+(CAEmitterLayer *)layerUpWithSize:(CGSize)size positon:(CGPoint)position images:(NSArray<NSString *> *)images{
    NSMutableArray *marr = [NSMutableArray array];
    [images enumerateObjectsUsingBlock:^(NSString *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CAEmitterCell *cell = [CAEmitterCell cellWithUpContents:[UIImage imageNamed:obj] emitterCells:nil];
        [marr addObject:cell];
    }];
    
    CAEmitterLayer *layer = [CAEmitterLayer layerWithSize:size positon:position cells:marr.copy];
    return layer;
}

+(CAEmitterLayer *)layerDownWithSize:(CGSize)size positon:(CGPoint)position images:(NSArray<NSString *> *)images{
    NSMutableArray *marr = [NSMutableArray array];
    [images enumerateObjectsUsingBlock:^(NSString *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CAEmitterCell *cell = [CAEmitterCell cellWithUpContents:[UIImage imageNamed:obj] emitterCells:nil];
        [marr addObject:cell];
    }];
    
    CAEmitterLayer *layer = [CAEmitterLayer layerWithSize:size positon:position cells:marr.copy];
    return layer;
}

+(CAEmitterLayer *)layerDownWithRect:(CGRect)rect images:(NSArray<NSString *> *)images{
    CGSize emitterSize = CGSizeMake(CGRectGetWidth(rect), 0);
    CGPoint emitterPosition = CGPointMake(rect.size.width/2, rect.size.height - 60);
    CAEmitterLayer *emitterLayer = [CAEmitterLayer layerDownWithSize:emitterSize positon:emitterPosition images:images];
    return emitterLayer;
}

+(CAEmitterLayer *)layerSparkWithRect:(CGRect)rect images:(NSArray<NSString *> *)images{
    
    CAEmitterLayer *emitterLayer = CAEmitterLayer.layer;
    //烟花效果
    // 发射源
    emitterLayer.emitterPosition   = CGPointMake(rect.size.width/2, rect.size.height - 50);
    // 发射源尺寸大小
    emitterLayer.emitterSize       = CGSizeMake(50, 0);
    // 发射源模式
    emitterLayer.emitterMode       = kCAEmitterLayerOutline;
    // 发射源的形状
    emitterLayer.emitterShape      = kCAEmitterLayerLine;
    // 渲染模式
    emitterLayer.renderMode        = kCAEmitterLayerAdditive;
    // 发射方向
    emitterLayer.velocity          = 1;
    // 随机产生粒子
    emitterLayer.seed              = (arc4random() % 100) + 1;
    
    // rocket
    CAEmitterCell *rocket             = CAEmitterCell.emitterCell;
    // 速率
    rocket.birthRate                  = 1.0;
    // 发射的角度
    rocket.emissionRange              = 0.11 * M_PI;
    // 速度
    rocket.velocity                   = 300;
    // 范围
    rocket.velocityRange              = 150;
    // Y轴 加速度分量
    rocket.yAcceleration              = 75;
    // 声明周期
    rocket.lifetime                   = 2.04;
    //是个CGImageRef的对象,既粒子要展现的图片
    NSString * rocketName = images[0] ? : @"point";
    rocket.contents                   = (id)[[UIImage imageNamed:rocketName] CGImage];
    // 缩放比例
    rocket.scale                      = 0.2;
    // 粒子的颜色
    rocket.color                      = [[UIColor colorWithRed:0.6
                                                       green:0.6
                                                        blue:0.6
                                                       alpha:1.0] CGColor];
    // 一个粒子的颜色green 能改变的范围
    rocket.greenRange                 = 1.0;
    // 一个粒子的颜色red 能改变的范围
    rocket.redRange                   = 1.0;
    // 一个粒子的颜色blue 能改变的范围
    rocket.blueRange                  = 1.0;
    // 子旋转角度范围
    rocket.spinRange                  = M_PI;
    
    // 爆炸
    CAEmitterCell *burst            = CAEmitterCell.emitterCell;
    // 粒子产生系数
    burst.birthRate                 = 1.0;
    // 速度
    burst.velocity                  = 0;
    // 缩放比例
    burst.scale                     = 2.5;
    // shifting粒子red在生命周期内的改变速度
    burst.redSpeed                  = -1.5;
    // shifting粒子blue在生命周期内的改变速度
    burst.blueSpeed                 = +1.5;
    // shifting粒子green在生命周期内的改变速度
    burst.greenSpeed                = +1.0;
    //生命周期
    burst.lifetime                  = 0.35;
    
    
    // 火花 and finally, the sparks
    CAEmitterCell *spark            = CAEmitterCell.emitterCell;
    //粒子产生系数，默认为1.0
    spark.birthRate                 = 400;
    //速度
    spark.velocity                  = 125;
    // 360 deg//周围发射角度
    spark.emissionRange             = 2 * M_PI;
    // gravity//y方向上的加速度分量
    spark.yAcceleration             = 75;
    //粒子生命周期
    spark.lifetime                  = 3;
    //是个CGImageRef的对象,既粒子要展现的图片
    NSString * sparkName            = images[1] ? : @"spark";
    spark.contents                  = (id) [[UIImage imageNamed:sparkName] CGImage];
    //缩放比例速度
    spark.scaleSpeed                = -0.2;
    //粒子green在生命周期内的改变速度
    spark.greenSpeed                = -0.1;
    //粒子red在生命周期内的改变速度
    spark.redSpeed                  = 0.4;
    //粒子blue在生命周期内的改变速度
    spark.blueSpeed                 = -0.1;
    //粒子透明度在生命周期内的改变速度
    spark.alphaSpeed                = -0.25;
    //子旋转角度
    spark.spin                      = 2* M_PI;
    //子旋转角度范围
    spark.spinRange                 = 2* M_PI;
    
    // 3种粒子组合，可以根据顺序，依次烟花弹－烟花弹粒子爆炸－爆炸散开粒子
    emitterLayer.emitterCells    = [NSArray arrayWithObject:rocket];
    rocket.emitterCells          = [NSArray arrayWithObject:burst];
    burst.emitterCells           = [NSArray arrayWithObject:spark];

    return emitterLayer;
}

+(CAEmitterLayer *)layerUpWithRect:(CGRect)rect images:(NSArray<NSString *> *)images{
    CGSize emitterSize = CGSizeMake(CGRectGetWidth(rect), 0);//发射器大小，因为emitterShape设置成线性所以高度可以设置成0，
    CGPoint emitterPosition = CGPointMake(CGRectGetWidth(rect)/2.0, 0);//发射器
    CAEmitterLayer *emitterLayer = [CAEmitterLayer layerUpWithSize:emitterSize positon:emitterPosition images:images];
    return emitterLayer;
}

@end


@implementation CAEmitterCell (Helper)

+ (CAEmitterCell *)cellWithUpContents:(UIImage *)image emitterCells:(NSArray<CAEmitterCell *> *)emitterCells{
    CAEmitterCell *cell = CAEmitterCell.emitterCell;
    if (image) {
        cell.contents = image;//粒子图片
    }
    cell.emitterCells = emitterCells;

    //火苗
    cell.birthRate = 15;
    cell.lifetime = 6;

    cell.velocity = 10;
    cell.velocityRange = 10;

    cell.emissionRange = 0;
    
    cell.scale = 0.5;
    cell.scaleRange = 0.2;

    cell.alphaSpeed = -0.2;//透明度改变速度
    return cell;
}

+ (CAEmitterCell *)cellWithDownContents:(UIImage *)image emitterCells:(NSArray<CAEmitterCell *> *)emitterCells{
    CAEmitterCell *cell = CAEmitterCell.emitterCell;
    if (image) {
        cell.contents = image;//粒子图片
    }
    cell.emitterCells = emitterCells;

    //落叶/下雪/下红包
    cell.birthRate = 2;//粒子产生速度
    cell.lifetime = 50;//粒子存活时间
    
    cell.velocity = 10;//初始速度
    cell.velocityRange = 5;//初始速度的差值区间，所以初始速度为5~15，后面属性range算法相同
    
    cell.yAcceleration = 2;//y轴方向的加速度，落叶下飘只需要y轴正向加速度。
    
    cell.spin = 1.0;//粒子旋转速度
    cell.spinRange = 2.0;//粒子旋转速度范围
    
    cell.emissionRange = M_PI;//粒子发射角度范围
    
    cell.scale = 0.3;//缩放比例
    cell.scaleRange = 0.2;//缩放比例
    return cell;
}

@end

