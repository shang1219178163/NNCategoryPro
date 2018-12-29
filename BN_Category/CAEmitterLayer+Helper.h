//
//  CAEmitterLayer+Helper.h
//  BN_Animation
//
//  Created by BIN on 2018/10/16.
//  Copyright © 2018年 世纪阳天. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

NS_ASSUME_NONNULL_BEGIN

@interface CAEmitterLayer (Helper)

+(CAEmitterLayer *)layerWithSize:(CGSize)size positon:(CGPoint)position cells:(NSArray *)cells;

+(CAEmitterLayer *)layerWithSize:(CGSize)size positon:(CGPoint)position imgList:(NSArray *)imgList type:(NSNumber *)type;

+(CAEmitterLayer *)layerRect:(CGRect)rect imgList:(nullable NSArray *)imgList type:(NSNumber *)type;

@end

NS_ASSUME_NONNULL_END
