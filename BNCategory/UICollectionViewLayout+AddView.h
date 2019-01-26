//
//  UICollectionViewLayout+AddView.h
//  
//
//  Created by BIN on 2018/8/24.
//  Copyright © 2018年 SHANG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UICollectionViewLayout (AddView)

@property (nonatomic, assign) CGFloat minimumLineSpacing;
@property (nonatomic, assign) CGFloat minimumInteritemSpacing;
@property (nonatomic, assign) CGSize itemSize;
@property (nonatomic, assign) CGSize headerReferenceSize;
@property (nonatomic, assign) CGSize footerReferenceSize;
@property (nonatomic, assign) UIEdgeInsets sectionInset;

+ (UICollectionViewFlowLayout *)createItemSize:(CGSize)itemSize spacing:(CGFloat)spacing headerSize:(CGSize)headerSize footerSize:(CGSize)footerSize;

@end

