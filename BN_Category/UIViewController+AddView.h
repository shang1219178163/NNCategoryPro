//
//  UIViewController+AddView.h
//  BN_SeparatorView
//
//  Created by BIN on 2018/8/23.
//  Copyright © 2018年 BIN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (AddView)<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray * dataList;
@property (nonatomic, assign) NSInteger pageIndex;

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSDictionary *dictClass;

@property (nonatomic, strong) NSMutableDictionary * heightMdic;

@end
