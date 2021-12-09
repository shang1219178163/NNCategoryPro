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

- (void)setColor:(UIColor *)tintColor barTintColor:(UIColor *)barTintColor shadowColor:(nullable UIColor *)shadowColor;

@end


@interface UINavigationBarAppearance (Ext)

+ (instancetype)create:(UIColor *)tintColor
          barTintColor:(UIColor *)barTintColor
           shadowColor:(nullable UIColor *)shadowColor
                  font:(nullable UIFont *)font;
@end

NS_ASSUME_NONNULL_END
