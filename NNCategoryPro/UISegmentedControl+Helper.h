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

@property (nonatomic, strong) NSArray<NSString *> *items;

/**
 [源]UISegmentedControl创建方法
 */
+ (instancetype)createRect:(CGRect)rect
                     items:(NSArray *)items
             selectedIndex:(NSInteger)selectedIndex
                      type:(NSNumber *)type;

- (void)ensureiOS12Style;

- (void)updateItems:(NSArray<NSString *> *)titles;

@end

NS_ASSUME_NONNULL_END
