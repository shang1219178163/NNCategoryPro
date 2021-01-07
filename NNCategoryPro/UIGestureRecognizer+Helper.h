//
//  UIGestureRecognizer+Helper.h
//  
//
//  Created by Bin Shang on 2019/1/4.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIGestureRecognizer (Helper)

@property (nonatomic, strong) NSString *funcName;

/// 动作回调
- (void)addActionBlock:(void(^)(UIGestureRecognizer *reco))block;

- (CGRect)cirlceRectBigCircle:(BOOL)bigCircle;

- (UIBezierPath *)pathBigCircle:(BOOL)bigCircle;

- (CAShapeLayer *)layerBigCircle:(BOOL)bigCircle;

@end

//
@interface UITapGestureRecognizer (Helper)

- (void)addActionBlock:(void(^)(UITapGestureRecognizer *reco))block;

@end


@interface UILongPressGestureRecognizer (Helper)

- (void)addActionBlock:(void(^)(UILongPressGestureRecognizer *reco))block;

@end


@interface UIPanGestureRecognizer (Helper)

- (void)addActionBlock:(void(^)(UIPanGestureRecognizer *reco))block;

@end



@interface UIScreenEdgePanGestureRecognizer (Helper)

- (void)addActionBlock:(void(^)(UIScreenEdgePanGestureRecognizer *reco))block ;

@end


@interface UISwipeGestureRecognizer (Helper)

- (void)addActionBlock:(void(^)(UISwipeGestureRecognizer *reco))block;

@end


@interface UIPinchGestureRecognizer (Helper)

- (void)addActionBlock:(void(^)(UIPinchGestureRecognizer *reco))block;

@end


@interface UIRotationGestureRecognizer (Helper)

- (void)addActionBlock:(void(^)(UIRotationGestureRecognizer *reco))block;

@end


NS_ASSUME_NONNULL_END
