//
//  CATextLayer+Helper.h
//  BN_AlertView
//
//  Created by BIN on 2018/9/10.
//  Copyright © 2018年 SouFun. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

@interface CATextLayer (Helper)


+(CATextLayer *)createRect:(CGRect)rect string:(NSString *)string font:(UIFont *)font textColor:(UIColor *)textColor alignmentMode:(NSString *)alignmentMode;

@end
