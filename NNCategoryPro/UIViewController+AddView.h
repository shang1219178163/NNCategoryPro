//
//  UIViewController+AddView.h
//  BNSeparatorView
//
//  Created by BIN on 2018/8/23.
//  Copyright © 2018年 BIN. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (AddView)<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tbView;
@property (nonatomic, strong) UITableView *tbViewGrouped;

@property (nonatomic, strong) UICollectionView *ctView;
@property (nonatomic, assign) NSInteger pageIndex;
@property (nonatomic, strong) NSMutableArray * dataList;
@property (nonatomic, strong) NSMutableDictionary * heightMdic;

@end

NS_ASSUME_NONNULL_END
