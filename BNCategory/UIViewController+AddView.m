
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

- (UITableView *)tableView {
    UITableView* view = objc_getAssociatedObject(self, _cmd);
    if (!view) {
        view = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        view.separatorInset = UIEdgeInsetsZero;
        view.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        view.rowHeight = 60;
        view.backgroundColor = UIColor.backgroudColor;
//        table.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        [view registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
        if ([self conformsToProtocol:@protocol(UITableViewDataSource)]) view.dataSource = self;
        if ([self conformsToProtocol:@protocol(UITableViewDelegate)]) view.delegate = self;      

        objc_setAssociatedObject(self, _cmd, view, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return view;
}

-(void)setTableView:(UITableView *)tableView{
    objc_setAssociatedObject(self, @selector(tableView), tableView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UICollectionView *)collectionView{
    UICollectionView* view = objc_getAssociatedObject(self, _cmd);
    if (!view) {
        view = ({
            UICollectionView *view = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:UICollectionView.layoutDefault];
            view.backgroundColor = UIColor.whiteColor;
            view.scrollsToTop = NO;
            view.showsVerticalScrollIndicator = NO;
            view.showsHorizontalScrollIndicator = NO;
//            view.dictClass = self.dictClass;
            
            view;
        });
        objc_setAssociatedObject(self, _cmd, view, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return view;
}

-(NSInteger)pageIndex{
    return [objc_getAssociatedObject(self, _cmd) integerValue];
}

-(void)setPageIndex:(NSInteger)pageIndex{
    objc_setAssociatedObject(self, @selector(pageIndex), @(pageIndex), OBJC_ASSOCIATION_ASSIGN);
}

-(void)setCollectionView:(UICollectionView *)collectionView{
    objc_setAssociatedObject(self, @selector(collectionView), collectionView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
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

