
//
//  UIViewController+AddView.m
//  BNSeparatorView
//
//  Created by BIN on 2018/8/23.
//  Copyright © 2018年 BIN. All rights reserved.
//

#import "UIViewController+AddView.h"

#import <objc/runtime.h>

#import "UICollectionView+Helper.h"
#import "UIColor+Helper.h"

@implementation UIViewController (AddView)

- (UITableView *)tbView{
    UITableView *view = objc_getAssociatedObject(self, _cmd);
    if (!view) {
        view = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        view.separatorInset = UIEdgeInsetsZero;
        view.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        view.rowHeight = 70;
        view.backgroundColor = UIColor.backgroudColor;
        view.tableFooterView = [[UIView alloc]init];

//        table.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        [view registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
        if ([self conformsToProtocol:@protocol(UITableViewDataSource)]) view.dataSource = self;
        if ([self conformsToProtocol:@protocol(UITableViewDelegate)]) view.delegate = self;      

        objc_setAssociatedObject(self, _cmd, view, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return view;
}

- (void)setTbView:(UITableView *)tbView{
    objc_setAssociatedObject(self, @selector(tbView), tbView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UICollectionView *)ctView{
    UICollectionView *view = objc_getAssociatedObject(self, _cmd);
    if (!view) {
        view = ({
            UICollectionView *view = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:UICollectionView.layoutDefault];
            view.backgroundColor = UIColor.whiteColor;
            view.showsVerticalScrollIndicator = false;
            view.showsHorizontalScrollIndicator = false;
            view.scrollsToTop = false;
            view.pagingEnabled = true;
//            view.dictClass = self.dictClass;
            
            view;
        });
        objc_setAssociatedObject(self, _cmd, view, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return view;
}

- (void)setCtView:(UICollectionView *)ctView{
    objc_setAssociatedObject(self, @selector(ctView), ctView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(NSInteger)pageIndex{
    return [objc_getAssociatedObject(self, _cmd) integerValue];
}

-(void)setPageIndex:(NSInteger)pageIndex{
    objc_setAssociatedObject(self, @selector(pageIndex), @(pageIndex), OBJC_ASSOCIATION_ASSIGN);
}

-(NSMutableArray *)dataList{
    NSMutableArray * list = objc_getAssociatedObject(self, _cmd);
    if (!list) {
        list = [NSMutableArray array];
        objc_setAssociatedObject(self, _cmd, list, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return list;
}

-(void)setDataList:(NSMutableArray *)dataList{
    objc_setAssociatedObject(self, @selector(dataList), dataList, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(NSMutableDictionary *)heightMdict{
    NSMutableDictionary * dic = objc_getAssociatedObject(self, _cmd);
    if (!dic) {
        dic = [NSMutableDictionary dictionary];
        objc_setAssociatedObject(self, _cmd, dic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return dic;
}

-(void)setHeightMdic:(NSMutableDictionary *)heightMdic{
    objc_setAssociatedObject(self, @selector(heightMdic), heightMdic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end

