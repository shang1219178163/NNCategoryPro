//
//  UITextField+Helper.h
//  HuiZhuBang
//
//  Created by BIN on 2018/6/8.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (Helper)

- (BOOL)handlePhoneWithReplacementString:(NSString *)string;

- (BOOL)backToEmptyWithReplacementString:(NSString *)string;

@end
