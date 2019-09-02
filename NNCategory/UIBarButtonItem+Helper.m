//
//  UIBarButtonItem+Helper.m
//  AESCrypt-ObjC
//
//  Created by BIN on 2018/11/28.
//

#import "UIBarButtonItem+Helper.h"
#import <objc/runtime.h>
#import "UIColor+Helper.h"

@implementation UIBarButtonItem (Helper)

- (void (^)(void))actionBlock {
    return objc_getAssociatedObject(self, _cmd);
}

//- (void)setActionBlock:(void (^)(void))actionBlock{
//    objc_setAssociatedObject(self, @selector(actionBlock), actionBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
//}

- (void)setActionBlock:(void (^)(void))actionBlock{
    if (actionBlock != self.actionBlock) {
        [self willChangeValueForKey:@"actionBlock"];
        
        objc_setAssociatedObject(self, @selector(actionBlock), actionBlock, OBJC_ASSOCIATION_COPY);
        
        // Sets up the action.
        self.target = self;
        self.action = @selector(performActionBlock);
        [self didChangeValueForKey:@"actionBlock"];
    }
}

- (void)performActionBlock {
    dispatch_block_t block = self.actionBlock;
    if (block) {
        block();
    }
}

- (void)setHidden:(BOOL)hidden{
    self.enabled = !hidden;
    self.tintColor = !hidden ? UIColor.themeColor : UIColor.clearColor;
}


@end
