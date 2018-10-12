//
//  NSMutableArray+Helper.h
//  HuiZhuBang
//
//  Created by BIN on 2017/9/14.
//  Copyright © 2017年 WeiHouKeJi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (Helper)

-(void)addSafeObjct:(id)obj;

-(id)objectSafeAtIndex:(NSUInteger)index;

- (void)replaceObjectAtIndex:(NSUInteger)index withSafeObject:(id)anObject;

//- (void)moveObjectIndex:(NSUInteger)index toIndex:(NSUInteger)toIndex;


@end
