//
//  UITextField+Helper.h
//  
//
//  Created by BIN on 2018/6/8.
//  Copyright © 2018年 SHANG. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextField (Helper)

/**
 UITextField创建方法
 */
+ (instancetype)createRect:(CGRect)rect;

/**
 UITextField密码输入框创建
 */
+ (instancetype)createPwdRect:(CGRect)rect image:(UIImage *)image imageSelected:(UIImage *)imageSelected;

@end

NS_ASSUME_NONNULL_END
