//
//  UISlider+Helper.m
//  NNCategoryPro
//
//  Created by Bin Shang on 2019/11/11.
//

#import "UISlider+Helper.h"
#import <objc/runtime.h>
#import "UIColor+Helper.h"

@implementation UISlider (Helper)

- (void)addActionHandler:(void(^)(UISlider *sender))handler forControlEvents:(UIControlEvents)controlEvents{
    [self addTarget:self action:@selector(p_handleActionSlider:) forControlEvents:controlEvents];
    objc_setAssociatedObject(self, _cmd, handler, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)p_handleActionSlider:(UISlider *)sender{
    void(^block)(UISlider *control) = objc_getAssociatedObject(self, @selector(addActionHandler:forControlEvents:));
    if (block) {
        block(sender);
    }
}
/**
 [源]UISlider创建方法
 */
+ (instancetype)createRect:(CGRect)rect minValue:(CGFloat)minValue maxValue:(CGFloat)maxValue{
    UISlider *view = [[self alloc] initWithFrame:rect];
    view.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    view.minimumValue = minValue;
    view.maximumValue = maxValue;
    view.value = minValue;
    
//    view.maximumTrackTintColor = UIColor.redColor;
//    view.thumbTintColor = UIColor.yellowColor;
    return view;
}


@end
