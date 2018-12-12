//
//  NSObject+CashProtector.m
//  ChildViewControllers
//
//  Created by BIN on 2017/12/4.
//  Copyright © 2017年 BIN. All rights reserved.
//

#import "NSObject+CashProtector.h"

#import <objc/runtime.h>
#import "NSObject+swizzling.h"
#import "BN_ForwardingTarget.h"

#define isOpenCashProtector  1
#define isOpenAssert         1
//isOpenAssert配合异常断点一起使用(自动定位到崩溃位置)

static BN_ForwardingTarget *_target = nil;

@implementation NSObject (CashProtector)

//+(BOOL)swizzleMethodClass:(Class)clz origMethod:(SEL)origSelector newMethod:(SEL)newSelector{
//    //1. 通过class_getInstanceMethod()函数从当前对象中的method list获取method结构体，如果是类方法就使用class_getClassMethod()函数获取。
//    Method original = class_getInstanceMethod(clz, origSelector);
//    Method replace = class_getInstanceMethod(clz, newSelector);
//    
//    //2.若UIViewController类没有该方法,那么它会去UIViewController的父类去寻找,为了避免不必要的麻烦,我们先进行一次添加
//    BOOL AddMethod = class_addMethod(clz, origSelector, method_getImplementation(replace), method_getTypeEncoding(replace));
//    //3.如果原来类没有这个方法,可以成功添加;如果原来类里面有这个方法,那么将会添加失败
//    if (!AddMethod) {
//        method_exchangeImplementations(original, replace);
//        return YES;
//    }
//    else{
//        class_replaceMethod(clz, newSelector, method_getImplementation(original),  method_getTypeEncoding(original));
//
//    }
//    return NO;
//}

#pragma mark - - load

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _target = [BN_ForwardingTarget new];;

        if (isOpenCashProtector) {
            //NSClassFromString(@"__NSDictionaryM"),objc_getClass("__NSDictionaryM")
            [self swizzleMethodInstance:NSClassFromString(@"__NSDictionaryM") origSel:@selector(setObject:forKey:) replSel:NSSelectorFromString(@"safe_setObject:forKey:")];
            
            [self swizzleMethodInstance:NSClassFromString(@"__NSArrayI") origSel:@selector(objectAtIndex:) replSel:NSSelectorFromString(@"safe_objectAtIndex:")];
            [self swizzleMethodInstance:NSClassFromString(@"__NSArrayM") origSel:@selector(objectAtIndex:) replSel:NSSelectorFromString(@"safe_objectAtIndex:")];
            [self swizzleMethodInstance:NSClassFromString(@"__NSArrayM") origSel:@selector(addObject:) replSel:NSSelectorFromString(@"safe_addObject:")];
            [self swizzleMethodInstance:NSClassFromString(@"__NSArrayM") origSel:@selector(insertObject:atIndex:) replSel:NSSelectorFromString(@"safe_insertObject:atIndex:")];
            
            [self swizzleMethodInstance:self.class origSel:@selector(forwardingTargetForSelector:) replSel:@selector(swz_forwardingTargetForSelector:)];
        }
    });
}

+ (BOOL)isWhiteListClass:(Class)class {
    NSString *classString = NSStringFromClass(class);
    BOOL isInternal = [classString hasPrefix:@"_"];
    if (isInternal) {
        return NO;
    }
    BOOL isNull = [classString isEqualToString:NSStringFromClass([NSNull class])];
    
//    BOOL isMyClass  = [classString ...];//前缀处理
//    return isNull || isMyClass;
    return isNull;
}

- (id)swz_forwardingTargetForSelector:(SEL)aSelector {
    id result = [self swz_forwardingTargetForSelector:aSelector];
    if (result) {
        return result;
    }
    BOOL isWhiteListClass = [[self class] isWhiteListClass:[self class]];
    if (!isWhiteListClass) {
        return nil;
    }
    
    if (!result) {
        result = _target;
    }
    return result;
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




