//
//  CAEmitterLayer+Helper.m
//  BNAnimation
//
//  Created by BIN on 2018/10/16.
//  Copyright © 2018年 世纪阳天. All rights reserved.
//

#import "CAEmitterLayer+Helper.h"


@implementation CAEmitterLayer (Helper)

+ (CAEmitterLayer *)layerWithSize:(CGSize)size positon:(CGPoint)position cells:(NSArray<CAEmitterCell *> *)cells{
    
    CAEmitterLayer *emitterLayer = CAEmitterLayer.layer;
    
    emitterLayer.emitterSize = size;//发射器大小，因为emitterShape设置成线性所以高度可以设置成0，
    emitterLayer.emitterPosition = position;//发射器中心点

    emitterLayer.emitterShape = kCAEmitterLayerLine;//发射器形状为线性
    emitterLayer.emitterMode = kCAEmitterLayerOutline;//从发射器边缘发出
    emitterLayer.renderMode = kCAEmitterLayerAdditive;//混合渲染效果

    emitterLayer.emitterCells = cells;//设置粒子组
    return emitterLayer;
}

+(CAEmitterLayer *)layerUpWithSize:(CGSize)size positon:(CGPoint)position images:(NSArray<NSString *> *)images{
    NSMutableArray *marr = [NSMutableArray array];
    [images enumerateObjectsUsingBlock:^(NSString *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CAEmitterCell *cell = [CAEmitterCell cellWithUpContents:[UIImage imageNamed:obj] emitterCells:nil];
        [marr addObject:cell];
    }];
    
    CAEmitterLayer *layer = [CAEmitterLayer layerWithSize:size positon:position cells:marr.copy];
    return layer;
}

+(CAEmitterLayer *)layerDownWithSize:(CGSize)size positon:(CGPoint)position images:(NSArray<NSString *> *)images{
    NSMutableArray *marr = [NSMutableArray array];
    [images enumerateObjectsUsingBlock:^(NSString *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CAEmitterCell *cell = [CAEmitterCell cellWithUpContents:[UIImage imageNamed:obj] emitterCells:nil];
        [marr addObject:cell];
    }];
    
    CAEmitterLayer *layer = [CAEmitterLayer layerWithSize:size positon:position cells:marr.copy];
    return layer;
}

+(CAEmitterLayer *)layerDownWithRect:(CGRect)rect images:(NSArray<NSString *> *)images{
    CGSize emitterSize = CGSizeMake(CGRectGetWidth(rect), 0);
    CGPoint emitterPosition = CGPointMake(rect.size.width/2, rect.size.height - 60);
    CAEmitterLayer *emitterLayer = [CAEmitterLayer layerDownWithSize:emitterSize positon:emitterPosition images:images];
    return emitterLayer;
}

+(CAEmitterLayer *)layerSparkWithRect:(CGRect)rect images:(NSArray<NSString *> *)images{
    
    CAEmitterLayer *emitterLayer = CAEmitterLayer.layer;
    //烟花效果
    // 发射源
    emitterLayer.emitterPosition   = CGPointMake(rect.size.width/2, rect.size.height - 50);
    // 发射源尺寸大小
    emitterLayer.emitterSize       = CGSizeMake(50, 0);
    // 发射源模式
    emitterLayer.emitterMode       = kCAEmitterLayerOutline;
    // 发射源的形状
    emitterLayer.emitterShape      = kCAEmitterLayerLine;
    // 渲染模式
    emitterLayer.renderMode        = kCAEmitterLayerAdditive;
    // 发射方向
    emitterLayer.velocity          = 1;
    // 随机产生粒子
    emitterLayer.seed              = (arc4random() % 100) + 1;
    
    // rocket
    CAEmitterCell *rocket             = CAEmitterCell.emitterCell;
    // 速率
    rocket.birthRate                  = 1.0;
    // 发射的角度
    rocket.emissionRange              = 0.11 * M_PI;
    // 速度
    rocket.velocity                   = 300;
    // 范围
    rocket.velocityRange              = 150;
    // Y轴 加速度分量
    rocket.yAcceleration              = 75;
    // 声明周期
    rocket.lifetime                   = 2.04;
    //是个CGImageRef的对象,既粒子要展现的图片
    NSString * rocketName = images[0] ? : @"point";
    rocket.contents                   = (id)[[UIImage imageNamed:rocketName] CGImage];
    // 缩放比例
    rocket.scale                      = 0.2;
    // 粒子的颜色
    rocket.color                      = [[UIColor colorWithRed:0.6
                                                       green:0.6
                                                        blue:0.6
                                                       alpha:1.0] CGColor];
    // 一个粒子的颜色green 能改变的范围
    rocket.greenRange                 = 1.0;
    // 一个粒子的颜色red 能改变的范围
    rocket.redRange                   = 1.0;
    // 一个粒子的颜色blue 能改变的范围
    rocket.blueRange                  = 1.0;
    // 子旋转角度范围
    rocket.spinRange                  = M_PI;
    
    // 爆炸
    CAEmitterCell *burst            = CAEmitterCell.emitterCell;
    // 粒子产生系数
    burst.birthRate                 = 1.0;
    // 速度
    burst.velocity                  = 0;
    // 缩放比例
    burst.scale                     = 2.5;
    // shifting粒子red在生命周期内的改变速度
    burst.redSpeed                  = -1.5;
    // shifting粒子blue在生命周期内的改变速度
    burst.blueSpeed                 = +1.5;
    // shifting粒子green在生命周期内的改变速度
    burst.greenSpeed                = +1.0;
    //生命周期
    burst.lifetime                  = 0.35;
    
    
    // 火花 and finally, the sparks
    CAEmitterCell *spark            = CAEmitterCell.emitterCell;
    //粒子产生系数，默认为1.0
    spark.birthRate                 = 400;
    //速度
    spark.velocity                  = 125;
    // 360 deg//周围发射角度
    spark.emissionRange             = 2 * M_PI;
    // gravity//y方向上的加速度分量
    spark.yAcceleration             = 75;
    //粒子生命周期
    spark.lifetime                  = 3;
    //是个CGImageRef的对象,既粒子要展现的图片
    NSString * sparkName            = images[1] ? : @"spark";
    spark.contents                  = (id) [[UIImage imageNamed:sparkName] CGImage];
    //缩放比例速度
    spark.scaleSpeed                = -0.2;
    //粒子green在生命周期内的改变速度
    spark.greenSpeed                = -0.1;
    //粒子red在生命周期内的改变速度
    spark.redSpeed                  = 0.4;
    //粒子blue在生命周期内的改变速度
    spark.blueSpeed                 = -0.1;
    //粒子透明度在生命周期内的改变速度
    spark.alphaSpeed                = -0.25;
    //子旋转角度
    spark.spin                      = 2* M_PI;
    //子旋转角度范围
    spark.spinRange                 = 2* M_PI;
    
    // 3种粒子组合，可以根据顺序，依次烟花弹－烟花弹粒子爆炸－爆炸散开粒子
    emitterLayer.emitterCells    = [NSArray arrayWithObject:rocket];
    rocket.emitterCells          = [NSArray arrayWithObject:burst];
    burst.emitterCells           = [NSArray arrayWithObject:spark];

    return emitterLayer;
}

+(CAEmitterLayer *)layerUpWithRect:(CGRect)rect images:(NSArray<NSString *> *)images{
    CGSize emitterSize = CGSizeMake(CGRectGetWidth(rect), 0);//发射器大小，因为emitterShape设置成线性所以高度可以设置成0，
    CGPoint emitterPosition = CGPointMake(CGRectGetWidth(rect)/2.0, 0);//发射器
    CAEmitterLayer *emitterLayer = [CAEmitterLayer layerUpWithSize:emitterSize positon:emitterPosition images:images];
    return emitterLayer;
}

@end


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
