//
//  UIViewController+swizzling.m
//  HuiZhuBang
//
//  Created by BIN on 2017/12/2.
//  Copyright © 2017年 WeiHouKeJi. All rights reserved.
//

#import "UIViewController+swizzling.h"

#import "NSObject+swizzling.h"

#define isOpen 1

@implementation UIViewController (swizzling)

//+ (void)load {
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        if (isOpen) {
//            [self swizzleMethodClass:self.class origSel:@selector(viewDidLoad) newSel:@selector(swizzlingViewDidLoad)];
//
//        }
//    });
//}

+ (void)initialize{
    if (self == self.class) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            if (isOpen) {
                [self swizzleMethodClass:self.class origSel:@selector(viewDidLoad) newSel:@selector(swizzlingViewDidLoad)];
                
            }
        });
    }
}

// 我们自己实现的方法，也就是和self的viewDidLoad方法进行交换的方法。
- (void)swizzlingViewDidLoad {
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
//    self.view.backgroundColor = UIColor.whiteColor;//警告:此行代码可能会有问题
//    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];

    [self eventGather];
    [self swizzlingViewDidLoad];

}

-(void)eventGather{
    // 我们在这里加一个判断，将系统的UIViewController的对象剔除掉
    if(![NSStringFromClass(self.class) containsString:@"UI"]){
//        NSLog(@"统计打点 : %@", self.class);
        
    }
}

@end
