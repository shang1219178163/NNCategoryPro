//
//  UINavigationController+Hook.m
//  NNCategoryPro
//
//  Created by Bin Shang on 2019/12/27.
//

#import "UINavigationController+Hook.h"

#import "NSObject+Hook.h"
#import "UIViewController+Helper.h"

@implementation UINavigationController (Hook)

+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SwizzleMethodInstance(self.class, @selector(pushViewController:animated:), @selector(hook_PushViewController:animated:));
        
    });
}

- (void)hook_PushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if ([self.viewControllers containsObject:viewController]) return;
//    viewController.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    viewController.view.backgroundColor = UIColor.whiteColor;
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:viewController.backBtn];;
   
    }
    [self hook_PushViewController:viewController animated:animated];
}

//- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
//    if ([gestureRecognizer isKindOfClass:[UIScreenEdgePanGestureRecognizer class]]) {
//        return  self.navigationController.viewControllers.count > 1;
//    }
//    return YES;
//}

@end
