//
//  NSMutableArray+Helper.h
//  
//
//  Created by BIN on 2017/9/14.
//  Copyright © 2017年 SHANG. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSMutableArray (Helper)

-(void)addSafeObjct:(id)obj;

-(id)objectSafeAtIndex:(NSUInteger)index;

-(void)replaceObjectAtIndex:(NSUInteger)index withSafeObject:(id)anObject;

//- (void)moveObjectIndex:(NSUInteger)index toIndex:(NSUInteger)toIndex;


@end

NS_ASSUME_NONNULL_END
