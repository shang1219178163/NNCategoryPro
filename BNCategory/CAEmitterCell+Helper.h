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

+(CAEmitterCell *)cellWithContents:(id)contents emitterCells:(nullable NSArray *)emitterCells type:(NSNumber *)type;

@end

NS_ASSUME_NONNULL_END
