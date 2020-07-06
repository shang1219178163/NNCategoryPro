
//
//  UIViewController+AddView.m
//  BNSeparatorView
//
//  Created by BIN on 2018/8/23.
//  Copyright © 2018年 BIN. All rights reserved.
//

#import "UIViewController+AddView.h"
#import <objc/runtime.h>

#import "UIView+AddView.h"
#import "UILabel+Helper.h"
#import "UICollectionView+Helper.h"
#import "UIColor+Helper.h"
#import "UITableView+Helper.h"

@implementation UIViewController (AddView)

- (UITableView *)tbView{
    UITableView *view = objc_getAssociatedObject(self, _cmd);
    if (!view) {
        view = [UITableView createRect:self.view.bounds style:UITableViewStylePlain];
        if ([self conformsToProtocol:@protocol(UITableViewDataSource)]) view.dataSource = self;
        if ([self conformsToProtocol:@protocol(UITableViewDelegate)]) view.delegate = self;
        objc_setAssociatedObject(self, _cmd, view, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return view;
}

//- (void)setTbView:(UITableView *)tbView{
//    objc_setAssociatedObject(self, @selector(tbView), tbView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//}

- (UITableView *)tbViewGrouped{
    UITableView *view = objc_getAssociatedObject(self, _cmd);
    if (!view) {
        view = [UITableView createRect:self.view.bounds style:UITableViewStyleGrouped];
        if ([self conformsToProtocol:@protocol(UITableViewDataSource)]) view.dataSource = self;
        if ([self conformsToProtocol:@protocol(UITableViewDelegate)]) view.delegate = self;
        objc_setAssociatedObject(self, _cmd, view, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return view;
}

//- (void)setTbViewGrouped:(UITableView *)tbViewGrouped{
//    objc_setAssociatedObject(self, @selector(tbViewGrouped), tbViewGrouped, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//}

- (UICollectionView *)ctView{
    UICollectionView *view = objc_getAssociatedObject(self, _cmd);
    if (!view) {
        view = ({
            UICollectionView *view = [[UICollectionView alloc]initWithFrame:self.view.bounds
                                                       collectionViewLayout:UICollectionView.layoutDefault];
            view.backgroundColor = UIColor.whiteColor;
            view.showsVerticalScrollIndicator = false;
            view.showsHorizontalScrollIndicator = false;
            view.scrollsToTop = false;
            view.pagingEnabled = true;
            [view registerClass:UICollectionViewCell.class forCellWithReuseIdentifier:@"UICollectionViewCell"];
            
            view;
        });
        objc_setAssociatedObject(self, _cmd, view, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return view;
}

//- (void)setCtView:(UICollectionView *)ctView{
//    objc_setAssociatedObject(self, @selector(ctView), ctView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//}

- (UILabel *)tipLabel{
    UILabel *view = objc_getAssociatedObject(self, _cmd);
    if (!view) {
        view = [UILabel createRect:CGRectZero type:@2];
        view.textAlignment = NSTextAlignmentLeft;
        objc_setAssociatedObject(self, _cmd, view, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return view;
}

//- (void)setTipLabel:(UILabel *)tipLabel{
//    objc_setAssociatedObject(self, @selector(tipLabel), tipLabel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//}

@end

