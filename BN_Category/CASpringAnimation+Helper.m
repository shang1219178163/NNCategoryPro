//
//  CASpringAnimation+Helper.m
//  
//
//  Created by BIN on 2018/9/18.
//  Copyright © 2018年 SHANG. All rights reserved.
//

#import "CASpringAnimation+Helper.h"

@implementation CASpringAnimation (Helper)


//+(CASpringAnimation *)animKeyPath:(NSString *)keyPath duration:(CFTimeInterval)duration fromValue:(id)fromValue toValue:(id)toValue autoreverses:(BOOL)autoreverses repeatCount:(float)repeatCount fillMode:(NSString *)fillMode removedOnCompletion:(BOOL)removedOnCompletion{
//    
//    // 位置移动
//    CASpringAnimation *anim = [CASpringAnimation animKeyPath:@"position"];
//    // 1秒后执行
//    anim.beginTime = CACurrentMediaTime() + 1;
//    // 阻尼系数（此值越大弹框效果越不明显）
//    anim.damping = 2;
//    // 刚度系数（此值越大弹框效果越明显）
//    anim.stiffness = 50;
//    // 质量大小（越大惯性越大）
//    anim.mass = 1;
//    // 初始速度
//    anim.initialVelocity = 10;
//    // 开始位置
//    anim.fromValue = fromValue;
//    anim.toValue = toValue;
//    // 终止位置
//    // 持续时间
//    anim.duration = anim.settlingDuration;
//    // 添加动画
//    [_springView.layer addAnimation:anim forKey:@"spring"];
//    return anim;
//}


@end
