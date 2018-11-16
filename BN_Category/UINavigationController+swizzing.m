//
//  UINavigationController+swizzing.m
//  BN_Category
//
//  Created by hsf on 2018/11/16.
//

#import "UINavigationController+swizzing.h"

#import "NSObject+swizzling.h"

@implementation UINavigationController (swizzing)

+ (void)initialize{
    if (self == self.class) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            if (1) {
                [self swizzleMethodClass:self.class origSel:@selector(pushViewController:animated:) newSel:@selector(swzPushViewController:animated:)];
                
            }
        });
    }
}

- (void)swzPushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if ([self.viewControllers containsObject:viewController]) return;
    viewController.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    viewController.view.backgroundColor = UIColor.whiteColor;

    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        
    }
    [self swzPushViewController:viewController animated:animated];
}

@end
