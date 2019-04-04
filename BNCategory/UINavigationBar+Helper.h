//
//  UINavigationBar+Helper.h
//  
//
//  Created by BIN on 2018/5/3.
//  Copyright © 2018年 SHANG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationBar (Helper)

+ (void)configureAppeare;

/**
 设置导航栏背景色
 透明色与self.edgesForExtendedLayout = UIRectEdgeAll;搭配使用
 */
- (void)setDefaultBackgroundImage:(UIImage *)image;

@end

