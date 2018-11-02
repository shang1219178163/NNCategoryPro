//
//  NSObject+swizzling.m
//  HuiZhuBang
//
//  Created by BIN on 2017/12/2.
//  Copyright © 2017年 WeiHouKeJi. All rights reserved.
//

#import "NSObject+swizzling.h"
#import <objc/runtime.h>

@implementation NSObject (swizzling)

+(BOOL)swizzleMethodClass:(Class)clz origSel:(SEL)origSelector newSel:(SEL)newSelector{
    //1. 通过class_getInstanceMethod()函数从当前对象中的method list获取method结构体，如果是类方法就使用class_getClassMethod()函数获取。
    Method original = class_getInstanceMethod(clz, origSelector);
    Method replace = class_getInstanceMethod(clz, newSelector);

    //2.若UIViewController类没有该方法,那么它会去UIViewController的父类去寻找,为了避免不必要的麻烦,我们先进行一次添加
    BOOL AddMethod = class_addMethod(clz, origSelector, method_getImplementation(replace),method_getTypeEncoding(replace));
    //3: 如果原来类没有这个方法,可以成功添加,如果原来类里面有这个方法,那么将会添加失败
    if (AddMethod) {
        class_replaceMethod(clz, newSelector, method_getImplementation(original), method_getTypeEncoding(original));

    }
    else{
        method_exchangeImplementations(original, replace);
        return YES;

    }
    return NO;
}

- (BOOL)isMethodOverride:(Class)cls selector:(SEL)sel {
    IMP clsIMP = class_getMethodImplementation(cls, sel);
    IMP superClsIMP = class_getMethodImplementation([cls superclass], sel);
    
    return clsIMP != superClsIMP;
}

@end

