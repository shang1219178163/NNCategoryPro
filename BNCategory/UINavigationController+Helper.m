//
//  UINavigationController+Helper.m
//  BNCategory
//
//  Created by Bin Shang on 2019/4/3.
//

#import "UINavigationController+Helper.h"
#import "UIViewController+Helper.h"

@implementation UINavigationController (Helper)

/**
 字符串->UINavigationController
 */
UINavigationController * UINavCtrFromObj(id obj){
    if ([obj isKindOfClass:[UINavigationController class]]) {
        return obj;
    }
    else if ([obj isKindOfClass:[NSString class]]) {
        return [[UINavigationController alloc]initWithRootViewController:UICtrFromString(obj)];
    }
    else if ([obj isKindOfClass:[UIViewController class]]) {
        return [[UINavigationController alloc]initWithRootViewController:obj];
    }
    return nil;
}

@end
