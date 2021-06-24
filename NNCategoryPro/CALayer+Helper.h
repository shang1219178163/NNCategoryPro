//
//  CALayer+Helper.h
//  BNAlertView
//
//  Created by BIN on 2018/9/10.
//  Copyright © 2018年 SouFun. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CALayer (Helper)

- (void)getLayer;

- (void)removeAllSubLayers;

+ (CALayer *)createRect:(CGRect)rect image:(id)image;

- (CAShapeLayer *)createCircleLayer;

- (CAShapeLayer *)createAppCircleProgressWithStartAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle;

- (CAShapeLayer *)clipCorners:(UIRectCorner)corners radius:(CGFloat)radius;

- (void)addAnimation:(CAAnimation *)anim forKey:(NSString *)key anchorPoint:(CGPoint)anchorPoint;

- (void)addAnimationDefaultWithType:(NSNumber *)type;

- (void)addAnimationFadeDuration:(float)duration functionName:(CAMediaTimingFunctionName)functionName;

- (void)addAnimationFadeDuration:(float)duration;

- (void)addAnimationRotation;

- (CAShapeLayer *)addAnimMask:(NSString *)animKey;
- (CAShapeLayer *)addAnimPackup:(NSString *)animKey;
- (CAShapeLayer *)addAnimLoading:(NSString *)animKey duration:(CFTimeInterval)duration;

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


@interface CAGradientLayer (Helper)

+(CAGradientLayer *)layerWithRect:(CGRect)rect
                           colors:(NSArray *)colors
                            start:(CGPoint)start
                              end:(CGPoint)end;

@end


@interface CAEmitterLayer (Helper)

+(CAEmitterLayer *)layerWithSize:(CGSize)size positon:(CGPoint)position cells:(NSArray<CAEmitterCell *> *)cells;

+(CAEmitterLayer *)layerUpWithSize:(CGSize)size positon:(CGPoint)position images:(NSArray<NSString *> *)images;

+(CAEmitterLayer *)layerDownWithSize:(CGSize)size positon:(CGPoint)position images:(NSArray<NSString *> *)images;

+(CAEmitterLayer *)layerDownWithRect:(CGRect)rect images:(NSArray<NSString *> *)images;

+(CAEmitterLayer *)layerSparkWithRect:(CGRect)rect images:(NSArray<NSString *> *)images;

+(CAEmitterLayer *)layerUpWithRect:(CGRect)rect images:(NSArray<NSString *> *)images;

@end


@interface CAEmitterCell (Helper)

///向上的效果
+(CAEmitterCell *)cellWithUpContents:(nullable UIImage *)image emitterCells:(nullable NSArray<CAEmitterCell *> *)emitterCells;
///向下的效果
+(CAEmitterCell *)cellWithDownContents:(nullable UIImage *)image emitterCells:(nullable NSArray<CAEmitterCell *> *)emitterCells;

@end


NS_ASSUME_NONNULL_END
