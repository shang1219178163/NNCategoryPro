//
//  UIViewController+AddView.h
//  BN_SeparatorView
//
//  Created by BIN on 2018/8/23.
//  Copyright © 2018年 BIN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (AddView)

@property (nonatomic, strong, readonly) NSString * _Nullable controllerName;
@property (nonatomic, strong, readonly) UIViewController * _Nullable frontController;

@property (nonatomic, strong) id obj;
@property (nonatomic, strong) id objOne;


@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray * dataList;
@property (nonatomic, assign) NSInteger pageIndex;

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSDictionary *dictClass;

@property (nonatomic, strong) NSMutableDictionary * heightMdic;

@end
