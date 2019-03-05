//
//  UIViewController+swizzling.m
//  
//
//  Created by BIN on 2017/12/2.
//  Copyright © 2017年 SHANG. All rights reserved.
//

#import "UIViewController+swizzling.h"

#import "NSObject+swizzling.h"

@implementation UIViewController (swizzling)

+ (void)initialize{
    if (self == self.class) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
//            NSLog(@"%@,%@,%@",self,self.class,NSClassFromString(@"UIViewController"));
//            SwizzleMethodInstance(self.class, @selector(viewDidLoad), @selector(swz_viewDidLoad));
//            SwizzleMethodInstance(UIViewController.class, @selector(viewWillAppear:), @selector(swz_viewWillAppear:));
//            SwizzleMethodInstance(@"UIViewController", @selector(viewDidDisappear:), @selector(swz_viewDidDisappear:));
     
            SwizzleMethodInstance(@"UIViewController", @selector(viewDidLoad), @selector(swz_viewDidLoad));
            SwizzleMethodInstance(@"UIViewController", @selector(viewWillAppear:), @selector(swz_viewWillAppear:));
            SwizzleMethodInstance(@"UIViewController", @selector(viewDidDisappear:), @selector(swz_viewDidDisappear:));
            
        });
    }
}

// 我们自己实现的方法，也就是和self的viewDidLoad方法进行交换的方法。
- (void)swz_viewDidLoad {
    if ([self isKindOfClass:UINavigationController.class]) {
        UINavigationController * navController = (UINavigationController *)self;
        //1.获取系统interactivePopGestureRecognizer对象的target对象
        id target = navController.interactivePopGestureRecognizer.delegate;
        //2.创建滑动手势，taregt设置interactivePopGestureRecognizer的target，所以当界面滑动的时候就会自动调用target的action方法。
        //handleNavigationTransition是私有类_UINavigationInteractiveTransition的方法，系统主要在这个方法里面实现动画的。
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] init];
        [pan addTarget:target action:NSSelectorFromString(@"handleNavigationTransition:")];
        //3.设置代理
        pan.delegate = self;
        //4.添加到导航控制器的视图上
        [navController.view addGestureRecognizer:pan];
        
        //5.禁用系统的滑动手势
        navController.interactivePopGestureRecognizer.enabled = NO;
    } else {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.automaticallyAdjustsScrollViewInsets = NO;
        //    self.view.backgroundColor = UIColor.whiteColor;//警告:此行代码可能会有问题
        //    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    }
    [self swz_viewDidLoad];

}

- (void)swz_viewWillAppear:(BOOL)animated{
    [self swz_viewWillAppear:animated];
    
//    [self eventGather:YES];
}

- (void)swz_viewDidDisappear:(BOOL)animated{
    [self swz_viewDidDisappear:animated];
    
//    [self eventGather:NO];
}

- (void)eventGather:(BOOL)isBegin{
    NSString *className = NSStringFromClass(self.class);
    //设置不允许发送数据的Controller
    NSArray *filters = @[@"UINavigationController",@"UITabBarController"];
    if ([filters containsObject:className]) return ;

    if ([self.title isKindOfClass:[NSString class]] && self.title.length > 0){ //有标题的才符合我的要求
        // 这里发送log
        NSLog(@"统计打点 : %@   开始打点:%@", self.class,@(isBegin));

    }
}

#pragma mark - 滑动开始会触发
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    if ([self isKindOfClass:UINavigationController.class]) {
        if ([gestureRecognizer isKindOfClass:[UIScreenEdgePanGestureRecognizer class]]) {
            return ((UINavigationController *)self).viewControllers.count > 1;
        }
    }
    return YES;
}


@end
