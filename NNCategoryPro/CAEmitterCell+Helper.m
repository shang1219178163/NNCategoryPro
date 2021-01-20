//
//  CAEmitterCell+Helper.m
//  BNAnimation
//
//  Created by BIN on 2018/10/16.
//  Copyright © 2018年 世纪阳天. All rights reserved.
//

#import "CAEmitterCell+Helper.h"

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
