//
//  UICollectionViewCell+AddView.h
//  
//
//  Created by BIN on 2018/8/24.
//  Copyright © 2018年 SHANG. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "NSObject+Helper.h"
#import "UIColor+Helper.h"

#import "UICollectionView+Helper.h"

NS_ASSUME_NONNULL_BEGIN

@interface UICollectionViewCell (AddView)

@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UILabel *labelSub;

+ (instancetype)dequeueReusableCell:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath;

+ (instancetype)dequeueReusableCell:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath identifier:(NSString *)identifier;

@end

NS_ASSUME_NONNULL_END
