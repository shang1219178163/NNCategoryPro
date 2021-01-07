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
    UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(rect) - 30, CGRectGetWidth(rect), 30)];
    pageControl.hidesForSinglePage = true;
    pageControl.defersCurrentPageDisplay = true;
    pageControl.pageIndicatorTintColor = UIColor.lightGrayColor;
    pageControl.currentPageIndicatorTintColor = UIColor.themeColor;
    pageControl.currentPage = 0;
    pageControl.numberOfPages = numberOfPages;
    return pageControl;
}

@end
