
//
//  UIViewController+AddView.m
//  BNSeparatorView
//
//  Created by BIN on 2018/8/23.
//  Copyright © 2018年 BIN. All rights reserved.
//

#import "UIViewController+AddView.h"
#import <objc/runtime.h>

//#import "UIView+AddView.h"
#import "UILabel+Helper.h"
#import "UITableView+Helper.h"

@implementation UIViewController (AddView)

- (UITableView *)tbView{
    id obj = objc_getAssociatedObject(self, _cmd);
    if (obj) {
        return obj;
    }
    
    UITableView *view = [UITableView createRect:self.view.bounds style:UITableViewStylePlain];
    if ([self conformsToProtocol:@protocol(UITableViewDataSource)]) view.dataSource = self;
    if ([self conformsToProtocol:@protocol(UITableViewDelegate)]) view.delegate = self;
    
    objc_setAssociatedObject(self, _cmd, view, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    return view;
}

- (UILabel *)tipLabel{
    id obj = objc_getAssociatedObject(self, _cmd);
    if (obj) {
        return obj;
    }
    
    UILabel *view = [UILabel createRect:CGRectZero type:NNLabelTypeFitWidth];
    view.textAlignment = NSTextAlignmentLeft;
    objc_setAssociatedObject(self, _cmd, view, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    return view;
}

@end

