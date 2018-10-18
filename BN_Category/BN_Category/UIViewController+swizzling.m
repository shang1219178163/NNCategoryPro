//
//  UIViewController+swizzling.m
//  HuiZhuBang
//
//  Created by BIN on 2017/12/2.
//  Copyright © 2017年 WeiHouKeJi. All rights reserved.
//

#import "UIViewController+swizzling.h"

#import "NSObject+swizzling.h"

#define isOpen 0

@implementation UIViewController (swizzling)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
//        // 通过class_getInstanceMethod()函数从当前对象中的method list获取method结构体，如果是类方法就使用class_getClassMethod()函数获取。
//        Method methodNative = class_getInstanceMethod([self class], @selector(viewDidLoad));
//        Method methodNew = class_getInstanceMethod([self class], @selector(swizzlingViewDidLoad));
//        /**
//         *  我们在这里使用class_addMethod()函数对Method Swizzling做了一层验证，如果self没有实现被交换的方法，会导致失败。
//         *  而且self没有交换的方法实现，但是父类有这个方法，这样就会调用父类的方法，结果就不是我们想要的结果了。
//         *  所以我们在这里通过class_addMethod()的验证，如果self实现了这个方法，class_addMethod()函数将会返回NO，我们就可以对其进行交换了。
//         */
//        if (!class_addMethod([self class], @selector(swizzlingViewDidLoad), method_getImplementation(methodNew), method_getTypeEncoding(methodNew))) {
//            method_exchangeImplementations(methodNative, methodNew);
//        }
        
        if (isOpen) {
            [self swizzleMethodClass:[self class] origMethod:@selector(viewDidLoad) newMethod:@selector(swizzlingViewDidLoad)];

        }
   
    });
}

// 我们自己实现的方法，也就是和self的viewDidLoad方法进行交换的方法。
- (void)swizzlingViewDidLoad {
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self createBtnBack];
    [self eventGather];
    
    [self swizzlingViewDidLoad];
}

- (void)createBtnBack{
    SEL selector = NSSelectorFromString(@"btnClick:");
    if ([self respondsToSelector:selector]) {
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:@selector(selector)];

    }
    else{
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:@selector(handleActionBtnBack)];
        
    }
}

- (void)handleActionBtnBack{
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)eventGather{
    NSString *str = [NSString stringWithFormat:@"%@", self.class];
    // 我们在这里加一个判断，将系统的UIViewController的对象剔除掉
    if(![str containsString:@"UI"]){
//        NSLog(@"统计打点 : %@", self.class);
        
    }
}

@end
