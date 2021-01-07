//
//  UICollectionViewLayout+AddView.h
//  
//
//  Created by BIN on 2018/8/24.
//  Copyright © 2018年 SHANG. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UICollectionViewLayout (AddView)


@end


@interface UICollectionViewFlowLayout (AddView)

@property(nonatomic, strong, readonly) UICollectionViewFlowLayout *(^minimumLineSpacing)(CGFloat);
@property(nonatomic, strong, readonly) UICollectionViewFlowLayout *(^minimumInteritemSpacing)(CGFloat);
@property(nonatomic, strong, readonly) UICollectionViewFlowLayout *(^itemSize)(CGSize);
@property(nonatomic, strong, readonly) UICollectionViewFlowLayout *(^headerReferenceSize)(CGSize);
@property(nonatomic, strong, readonly) UICollectionViewFlowLayout *(^footerReferenceSize)(CGSize);

@property(nonatomic, strong, readonly) UICollectionViewFlowLayout *(^estimatedItemSize)(CGSize);
@property(nonatomic, strong, readonly) UICollectionViewFlowLayout *(^scrollDirection)(UICollectionViewScrollDirection);

@property(nonatomic, strong, readonly) UICollectionViewFlowLayout *(^sectionInset)(UIEdgeInsets);
@property(nonatomic, strong, readonly) UICollectionViewFlowLayout *(^sectionInsetReference)(UICollectionViewFlowLayoutSectionInsetReference);
@property(nonatomic, strong, readonly) UICollectionViewFlowLayout *(^sectionFootersPinToVisibleBounds)(BOOL);
@property(nonatomic, strong, readonly) UICollectionViewFlowLayout *(^sectionHeadersPinToVisibleBounds)(BOOL);


@property(class, nonatomic, strong) UICollectionViewFlowLayout *layoutDefault;

+ (instancetype)createItemSize:(CGSize)itemSize
                       spacing:(CGFloat)spacing
                    headerSize:(CGSize)headerSize
                    footerSize:(CGSize)footerSize;

@end

NS_ASSUME_NONNULL_END
