//
//  UINavigationBar+Helper.h
//  
//
//  Created by BIN on 2018/5/3.
//  Copyright © 2018年 SHANG. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UINavigationBar (Helper)

/// UINavigationBar默认外观配置
+ (void)configureAppeare;

- (void)setBackgroundColor:(UIColor *)color;

@end

NS_ASSUME_NONNULL_END
