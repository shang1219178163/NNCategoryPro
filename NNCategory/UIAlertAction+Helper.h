//
//  UIAlertAction+Helper.h
//  
//
//  Created by BIN on 2018/9/18.
//  Copyright © 2018年 SHANG. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIAlertAction (Helper)

@property (nonatomic, assign) NSInteger tag;//其他类使用该属性注意性能

- (void)setTitleColor:(UIColor *)color;

@end

NS_ASSUME_NONNULL_END
