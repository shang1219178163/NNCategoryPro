//
//  NSInvocation+Helper.h
//  ProductTemplet
//
//  Created by BIN on 2018/11/28.
//  Copyright © 2018年 BN. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSInvocation (Helper)

+ (instancetype)invocationWithBlock:(id) block;
+ (instancetype)invocationWithBlockAndArguments:(id) block ,...;

+ (id)doInstanceMethodTarget:(id)target
                   selectorName:(NSString *)selectorName
                           args:(NSArray *)args;

+ (id)doClassMethod:(NSString *)className
          selectorName:(NSString *)selectorName
                  args:(NSArray *)args;

- (void)setArgumentWithObject:(id)object atIndex:(NSUInteger)index;

@end

NS_ASSUME_NONNULL_END
