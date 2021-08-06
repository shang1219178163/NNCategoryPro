//
//  UITableViewHeaderFooterView+Helper.h
//  
//
//  Created by BIN on 2018/8/24.
//  Copyright © 2018年 SHANG. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "NSObject+Helper.h"
#import "UIView+Helper.h"

NS_ASSUME_NONNULL_BEGIN

@interface UITableViewHeaderFooterView (Helper)

+(instancetype)dequeueReusableHeaderFooterView:(UITableView *)tableView identifier:(NSString *)identifier;

+(instancetype)dequeueReusableHeaderFooterView:(UITableView *)tableView;

@end


@interface UITableViewHeaderFooterView (AddView)

@property (nonatomic, strong) UIImageView *indicatorView;
@property (nonatomic, strong) UIImageView *imgViewLeft;
@property (nonatomic, strong) UIImageView *imgViewRight;

@property (nonatomic, strong) UILabel *labelLeft;
@property (nonatomic, strong) UILabel *labelLeftMark;
@property (nonatomic, strong) UILabel *labelLeftSub;
@property (nonatomic, strong) UILabel *labelLeftSubMark;

@property (nonatomic, strong) UIButton *btn;

@property (nonatomic, assign) BOOL isOpen;
@property (nonatomic, assign) BOOL isCanOPen;//默认为NO

@property (nonatomic, copy) void (^blockView)(UITableViewHeaderFooterView *foldView,NSInteger index);

@end
 

NS_ASSUME_NONNULL_END
