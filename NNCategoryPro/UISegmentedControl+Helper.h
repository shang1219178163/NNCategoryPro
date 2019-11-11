//
//  UISegmentedControl+Helper.h
//  
//
//  Created by BIN on 2018/6/29.
//  Copyright © 2018年 SHANG. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UISegmentedControl (Helper)

@property (nonatomic, strong) NSArray *itemList;

/**
 [源]UISegmentedControl创建方法
 */
+ (instancetype)createRect:(CGRect)rect items:(NSArray *)items selectedIndex:(NSInteger)selectedIndex type:(NSNumber *)type;

@end

NS_ASSUME_NONNULL_END
