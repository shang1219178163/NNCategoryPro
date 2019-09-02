//
//  UIView+ScreenEdgePan.m
//  ProductTemplet
//
//  Created by Bin Shang on 2019/1/4.
//  Copyright © 2019 BN. All rights reserved.
//

#import "UIView+ScreenEdgePan.h"
#import <objc/runtime.h>

@implementation UIView (ScreenEdgePan)

-(UIView *)showView{
    UIView * view = objc_getAssociatedObject(self, _cmd);
    if (!view) {
        UIView * view = [[UIView alloc]initWithFrame:UIScreen.mainScreen.bounds];
        view.backgroundColor = UIColor.redColor;
        view.alpha = .5;
        
        CGRect frame = view.frame;
        frame.origin.x = -CGRectGetWidth(UIScreen.mainScreen.bounds);// 将x值改成负的屏幕宽度,默认就在屏幕的左边
        view.frame = frame;
        //            // 因为该view是盖在所有的view身上,所以应该添加到window上
        [UIApplication.sharedApplication.keyWindow addSubview:view];
        
        // 添加轻扫手势  -- 滑回
        UISwipeGestureRecognizer *recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(closeShowView:)];
        recognizer.direction = UISwipeGestureRecognizerDirectionLeft;
        [view addGestureRecognizer:recognizer];
     
        objc_setAssociatedObject(self, _cmd, view, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return view;
}

- (void)setShowView:(UIView *)showView{
    objc_setAssociatedObject(self, @selector(showView), showView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)addRecognizerEdgPan:(void(^)(UIScreenEdgePanGestureRecognizer *recognizer))block{
    UIScreenEdgePanGestureRecognizer *recoginzer = objc_getAssociatedObject(self, _cmd);
    if (!recoginzer) {
        // 添加边缘手势
        UIScreenEdgePanGestureRecognizer *recoginzer = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(p_handleActionRecognizerEdgPan:)];
        // 指定左边缘滑动
        recoginzer.edges = UIRectEdgeLeft;

        self.userInteractionEnabled = true;
        [self addGestureRecognizer:recoginzer];

        objc_setAssociatedObject(self, _cmd, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
}

- (void)p_handleActionRecognizerEdgPan:(UIScreenEdgePanGestureRecognizer *)recognizer{
    void(^block)(UIScreenEdgePanGestureRecognizer *recognizer) = objc_getAssociatedObject(self, @selector(addRecognizerEdgPan:));
    if (block) block(recognizer);

    if (![UIApplication.sharedApplication.keyWindow.subviews containsObject:self.showView]) {
        [UIApplication.sharedApplication.keyWindow addSubview:self.showView];
    }
    [self followScreenEdgePan:recognizer];
}

- (void)followScreenEdgePan:(UIScreenEdgePanGestureRecognizer *)recognizer{
    // 让view跟着手指去移动
    // frame的x应该为多少??应该获取到手指的x值
    // 取到手势在当前控制器视图中识别的位置
    CGPoint point = [recognizer locationInView:self];
//    NSLog(@"%@", NSStringFromCGPoint(point));
    CGRect frame = self.showView.frame;
    // 更改adView的x值. 手指的位置 - 屏幕宽度
    frame.origin.x = point.x - CGRectGetWidth(UIScreen.mainScreen.bounds);
    self.showView.frame = frame;
    
    if (recognizer.state == UIGestureRecognizerStateEnded || recognizer.state == UIGestureRecognizerStateCancelled) {
        // 判断当前广告视图在屏幕上显示是否超过一半
        if (CGRectContainsPoint(self.frame, self.showView.center)) {
            // 如果超过,那么完全展示出来
            frame.origin.x = 0;
        }else{
            // 如果没有,隐藏
            frame.origin.x = -CGRectGetWidth(UIScreen.mainScreen.bounds);
        }
        [UIView animateWithDuration:0.25 animations:^{
            self.showView.frame = frame;
        }];
    }
}

- (void)closeShowView:(UISwipeGestureRecognizer *)recognizer {
    [UIView animateWithDuration:0.25 animations:^{
        CGRect frame = recognizer.view.frame;
        frame.origin.x = -CGRectGetWidth(UIScreen.mainScreen.bounds);
        recognizer.view.frame = frame;
    }];
}


@end
