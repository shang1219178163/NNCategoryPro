//
//  NSMutableArray+Helper.h
//  
//
//  Created by BIN on 2017/9/14.
//  Copyright © 2017年 SHANG. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSMutableArray<ObjectType> (Helper)

@property(nonatomic, copy, readonly) NSMutableArray *(^addObject)(ObjectType);
@property(nonatomic, copy, readonly) NSMutableArray *(^addObjects)(NSArray<ObjectType> *);

@property(nonatomic, copy, readonly) NSMutableArray *(^insertAtIndex)(ObjectType, NSUInteger);
@property(nonatomic, copy, readonly) NSMutableArray *(^removeAtIndex)(NSUInteger);
@property(nonatomic, copy, readonly) NSMutableArray *(^removeObjects)(NSArray<ObjectType> *);
@property(nonatomic, copy, readonly) NSMutableArray *(^removeAll)(void);

@property(nonatomic, copy, readonly) NSMutableArray *(^replaceAtIndex)(ObjectType, NSUInteger);

@property(nonatomic, copy, readonly) NSMutableArray *(^sort)(SEL);

//-(void)addSafeObjct:(id)obj;
//
//-(id)objectSafeAtIndex:(NSUInteger)index;
//
//-(void)replaceObjectAtIndex:(NSUInteger)index withSafeObject:(id)anObject;


@end

NS_ASSUME_NONNULL_END
