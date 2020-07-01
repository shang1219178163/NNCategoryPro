//
//  UIBarButtonItem+Helper.m
//  
//
//  Created by BIN on 2018/11/28.
//

#import "UIBarButtonItem+Helper.h"
#import <objc/runtime.h>
#import "UIColor+Helper.h"

@implementation UIBarButtonItem (Helper)

/**
 导航栏 UIBarButtonItem
 */
+ (instancetype)createItem:(NSString *)obj style:(UIBarButtonItemStyle)style{
    return [self createItem:obj style:style target:nil action:nil];
}

/**
 [源] 导航栏 UIBarButtonItem
 */
+ (instancetype)createItem:(NSString *)obj style:(UIBarButtonItemStyle)style target:(id _Nullable)target action:(SEL _Nullable)action{
    UIImage *image = [UIImage imageNamed:obj];
    if (image) {
        UIBarButtonItem *barItem = [[self alloc] initWithImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]
                                                         style:style
                                                        target:target
                                                        action:action];
        return barItem;
    }
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithTitle:obj
                                                                style:style
                                                               target:target
                                                               action:action];
    return barItem;
}

- (void)addActionBlock:(void (^)(UIBarButtonItem *item))actionBlock{
    if (actionBlock) {
        [self willChangeValueForKey:@"actionBlock"];
        objc_setAssociatedObject(self, @selector(actionBlock), actionBlock, OBJC_ASSOCIATION_COPY);
        // Sets up the action.
        self.target = self;
        self.action = @selector(p_invoke);
        [self didChangeValueForKey:@"actionBlock"];
    }
}

- (void)p_invoke {
    void(^block)(UIBarButtonItem *item) = objc_getAssociatedObject(self, @selector(actionBlock));
    if (block) {
        block(self);
    }
}

- (void)setHidden:(BOOL)hidden{
    self.enabled = !hidden;
    self.tintColor = !hidden ? UIColor.themeColor : UIColor.clearColor;
}



@end
