//
//  NSMutableArray+Helper.m
//  
//
//  Created by BIN on 2017/9/14.
//  Copyright © 2017年 SHANG. All rights reserved.
//

#import "NSMutableArray+Helper.h"

@implementation NSMutableArray (Helper)

- (NSMutableArray * _Nonnull (^)(id _Nonnull))addObject{
    return ^(id obj) {
        if (obj) {
            [self addObject:obj];
        }
        return self;
    };
}

- (NSMutableArray * _Nonnull (^)(NSArray<id> *))addObjects{
    return ^(NSArray<id> * value) {
        if (value) {
            [self addObjectsFromArray:value];
        }
        return self;
    };
}

- (NSMutableArray * _Nonnull (^)(id, NSUInteger))insertAtIndex{
    return ^(id value, NSUInteger index) {
        if (value) {
            [self insertObject:value atIndex:index];
        }
        return self;
    };
}

- (NSMutableArray * _Nonnull (^)(NSUInteger))removeAtIndex{
    return ^(NSUInteger index) {
        if (index < self.count) {
            [self removeObjectAtIndex:index];
        }
        return self;
    };
}

- (NSMutableArray * _Nonnull (^)(NSArray<id> *))removeObjects{
    return ^(NSArray<id> * value) {
        [self removeObjectsInArray:value];
        return self;
    };
}

- (NSMutableArray * _Nonnull (^)(void))removeAll{
    return ^(void) {
        [self removeAllObjects];
        return self;
    };
}

- (NSMutableArray * _Nonnull (^)(id, NSUInteger))replaceAtIndex{
    return ^(id value, NSUInteger index) {
        if (index < self.count) {
            [self replaceObjectAtIndex:index withObject:value];
        }
        return self;
    };
}

- (NSMutableArray * _Nonnull (^)(SEL))sort{
    return ^(SEL aSel) {
        [self sortUsingSelector:aSel];
        return self;
    };
}


//-(void)addSafeObjct:(id)obj{
//    if (!obj || [obj isKindOfClass:[NSNull class]]) {
//        [self addObject:@""];
////        [self addObject:kNilText];
//    } else {
//        [self addObject:obj];
//    }
//}
//
//-(id)objectSafeAtIndex:(NSUInteger)index{
//    if (index > (self.count - 1)) {
//        NSAssert(NO, @"beyond the boundary");
//        return nil;
//    }
//    else{
//        return [self objectAtIndex:index];
//    }
//}
//
//- (void)replaceObjectAtIndex:(NSUInteger)index withSafeObject:(id)anObject{
//    if (index > (self.count - 1)) {
//        NSAssert(NO, @"beyond the boundary");
//    }
//    else{
//        if (!anObject || [anObject isKindOfClass:[NSNull class]]) {
//            [self replaceObjectAtIndex:index withObject:@""];
//        } else {
//            [self replaceObjectAtIndex:index withObject:anObject];
//        }
//    }
//}


@end






