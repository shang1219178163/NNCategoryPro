//
//  UICollectionViewLayout+AddView.m
//  
//
//  Created by BIN on 2018/8/24.
//  Copyright © 2018年 SHANG. All rights reserved.
//

#import "UICollectionViewLayout+AddView.h"

#import <objc/runtime.h>
#import "BN_Globle.h"

@implementation UICollectionViewLayout (AddView)

-(CGFloat)minimumLineSpacing{
    return [objc_getAssociatedObject(self, _cmd) floatValue];
}

- (void)setMinimumLineSpacing:(CGFloat)minimumLineSpacing{
    objc_setAssociatedObject(self, @selector(minimumLineSpacing), @(minimumLineSpacing), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(CGFloat)minimumInteritemSpacing{
    return [objc_getAssociatedObject(self, _cmd) floatValue];
}

- (void)setMinimumInteritemSpacing:(CGFloat)minimumInteritemSpacing{
    objc_setAssociatedObject(self, @selector(minimumInteritemSpacing), @(minimumInteritemSpacing), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGSize)itemSize{
    return [objc_getAssociatedObject(self, _cmd) CGSizeValue];
}

- (void)setItemSize:(CGSize)itemSize{
    objc_setAssociatedObject(self, @selector(itemSize), @(itemSize), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGSize)headerReferenceSize{
    return [objc_getAssociatedObject(self, _cmd) CGSizeValue];
}

- (void)setHeaderReferenceSize:(CGSize)headerReferenceSize{
    objc_setAssociatedObject(self, @selector(headerReferenceSize), @(headerReferenceSize), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGSize)footerReferenceSize{
    return [objc_getAssociatedObject(self, _cmd) CGSizeValue];
}

- (void)setFooterReferenceSize:(CGSize)footerReferenceSize{
    objc_setAssociatedObject(self, @selector(footerReferenceSize), @(footerReferenceSize), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIEdgeInsets)sectionInset{
    return [objc_getAssociatedObject(self, _cmd) UIEdgeInsetsValue];
}

-(void)setSectionInset:(UIEdgeInsets)sectionInset{
    NSValue * value = [NSValue valueWithUIEdgeInsets:sectionInset];
    objc_setAssociatedObject(self, @selector(sectionInset), value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - -funtions

/**
 默认布局配置(自上而下,自左而右)
 */
+ (UICollectionViewFlowLayout *)createItemSize:(CGSize)itemSize spacing:(CGFloat)spacing headerSize:(CGSize)headerSize footerSize:(CGSize)footerSize{
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


@end

