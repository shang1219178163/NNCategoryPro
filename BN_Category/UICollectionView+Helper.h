//
//  UICollectionView+Helper.h
//  BN_ExcelView
//
//  Created by hsf on 2018/4/12.
//  Copyright © 2018年 BN. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString * const UICollectionElementSectionItem = @"UICollectionElementSectionItem";

@interface UICollectionView (Helper)

@property (nonatomic, strong) NSArray * listClass;

/**
 注意字典格式,如下
 collectionView.dictClass = @{
                                 UICollectionElementSectionItem   :     @[
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

- (void)bn_registerListClass:(NSArray *)listClass;
- (void)bn_registerListClassReusable:(NSArray *)listClass kind:(NSString *)kind;


@end
