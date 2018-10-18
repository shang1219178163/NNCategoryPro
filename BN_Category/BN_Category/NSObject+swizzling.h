//
//  NSObject+swizzling.h
//  HuiZhuBang
//
//  Created by BIN on 2017/12/2.
//  Copyright © 2017年 WeiHouKeJi. All rights reserved.
//

/**
 此类为swizzling方法源类,方法在此类实现,别处调用
 
*/

#import <Foundation/Foundation.h>

#import <objc/runtime.h>

@interface NSObject (swizzling)

/**
 (弃用)所有类方法交换都应该走此方法,若此方法不满足需求,请在此类添加新方法

 @param clz Class类
 @param origSelector 被替换的方法
 @param newSelector 替换的方法
 @return 是够替换成功
 */
+(BOOL)swizzleMethodClass:(Class)clz origMethod:(SEL)origSelector newMethod:(SEL)newSelector;

/**
 swizzle 类方法
 
 @param oriSel 原有的方法
 @param swiSel swizzle的方法
 */
+ (void)swizzleClassMethodWithOriginSel:(SEL)oriSel swizzledSel:(SEL)swiSel;

/**
 swizzle 实例方法
 
 @param oriSel 原有的方法
 @param swiSel swizzle的方法
 */
+ (void)swizzleInstanceMethodWithOriginSel:(SEL)oriSel swizzledSel:(SEL)swiSel;
/**
 判断方法是否在子类里override了
 
 @param sel 传入要判断的Selector
 @return 返回判断是否被重载的结果
 */
- (BOOL)isMethodOverride:(Class)clz selector:(SEL)sel;


@end
