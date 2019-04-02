//
//  CATransaction+Helper.h
//  VCTransitioning
//
//  Created by BIN on 2018/8/10.
//  Copyright © 2018年 Baymax. All rights reserved.
//

/**
CATransaction是事务，用于批量提交多个对layer-tree的操作，并且是原子性的。所有对layer-tree的修改都必须包含在事务内。事务可以嵌套。
 
 所有对layer-tree的操作都必须处于事务。修改UIView的属性最终也是修改到了layer-tree。当我们改动到layer-tree时，如果当前没有显式创建过CATransaction，则系统会创建一个隐式的CATransaction，这个隐式CATransaction会在RunLoop结束后commit。
 */

#import <QuartzCore/QuartzCore.h>

@interface CATransaction (Helper)

+(void)animDuration:(CGFloat)duration animations:(void(^)(void))animations completion:(nullable void (^)(void))completion;

@end
