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

@property (nonatomic, strong, readonly) UITableView *tbView;
@property (nonatomic, strong, readonly) UITableView *tbViewGrouped;

@property (nonatomic, strong, readonly) UICollectionView *ctView;
@property (nonatomic, strong, readonly) UILabel *tipLabel;

@end

NS_ASSUME_NONNULL_END
