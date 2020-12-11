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
 collectionView.dictClass = @{
                                 UICollectionElementKindSectionItem:    @[@"UICollectionViewCell",
                                                                         ],
                                 UICollectionElementKindSectionHeader:  @[@"UICollectionReusableOneView",
                                                                        ],
                                 UICollectionElementKindSectionFooter:  @[@"UICollectionReusableOneView",
                                                                         ],
 
 };
 */
@property (nonatomic, strong) NSDictionary *dictClass;

/**
 [源]UICollectionView创建方法
 */
+ (instancetype)createRect:(CGRect)rect layout:(UICollectionViewLayout *)layout;

+ (NSString *)cellIdentifierByClassName:(NSString *)className;
+ (NSString *)viewIdentifierByClassName:(NSString *)className kind:(NSString *)kind;

- (void)registerCTVCell:(NSArray *)listClass;
- (void)registerCTVReusable:(NSArray *)listClass kind:(NSString *)kind;

- (UICollectionViewLayout *)createLayout:(NSInteger)numOfRow
                              itemHeight:(CGFloat)itemHeight
                                 spacing:(CGFloat)spacing
                            headerHeight:(CGFloat)headerHeight
                            footerHeight:(CGFloat)footerHeight;

- (void)scrollItemToCenterAtIndexPath:(NSIndexPath *)indexPath animated:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END
