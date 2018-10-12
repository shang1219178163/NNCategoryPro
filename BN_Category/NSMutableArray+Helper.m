//
//  NSMutableArray+Helper.m
//  HuiZhuBang
//
//  Created by BIN on 2017/9/14.
//  Copyright © 2017年 WeiHouKeJi. All rights reserved.
//

#import "NSMutableArray+Helper.h"

@implementation NSMutableArray (Helper)

-(void)addSafeObjct:(id)obj{
    if (obj == nil || [obj isKindOfClass:[NSNull class]]) {
        [self addObject:@""];
//        [self addObject:kNIl_TEXT];

    }else{
        [self addObject:obj];
        
    }
}


-(id)objectSafeAtIndex:(NSUInteger)index{
    
    if (index > (self.count - 1)) {
        NSAssert(NO, @"beyond the boundary");
        return nil;
    }
    else{
        return [self objectAtIndex:index];
    }
}

- (void)replaceObjectAtIndex:(NSUInteger)index withSafeObject:(id)anObject{
    
    if (index > (self.count - 1)) {
        NSAssert(NO, @"beyond the boundary");
    }
    else{
        if (anObject == nil || [anObject isKindOfClass:[NSNull class]]) {
            [self replaceObjectAtIndex:index withObject:@""];
            
        }else{
            [self replaceObjectAtIndex:index withObject:anObject];

        }
        
    }
}


@end






