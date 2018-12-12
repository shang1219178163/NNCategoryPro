//
//  BN_AnimationObject.h
//  ViewControllerTransitioning
//
//  Created by Baymax on 16/7/31.
//  Copyright © 2016年 Baymax. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface BN_AnimationObject : NSObject<CAAnimationDelegate,UIViewControllerAnimatedTransitioning>

@property (strong , nonatomic) id <UIViewControllerContextTransitioning> transitionContext;
//用于区别动画的方向，是跳转还是返回
@property (assign , nonatomic) UINavigationControllerOperation type;
//动画中小圆的位置
@property (assign , nonatomic) CGRect circleCenterRect;

@end
