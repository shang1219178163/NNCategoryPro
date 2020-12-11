//
//  UICollectionViewLayout+AddView.m
//  
//
//  Created by BIN on 2018/8/24.
//  Copyright © 2018年 SHANG. All rights reserved.
//

#import "UICollectionViewLayout+AddView.h"

#import <objc/runtime.h>
#import <NNGloble/NNGloble.h>

@implementation UICollectionViewLayout (AddView)


@end


@implementation UICollectionViewFlowLayout (AddView)

#pragma mark - -funtions

/**
 默认布局配置(自上而下,自左而右)
 */
+ (instancetype)createItemSize:(CGSize)itemSize
                       spacing:(CGFloat)spacing
                    headerSize:(CGSize)headerSize
                    footerSize:(CGSize)footerSize{
//    CGFloat spacing = 5.0;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //item水平间距
    layout.minimumLineSpacing = spacing;
    //item垂直间距
    layout.minimumInteritemSpacing = spacing;
    //item的尺寸
    layout.itemSize = itemSize;
    //item的UIEdgeInsets
    layout.sectionInset = UIEdgeInsetsMake(spacing, spacing, spacing, spacing);
    //滑动方向,默认垂直
    //sectionView 尺寸
    layout.headerReferenceSize = headerSize;
    layout.footerReferenceSize = footerSize;
    return layout;
}


static UICollectionViewFlowLayout *_layoutDefault;

+ (void)setLayoutDefault:(UICollectionViewFlowLayout *)layoutDefault{
    _layoutDefault = layoutDefault;
}

+ (UICollectionViewFlowLayout *)layoutDefault{
    if (!_layoutDefault) {
        _layoutDefault = ({
            UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
            //item水平间距
            layout.minimumLineSpacing = 10;
            //item垂直间距
            layout.minimumInteritemSpacing = 10;
            //item的尺寸
            layout.itemSize = CGSizeMake(90, 100);
            //item的UIEdgeInsets
            layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
            //滑动方向,默认垂直
            layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
            //sectionView 尺寸
            layout.headerReferenceSize = CGSizeMake(kScreenWidth, 40);
            layout.footerReferenceSize = CGSizeMake(kScreenWidth, 20);

            layout;
        });
    }
    return _layoutDefault;
}

@end

