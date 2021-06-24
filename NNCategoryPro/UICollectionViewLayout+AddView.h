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

@property(nonatomic, strong, readonly) UICollectionViewFlowLayout *(^minimumLineSpacingChain)(CGFloat);
@property(nonatomic, strong, readonly) UICollectionViewFlowLayout *(^minimumInteritemSpacingChain)(CGFloat);
@property(nonatomic, strong, readonly) UICollectionViewFlowLayout *(^itemSizeChain)(CGSize);
@property(nonatomic, strong, readonly) UICollectionViewFlowLayout *(^headerReferenceSizeChain)(CGSize);
@property(nonatomic, strong, readonly) UICollectionViewFlowLayout *(^footerReferenceSizeChain)(CGSize);

@property(nonatomic, strong, readonly) UICollectionViewFlowLayout *(^estimatedItemSizeChain)(CGSize);
@property(nonatomic, strong, readonly) UICollectionViewFlowLayout *(^scrollDirectionChain)(UICollectionViewScrollDirection);

@property(nonatomic, strong, readonly) UICollectionViewFlowLayout *(^sectionInsetChain)(UIEdgeInsets);
@property(nonatomic, strong, readonly) UICollectionViewFlowLayout *(^sectionInsetReferenceChain)(UICollectionViewFlowLayoutSectionInsetReference) API_AVAILABLE(ios(11.0), tvos(11.0)) API_UNAVAILABLE(watchos);
@property(nonatomic, strong, readonly) UICollectionViewFlowLayout *(^sectionFootersPinToVisibleBoundsChain)(BOOL);
@property(nonatomic, strong, readonly) UICollectionViewFlowLayout *(^sectionHeadersPinToVisibleBoundsChain)(BOOL);

@property(class, nonatomic, strong) UICollectionViewFlowLayout *layoutDefault;

+ (instancetype)createItemSize:(CGSize)itemSize
                       spacing:(CGFloat)spacing
                    headerSize:(CGSize)headerSize
                    footerSize:(CGSize)footerSize;

@end

NS_ASSUME_NONNULL_END
