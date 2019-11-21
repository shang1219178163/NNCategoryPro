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

//-(void)setSegmentItems:(NSArray *)segmentItems{
//    //    DDLog(@"%@_%@",@(segmentItems.count),@(self.numberOfSegments));
//    if (segmentItems.count == 0) {
//        return;
//    }
//    CGFloat width = CGRectGetWidth(self.bounds)/segmentItems.count;
//    if (segmentItems.count <= self.numberOfSegments) {
//        for (NSInteger i = 0; i < self.numberOfSegments; i++) {
//            if (i < segmentItems.count) {
//                [self setTitle:segmentItems[i] forSegmentAtIndex:i];
//                [self setWidth:width forSegmentAtIndex:i];
//
//            } else {
//                [self removeSegmentAtIndex:i animated:NO];
//            }
//        }
//
//    } else {
//        for (NSInteger i = 0; i < segmentItems.count; i++) {
//            if (i < self.numberOfSegments) {
//                [self setTitle:segmentItems[i] forSegmentAtIndex:i];
//                [self setWidth:width forSegmentAtIndex:i];
//
//            } else {
//                [self insertSegmentWithTitle:segmentItems[i] atIndex:i animated:NO];
//            }
//        }
//    }
//    self.selectedSegmentIndex = 0;
//}

-(void)setItemList:(NSArray *)itemList{
    objc_setAssociatedObject(self, @selector(itemList), itemList, OBJC_ASSOCIATION_RETAIN_NONATOMIC);

    //    DDLog(@"%@_%@",@(segmentItems.count),@(self.numberOfSegments));
    if (itemList.count == 0) {
        return;
    }
    [self removeAllSegments];
    for (NSInteger i = 0; i < itemList.count; i++) {
        [self insertSegmentWithTitle:itemList[i] atIndex:i animated:NO];
        
    }
    self.selectedSegmentIndex = 0;
}

-(NSArray *)itemList{
    return objc_getAssociatedObject(self, _cmd);
}

/**
 [源]UISegmentedControl创建方法
 */
+ (instancetype)createRect:(CGRect)rect items:(NSArray *)items selectedIndex:(NSInteger)selectedIndex type:(NSNumber *)type{
    UISegmentedControl *view = [[self alloc] initWithItems:items];
    view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    view.frame = rect;
    
    if (@available(iOS 13, *)) {
        view.tintColor = UIColor.whiteColor;
        [view ensureiOS12Style];
        return view;
    }
    
    view.selectedSegmentIndex = selectedIndex < items.count ? selectedIndex : 0;
    switch (type.integerValue) {
        case 1:
        {
            view.tintColor = UIColor.themeColor;
            view.backgroundColor = UIColor.whiteColor;
            
            view.layer.borderWidth = 1;
            view.layer.borderColor = UIColor.whiteColor.CGColor;
            
            NSDictionary * dict = @{
                                    NSForegroundColorAttributeName: UIColor.blackColor,
                                    NSFontAttributeName:            [UIFont systemFontOfSize:15],
                                    
                                    };
            
            [view setTitleTextAttributes:dict forState:UIControlStateNormal];
            [view setDividerImage:UIImageColor(UIColor.whiteColor) forLeftSegmentState:UIControlStateNormal rightSegmentState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
            
        }
            break;
        case 2:
        {
            view.tintColor = UIColor.whiteColor;
            view.backgroundColor = UIColor.whiteColor;
            
            NSDictionary *attDic_N = @{
                                       NSFontAttributeName:             [UIFont boldSystemFontOfSize:15],
                                       NSForegroundColorAttributeName:  UIColor.blackColor,
                                       };
            
            NSDictionary *attDic_H = @{
                                       NSFontAttributeName:             [UIFont boldSystemFontOfSize:18],
                                       NSForegroundColorAttributeName:  UIColor.themeColor,
                                       };
            
            [view setTitleTextAttributes:attDic_N forState:UIControlStateNormal];
            [view setTitleTextAttributes:attDic_H forState:UIControlStateSelected];
            
        }
            break;
        case 3:
        {
            //背景透明,只有标题颜色
            // 去掉颜色,现在整个segment偶看不到,可以相应点击事件
            view.tintColor = UIColor.clearColor;
            view.backgroundColor = UIColor.lineColor;
            
            // 正常状态下
            NSDictionary * attDic_N = @{
                                        NSForegroundColorAttributeName: UIColor.blackColor,
                                        NSFontAttributeName:            [UIFont systemFontOfSize:15.0f],
                                        
                                        };
            
            // 选中状态下
            NSDictionary * attDic_H = @{
                                        NSForegroundColorAttributeName: UIColor.themeColor,
                                        NSFontAttributeName:            [UIFont boldSystemFontOfSize:18.0f],
                                        
                                        };
            [view setTitleTextAttributes:attDic_N forState:UIControlStateNormal];
            [view setTitleTextAttributes:attDic_H forState:UIControlStateSelected];
        }
            break;
        default:
        {
            view.tintColor = UIColor.themeColor;
            view.backgroundColor = UIColor.whiteColor;
            
            NSDictionary * dict = @{
                                    NSFontAttributeName:    [UIFont systemFontOfSize:15],
                                    
                                    };
            
            [view setTitleTextAttributes:dict forState:UIControlStateNormal];
        }
            break;
    }
    return view;
}

- (void)ensureiOS12Style {
    // UISegmentedControl has changed in iOS 13 and setting the tint
    // color now has no effect.
    if (@available(iOS 13, *)) {
        UIColor *tintColor = self.tintColor;
        UIImage *tintColorImage = UIImageColor(tintColor);
        // Must set the background image for normal to something (even clear) else the rest won't work
        [self setBackgroundImage:UIImageColor(self.backgroundColor ? : UIColor.clearColor) forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
        [self setBackgroundImage:tintColorImage forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
        [self setBackgroundImage:UIImageColor([tintColor colorWithAlphaComponent:0.2]) forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
        [self setBackgroundImage:tintColorImage forState:UIControlStateSelected|UIControlStateSelected barMetrics:UIBarMetricsDefault];
        [self setTitleTextAttributes:@{NSForegroundColorAttributeName: tintColor,
                                       NSFontAttributeName: [UIFont systemFontOfSize:13]} forState:UIControlStateNormal];
        [self setDividerImage:tintColorImage
          forLeftSegmentState:UIControlStateNormal
            rightSegmentState:UIControlStateNormal
                   barMetrics:UIBarMetricsDefault];
        self.layer.borderWidth = 1;
        self.layer.borderColor = tintColor.CGColor;
    }
}

@end
