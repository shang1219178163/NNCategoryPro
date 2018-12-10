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

FOUNDATION_EXPORT BOOL MethodSwizzle(Class clz, SEL origSelector, SEL newSelector);

/**
 所有类方法交换都应该走此方法,若此方法不满足需求,请在此类添加新方法

 @param clz Class类
 @param origSelector 被替换的方法
 @param newSelector 替换的方法
 @return 是exchange YES
 */
+(BOOL)swizzleMethodClass:(Class)clz origSel:(SEL)origSelector newSel:(SEL)newSelector;

/**
 判断方法是否在子类里override了
 
 @param sel 传入要判断的Selector
 @return 返回判断是否被重载的结果
 */
- (BOOL)isMethodOverride:(Class)clz selector:(SEL)sel;


@end
