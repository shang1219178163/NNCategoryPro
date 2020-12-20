//
//  UISwitch+Helper.m
//  NNCategoryPro
//
//  Created by Bin Shang on 2019/11/11.
//

#import "UISwitch+Helper.h"
#import <objc/runtime.h>
#import "UIColor+Helper.h"

@implementation UISwitch (Helper)

- (void)addActionHandler:(void(^)(UISwitch *sender))handler forControlEvents:(UIControlEvents)controlEvents{
    [self addTarget:self action:@selector(p_handleActionSwitch:) forControlEvents:controlEvents];
    objc_setAssociatedObject(self, _cmd, handler, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)p_handleActionSwitch:(UISwitch *)sender{
    void(^block)(UISwitch *control) = objc_getAssociatedObject(self, @selector(addActionHandler:forControlEvents:));
    if (block) {
        block(sender);
    }
}
/**
 [源]UISwitch创建方法
 */
+ (instancetype)createRect:(CGRect)rect{
    UISwitch *view = [[self alloc]initWithFrame:rect];
    view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    view.on = false;
    view.onTintColor = UIColor.themeColor;
//    view.tintColor = UIColor.whiteColor;
    return view;
}

@end
