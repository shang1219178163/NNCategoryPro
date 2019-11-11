//
//  UIPageControl+Helper.m
//  AESCrypt-ObjC
//
//  Created by Bin Shang on 2019/11/11.
//

#import "UIPageControl+Helper.h"
#import "UIColor+Helper.h"

@implementation UIPageControl (Helper)

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
