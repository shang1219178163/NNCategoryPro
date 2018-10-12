//
//  CALayer+Helper.h
//  BN_AlertView
//
//  Created by hsf on 2018/9/10.
//  Copyright © 2018年 SouFun. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

@interface CALayer (Helper)

- (void)getLayer;

- (void)removeAllSubLayers;

+ (CALayer *)createRect:(CGRect)rect image:(id)image;

- (CAShapeLayer *)createCircleLayer;

- (CAShapeLayer *)createAppCircleProgressWithStartAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle;

- (CAShapeLayer *)clipCorners:(UIRectCorner)corners radius:(CGFloat)radius;

- (void)addAnimation:(CAAnimation *)anim forKey:(NSString *)key anchorPoint:(CGPoint)anchorPoint;

- (void)addAnimationDefaultWithType:(NSNumber *)type;

- (void)addAnimationRotation;


- (CAShapeLayer *)addAnimMask:(NSString *)animKey;
- (CAShapeLayer *)addAnimPackup:(NSString *)animKey;
- (CAShapeLayer *)addAnimLoading:(NSString *)animKey duration:(CFTimeInterval)duration;

@end
