//
//  UIView+ScreenEdgePan.h
//  ProductTemplet
//
//  Created by Bin Shang on 2019/1/4.
//  Copyright © 2019 BN. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (ScreenEdgePan)

@property (nonatomic, strong) UIView *showView;

- (void)addRecognizerEdgPan:(void(^)(UIScreenEdgePanGestureRecognizer *recognizer))block;

- (void)followScreenEdgePan:(UIScreenEdgePanGestureRecognizer *)recognizer;

@end

NS_ASSUME_NONNULL_END
