//
//  UICollectionReusableView+AddView.h
//  
//
//  Created by BIN on 2018/8/24.
//  Copyright © 2018年 SHANG. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "NSObject+Helper.h"
#import "UIView+Helper.h"

#import "UICollectionView+Helper.h"

NS_ASSUME_NONNULL_BEGIN

@interface UICollectionReusableView (AddView)

@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UILabel *labelSub;

+ (instancetype)dequeueSupplementaryView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath kind:(NSString *)kind;

@end

NS_ASSUME_NONNULL_END
