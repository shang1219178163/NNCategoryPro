//
//  CAEmitterLayer+Helper.h
//  BNAnimation
//
//  Created by BIN on 2018/10/16.
//  Copyright © 2018年 世纪阳天. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

NS_ASSUME_NONNULL_BEGIN

@interface CAEmitterLayer (Helper)

+(CAEmitterLayer *)layerWithSize:(CGSize)size positon:(CGPoint)position cells:(NSArray<CAEmitterCell *> *)cells;

+(CAEmitterLayer *)layerUpWithSize:(CGSize)size positon:(CGPoint)position images:(NSArray<NSString *> *)images;

+(CAEmitterLayer *)layerDownWithSize:(CGSize)size positon:(CGPoint)position images:(NSArray<NSString *> *)images;

+(CAEmitterLayer *)layerDownWithRect:(CGRect)rect images:(NSArray<NSString *> *)images;

+(CAEmitterLayer *)layerSparkWithRect:(CGRect)rect images:(NSArray<NSString *> *)images;

+(CAEmitterLayer *)layerUpWithRect:(CGRect)rect images:(NSArray<NSString *> *)images;

@end


@interface CAEmitterCell (Helper)

///向上的效果
+(CAEmitterCell *)cellWithUpContents:(nullable UIImage *)image emitterCells:(nullable NSArray<CAEmitterCell *> *)emitterCells;
///向下的效果
+(CAEmitterCell *)cellWithDownContents:(nullable UIImage *)image emitterCells:(nullable NSArray<CAEmitterCell *> *)emitterCells;

@end

NS_ASSUME_NONNULL_END
