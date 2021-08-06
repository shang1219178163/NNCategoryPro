//
//  UISegmentedControl+Helper.m
//  
//
//  Created by BIN on 2018/6/29.
//  Copyright © 2018年 SHANG. All rights reserved.
//

#import "UISegmentedControl+Helper.h"
#import <objc/runtime.h>
#import "UIColor+Helper.h"
#import "UIImage+Helper.h"

@implementation UISegmentedControl (Helper)

- (void)setItems:(NSArray<NSString *> *)items{
    objc_setAssociatedObject(self, @selector(items), items, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self updateItems:items];
}

-(NSArray *)items{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)updateItems:(NSArray<NSString *> *)titles {
    if (!titles || titles.count == 0) {
        return;
    }
    [self removeAllSegments];
    [titles enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self insertSegmentWithTitle:obj atIndex:idx animated:NO];
    }];
    self.selectedSegmentIndex = 0;
}


- (void)addActionHandler:(void(^)(UISegmentedControl *sender))handler forControlEvents:(UIControlEvents)controlEvents{
    [self addTarget:self action:@selector(p_handleActionSegement:) forControlEvents:controlEvents];
    objc_setAssociatedObject(self, _cmd, handler, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)p_handleActionSegement:(UISegmentedControl *)sender{
    void(^block)(UISegmentedControl *control) = objc_getAssociatedObject(self, @selector(addActionHandler:forControlEvents:));
    if (block) {
        block(sender);
    }
}

- (void)ensureiOS13Style:(CGFloat)fontSize {
    UIColor *tintColor = self.tintColor;
    UIImage *tintColorImage = UIImageColor(tintColor);
    // Must set the background image for normal to something (even clear) else the rest won't work
    [self setBackgroundImage:UIImageColor(self.backgroundColor ? : UIColor.clearColor) forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [self setBackgroundImage:tintColorImage forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
    [self setBackgroundImage:UIImageColor([tintColor colorWithAlphaComponent:0.2]) forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
    [self setBackgroundImage:tintColorImage forState:UIControlStateSelected|UIControlStateSelected barMetrics:UIBarMetricsDefault];
    
    [self setTitleTextAttributes:@{NSForegroundColorAttributeName: tintColor,
                                   NSFontAttributeName: [UIFont systemFontOfSize:fontSize]} forState:UIControlStateNormal];
    [self setTitleTextAttributes:@{NSForegroundColorAttributeName: UIColor.whiteColor,
                                   NSFontAttributeName: [UIFont systemFontOfSize:fontSize]} forState:UIControlStateSelected];
    [self setTitleTextAttributes:@{NSForegroundColorAttributeName: UIColor.whiteColor,
                                   NSFontAttributeName: [UIFont systemFontOfSize:fontSize]} forState:UIControlStateHighlighted];
    
    [self setDividerImage:tintColorImage
      forLeftSegmentState:UIControlStateNormal
        rightSegmentState:UIControlStateNormal
               barMetrics:UIBarMetricsDefault];
    self.layer.borderWidth = 1;
    self.layer.borderColor = tintColor.CGColor;
}


@end
