//
//  UIGestureRecognizer+Helper.h
//  AESCrypt-ObjC
//
//  Created by Bin Shang on 2019/1/4.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIGestureRecognizer (Helper)

@property (nonatomic, strong) NSString *funcName;
/// 动作回调属性
//@property(nonatomic, copy) void(^actionBlock)(UIGestureRecognizer *reco);
/// 动作回调
- (void)addActionBlock:(void(^)(UIGestureRecognizer *reco))actionBlock;

- (CGRect)cirlceRectBigCircle:(BOOL)bigCircle;

- (UIBezierPath *)pathBigCircle:(BOOL)bigCircle;

- (CAShapeLayer *)layerBigCircle:(BOOL)bigCircle;

@end

NS_ASSUME_NONNULL_END
