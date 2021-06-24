//
//  UIPageControl+Helper.m
//  
//
//  Created by Bin Shang on 2019/11/11.
//

#import "UIPageControl+Helper.h"
#import <objc/runtime.h>
#import "UIColor+Helper.h"

@implementation UIPageControl (Helper)

- (void)addActionHandler:(void(^)(UIPageControl *sender))handler forControlEvents:(UIControlEvents)controlEvents{
    [self addTarget:self action:@selector(p_handleActionPage:) forControlEvents:controlEvents];
    objc_setAssociatedObject(self, _cmd, handler, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)p_handleActionPage:(UIPageControl *)sender{
    void(^block)(UIPageControl *control) = objc_getAssociatedObject(self, @selector(addActionHandler:forControlEvents:));
    if (block) {
        block(sender);
    }
}

+ (instancetype)createRect:(CGRect)rect numberOfPages:(NSInteger)numberOfPages{
    UIPageControl *sender = [[UIPageControl alloc] initWithFrame:rect];
    sender.hidesForSinglePage = true;
    sender.defersCurrentPageDisplay = true;
    sender.pageIndicatorTintColor = UIColor.lightGrayColor;
    sender.currentPage = 0;
    sender.numberOfPages = numberOfPages;
    return sender;
}

@end
