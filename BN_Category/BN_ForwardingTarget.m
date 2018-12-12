//
//  BN_ForwardingTarget.m
//  BN_Category
//
//  Created by dev on 2018/12/10.
//

#import "BN_ForwardingTarget.h"
#import <objc/runtime.h>

@implementation BN_ForwardingTarget

id ForwardingTarget_dynamicMethod(id self, SEL _cmd) {
    return [NSNull null];
}

+ (BOOL)resolveInstanceMethod:(SEL)sel {
    class_addMethod(self.class, sel, (IMP)ForwardingTarget_dynamicMethod, "@@:");
    [super resolveInstanceMethod:sel];
    return YES;
}

- (id)forwardingTargetForSelector:(SEL)aSelector {
    id result = [super forwardingTargetForSelector:aSelector];
    return result;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    id result = [super methodSignatureForSelector:aSelector];
    return result;
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    [super forwardInvocation:anInvocation];
}

- (void)doesNotRecognizeSelector:(SEL)aSelector {
    [super doesNotRecognizeSelector:aSelector]; // crash
}


@end
