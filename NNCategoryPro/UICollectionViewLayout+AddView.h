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

@property(class, nonatomic, strong) UICollectionViewFlowLayout *layoutDefault;

+ (instancetype)createItemSize:(CGSize)itemSize
                       spacing:(CGFloat)spacing
                    headerSize:(CGSize)headerSize
                    footerSize:(CGSize)footerSize;

@end

NS_ASSUME_NONNULL_END
