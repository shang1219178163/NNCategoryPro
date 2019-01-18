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

- (CGRect)cirlceRectBigCircle:(BOOL)bigCircle;

- (UIBezierPath *)pathBigCircle:(BOOL)bigCircle;

- (CAShapeLayer *)layerBigCircle:(BOOL)bigCircle;

@end

NS_ASSUME_NONNULL_END
