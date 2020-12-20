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

/**
 [源]UISegmentedControl创建方法
 */
+ (instancetype)createRect:(CGRect)rect
                     items:(NSArray *)items
                      type:(NSNumber *)type{
    UISegmentedControl *view = [[self alloc] initWithItems:items];
    view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    view.frame = rect;
    
    if (@available(iOS 13, *)) {
        view.tintColor = UIColor.whiteColor;
        [view ensureiOS13Style];
        return view;
    }
    
    view.selectedSegmentIndex = 0;
    switch (type.integerValue) {
        case 1:
        {
            view.tintColor = UIColor.themeColor;
            view.backgroundColor = UIColor.whiteColor;
            
            view.layer.borderWidth = 1;
            view.layer.borderColor = UIColor.whiteColor.CGColor;
            
            NSDictionary * dict = @{NSForegroundColorAttributeName: UIColor.blackColor,
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
            
            NSDictionary *attDic_N = @{NSFontAttributeName:             [UIFont boldSystemFontOfSize:15],
                                       NSForegroundColorAttributeName:  UIColor.blackColor,
                                       };
            
            NSDictionary *attDic_H = @{NSFontAttributeName:             [UIFont boldSystemFontOfSize:18],
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
            NSDictionary * attDic_N = @{NSForegroundColorAttributeName: UIColor.blackColor,
                                        NSFontAttributeName:            [UIFont systemFontOfSize:15.0f],
                                        };
            
            // 选中状态下
            NSDictionary * attDic_H = @{NSForegroundColorAttributeName: UIColor.themeColor,
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
            
            NSDictionary * dict = @{NSFontAttributeName: [UIFont systemFontOfSize:15],
                                    };
            
            [view setTitleTextAttributes:dict forState:UIControlStateNormal];
        }
            break;
    }
    return view;
}

- (void)ensureiOS13Style {
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


@end
