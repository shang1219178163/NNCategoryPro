//
//  NSObject+CashProtector.m
//  ChildViewControllers
//
//  Created by BIN on 2017/12/4.
//  Copyright © 2017年 BIN. All rights reserved.
//

#import "NSObject+CashProtector.h"

#import <objc/runtime.h>

#define isOpenCashProtector  1
#define isOpenAssert         1
//isOpenAssert配合异常断点一起使用(自动定位到崩溃位置)


@implementation NSObject (CashProtector)

+(BOOL)swizzleMethodClass:(Class)clz origMethod:(SEL)origSelector  newMethod:(SEL)newSelector{
    
    Method original = class_getInstanceMethod(clz, origSelector);
    Method replace = class_getInstanceMethod(clz, newSelector);
    
    if(original && replace) {//必须两个Method都要拿到
        if (class_addMethod(clz, origSelector, method_getImplementation(replace), method_getTypeEncoding(replace))) {
            class_replaceMethod(clz, newSelector, method_getImplementation(original),  method_getTypeEncoding(original));
            
        }
        else {
            method_exchangeImplementations(original, replace);
            
        }
    }
    return YES;
}
//BIN

#pragma mark - - load

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        if (isOpenCashProtector) {
            
//            [self swizzleMethodClass:objc_getClass("__NSDictionaryM") origMethod:@selector(setObject:forKey:) newMethod:NSSelectorFromString(@"safe_setObject:forKey:")];
//            
//            [self swizzleMethodClass:objc_getClass("__NSArrayI") origMethod:@selector(objectAtIndex:) newMethod:NSSelectorFromString(@"safe_objectAtIndex:")];
//            [self swizzleMethodClass:objc_getClass("__NSArrayM") origMethod:@selector(objectAtIndex:) newMethod:NSSelectorFromString(@"safe_objectAtIndex:")];
//            
//            [self swizzleMethodClass:objc_getClass("__NSArrayM") origMethod:@selector(addObject:) newMethod:NSSelectorFromString(@"safe_addObject:")];
//            [self swizzleMethodClass:objc_getClass("__NSArrayM") origMethod:@selector(insertObject:atIndex:) newMethod:NSSelectorFromString(@"safe_insertObject:atIndex:")];
//safe
            [self swizzleMethodClass:NSClassFromString(@"__NSDictionaryM") origMethod:@selector(setObject:forKey:) newMethod:NSSelectorFromString(@"safe_setObject:forKey:")];
            
            [self swizzleMethodClass:NSClassFromString(@"__NSArrayI") origMethod:@selector(objectAtIndex:) newMethod:NSSelectorFromString(@"safe_objectAtIndex:")];

            [self swizzleMethodClass:NSClassFromString(@"__NSArrayM") origMethod:@selector(objectAtIndex:) newMethod:NSSelectorFromString(@"safe_objectAtIndex:")];
            [self swizzleMethodClass:NSClassFromString(@"__NSArrayM") origMethod:@selector(addObject:) newMethod:NSSelectorFromString(@"safe_addObject:")];
            [self swizzleMethodClass:NSClassFromString(@"__NSArrayM") origMethod:@selector(insertObject:atIndex:) newMethod:NSSelectorFromString(@"safe_insertObject:atIndex:")];
        }
    });
}


@end


@implementation NSMutableDictionary (CashProtector)

- (void)safe_setObject:(nullable id)anObject forKey:(nullable id <NSCopying>)aKey{
    if (!anObject || !aKey) {
//        DDLog(@"anObject和aKey不能为nil");
        if (isOpenAssert) NSAssert(anObject && aKey, @"anObject和aKey不能为nil");
        return;
    }
    [self safe_setObject:anObject forKey:aKey];
}

@end

@implementation NSArray (CashProtector)

- (id)safe_objectAtIndex:(NSUInteger)index{
    if (index >= self.count) {
//        DDLog(@"index越界");
        if (isOpenAssert) NSAssert(index < self.count, @"index越界");
        return nil;
    }
    return [self safe_objectAtIndex:index];
}

@end


@implementation NSMutableArray (CashProtector)

- (void)safe_addObject:(id)anObject{
    if(nil == anObject){
//        DDLog(@"anObject不能为nil");
        if (isOpenAssert) NSAssert(anObject, @"anObject不能为nil");
        return ;
    }
    [self safe_addObject:anObject];
}

- (void)safe_insertObject:(id)anObject atIndex:(NSUInteger)index{
    if(nil == anObject){
//        DDLog(@"anObject不能为nil");
        if (isOpenAssert) NSAssert(anObject, @"anObject不能为nil");
        return ;
    }
    [self safe_insertObject:anObject atIndex:index];
}

- (id)safe_objectAtIndex:(NSUInteger)index{
    if (index >= self.count) {
//        DDLog(@"index越界");
        if (isOpenAssert) NSAssert(index < self.count, @"index越界");
        return nil;
    }
    return [self safe_objectAtIndex:index];
}

@end




