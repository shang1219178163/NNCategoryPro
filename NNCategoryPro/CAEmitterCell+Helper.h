//
//  CAEmitterCell+Helper.h
//  BNAnimation
//
//  Created by BIN on 2018/10/16.
//  Copyright © 2018年 世纪阳天. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

NS_ASSUME_NONNULL_BEGIN

@interface CAEmitterCell (Helper)

///向上的效果
+(CAEmitterCell *)cellWithUpContents:(nullable UIImage *)image emitterCells:(nullable NSArray<CAEmitterCell *> *)emitterCells;
///向下的效果
+(CAEmitterCell *)cellWithDownContents:(nullable UIImage *)image emitterCells:(nullable NSArray<CAEmitterCell *> *)emitterCells;

@end

NS_ASSUME_NONNULL_END
