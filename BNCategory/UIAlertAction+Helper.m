
//
//  UIAlertAction+Helper.m
//  
//
//  Created by BIN on 2018/9/18.
//  Copyright © 2018年 SHANG. All rights reserved.
//

#import "UIAlertAction+Helper.h"

#import <objc/runtime.h>

@implementation UIAlertAction (Helper)

-(NSInteger)tag{
   return [objc_getAssociatedObject(self, _cmd) integerValue];
    
}

- (void)setTag:(NSInteger)tag{
    objc_setAssociatedObject(self, @selector(tag), @(tag), OBJC_ASSOCIATION_ASSIGN);
    
}


@end
