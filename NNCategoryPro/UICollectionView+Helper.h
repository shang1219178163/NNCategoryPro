//
//  UICollectionView+Helper.h
//  BNExcelView
//
//  Created by BIN on 2018/4/12.
//  Copyright © 2018年 BN. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// UICollectionElementKindSectionItem
FOUNDATION_EXPORT NSString * const UICollectionElementKindSectionItem ;
 
@interface UICollectionView (Helper)

@property (nonatomic, strong, class) UICollectionViewLayout *layoutDefault;
/**
 注意字典格式,如下
 collectionView.dictClass = @{UICollectionElementKindSectionItem:    @[@"UICollectionViewCell",],
                              UICollectionElementKindSectionHeader:  @[@"UICollectionReusableOneView",],
                              UICollectionElementKindSectionFooter:  @[@"UICollectionReusableOneView",],
 };
 */
@property (nonatomic, strong) NSDictionary<NSString *, NSArray <NSString *>*> *dictClass;

/**
 [源]UICollectionView创建方法
 */
+ (instancetype)createRect:(CGRect)rect layout:(UICollectionViewLayout *)layout;

/// 注册 cell
/// @param dictClass key: UICollectionElementKindSectionHeader/UICollectionElementKindSectionFooter/UICollectionElementKindSectionItem
/// @param dictClass Value: ["UICollectionViewCell", ]
- (void)registerReuseIdentifier:(NSDictionary<NSString *, NSArray<NSString *> *> *)dictClass;

/// 注册 cell
/// @param kind UICollectionElementKindSectionHeader/UICollectionElementKindSectionFooter/UICollectionElementKindSectionItem
/// @param list ["UICollectionViewCell", ]
- (void)registerReuseIdentifier:(NSString *)kind list:(NSArray<NSString *> *)list;


- (UICollectionViewLayout *)createLayout:(NSInteger)numOfRow
                              itemHeight:(CGFloat)itemHeight
                                 spacing:(CGFloat)spacing
                            headerHeight:(CGFloat)headerHeight
                            footerHeight:(CGFloat)footerHeight;

- (void)scrollItemToCenterAtIndexPath:(NSIndexPath *)indexPath animated:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END
