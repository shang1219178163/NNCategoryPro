//
//  UICollectionView+Helper.h
//  BNExcelView
//
//  Created by BIN on 2018/4/12.
//  Copyright © 2018年 BN. All rights reserved.
//

#import <UIKit/UIKit.h>

FOUNDATION_EXPORT NSString * const UICollectionElementKindSectionItem ;

@interface UICollectionView (Helper)

@property (nonatomic, strong, class) UICollectionViewLayout * layoutDefault;

@property (nonatomic, strong) NSArray * listClass;

/**
 注意字典格式,如下
 collectionView.dictClass = @{
                                 UICollectionElementKindSectionItem   :     @[
                                                                         @"UICollectionViewCell",
                                                                         ],
                                 UICollectionElementKindSectionHeader   :   @[
                                                                            @"UICollectionReusableOneView",
                                                                            ],
                                 UICollectionElementKindSectionFooter   :   @[
                                                                             @"UICollectionReusableOneView",
                                                                             ],
 
 };
 */
@property (nonatomic, strong) NSDictionary * dictClass;

+ (NSString *)cellIdentifierByClassName:(NSString *)className;
+ (NSString *)viewIdentifierByClassName:(NSString *)className kind:(NSString *)kind;

- (void)BNregisterListClass:(NSArray *)listClass;
- (void)BNregisterListClassReusable:(NSArray *)listClass kind:(NSString *)kind;

- (UICollectionViewFlowLayout *)createItemHeight:(CGFloat)itemHeight spacing:(CGFloat)spacing headerHeight:(CGFloat)headerHeight footerHeight:(CGFloat)footerHeight;

@end
