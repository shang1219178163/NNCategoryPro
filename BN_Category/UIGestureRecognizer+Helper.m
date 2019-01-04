
//
//  UIGestureRecognizer+Helper.m
//  AESCrypt-ObjC
//
//  Created by Bin Shang on 2019/1/4.
//

#import "UIGestureRecognizer+Helper.h"
#import <objc/runtime.h>

@implementation UIGestureRecognizer (Helper)

-(NSString *)funcName{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setFuncName:(NSString *)actionName{
    objc_setAssociatedObject(self, @selector(funcName), actionName, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
