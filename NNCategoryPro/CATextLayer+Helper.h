//
//  CATextLayer+Helper.h
//  BNAlertView
//
//  Created by BIN on 2018/9/10.
//  Copyright © 2018年 SouFun. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CATextLayer (Helper)


+(CATextLayer *)createRect:(CGRect)rect
                    string:(NSString *)string
                      font:(UIFont *)font
                 textColor:(UIColor *)textColor
             alignmentMode:(NSString *)alignmentMode;

@end

NS_ASSUME_NONNULL_END
