//
//  UIViewController+Hook.m
//  NNCategoryPro
//
//  Created by Bin Shang on 2019/12/27.
//

#import "UIViewController+Hook.h"
#import "NSObject+Hook.h"
#import "UIViewController+Helper.h"

@implementation UIViewController (Hook)
 
+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if ([self isMemberOfClass: UIViewController.class]) {
            hookInstanceMethod(self.class, @selector(viewDidLoad), @selector(hook_viewDidLoad));
            hookInstanceMethod(self.class, @selector(viewWillAppear:), @selector(hook_viewWillAppear:));
            hookInstanceMethod(self.class, @selector(viewDidDisappear:), @selector(hook_viewDidDisappear:));
            
            hookInstanceMethod(self.class, @selector(presentViewController:animated:completion:), @selector(hook_presentViewController:animated:completion:));
        } else {
            hookInstanceMethod(self.class, @selector(pushViewController:animated:), @selector(hook_PushViewController:animated:));
        }
    });
}

// 我们自己实现的方法，也就是和self的viewDidLoad方法进行交换的方法。
- (void)hook_viewDidLoad {
    [self hook_viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)hook_viewWillAppear:(BOOL)animated{
    [self hook_viewWillAppear:animated];
    
//    [self eventGather:YES];
}

- (void)hook_viewDidDisappear:(BOOL)animated{
    [self hook_viewDidDisappear:animated];
    
//    [self eventGather:NO];
}

- (void)hook_presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion {
    if (viewControllerToPresent.presentationController == nil) {
        [viewControllerToPresent.presentationController.presentingViewController dismissViewControllerAnimated:false completion:nil];
        NSLog(@"viewControllerToPresent.presentationController 不能为 nil");
        return;
    }
    [self hook_presentViewController:viewControllerToPresent animated:flag completion:completion];
}

#pragma mark -funtions

/// 日志收集/埋点
- (void)logGather:(BOOL)isBegin{
    NSString *className = NSStringFromClass(self.class);
    //设置不允许发送数据的Controller
    NSArray *filters = @[@"UINavigationController", @"UITabBarController"];
    if ([filters containsObject:className]) return ;

    if ([self.title isKindOfClass:[NSString class]] && self.title.length > 0){ //有标题的才符合我的要求
        // 这里发送log
        NSLog(@"统计打点 : %@   开始打点:%@", self.class, @(isBegin));
    }
}

- (void)changeAppIconAction {
    NSLog(@"替换图标成功");
}

#pragma mark -滑动开始会触发

-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    // 手势
    if ([self isKindOfClass:[UINavigationController class]]) {
        if(gestureRecognizer == ((UINavigationController *)self).interactivePopGestureRecognizer){
            if(((UINavigationController *)self).viewControllers.count < 2){
                return false;
            }
        }
    }
    return true;
}


@end



@implementation UINavigationController (Hook)

- (void)hook_PushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if ([self.viewControllers containsObject:viewController]) return;
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        
        UIView *customView = [viewController createBackItem:[UIImage imageNamed:@"icon_arowLeft_black"]];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:customView];
    }
    [self hook_PushViewController:viewController animated:animated];
}


@end
