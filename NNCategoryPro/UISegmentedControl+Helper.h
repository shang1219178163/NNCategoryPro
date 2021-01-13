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

- (void)addActionHandler:(void(^)(UISegmentedControl *sender))handler forControlEvents:(UIControlEvents)controlEvents;

/**
 [源]UISegmentedControl创建方法
 */
+ (instancetype)createRect:(CGRect)rect
                     items:(NSArray *)items
                      type:(NSNumber *)type;

- (void)ensureiOS13Style:(CGFloat)fontSize API_AVAILABLE(ios(13.0));

- (void)updateItems:(NSArray<NSString *> *)titles;

@end

NS_ASSUME_NONNULL_END
