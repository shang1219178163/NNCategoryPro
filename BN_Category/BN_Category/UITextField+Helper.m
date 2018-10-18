

//
//  UITextField+Helper.m
//  HuiZhuBang
//
//  Created by BIN on 2018/6/8.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//

#import "UITextField+Helper.h"

@implementation UITextField (Helper)

- (BOOL)handlePhoneWithReplacementString:(NSString *)string{
    //只有手机号需要空格,密码不需要
    if ([string isEqualToString:@""]) { // 删除字符
        return YES;
    }
    else {
        if (self.text.length == 3 || self.text.length == 8) {//输入
            NSString * temStr = self.text;
            temStr = [temStr stringByAppendingString:@" "];
            self.text = temStr;
            
        }
        else if (self.text.length >= 13){
            return NO;
        }
    }
    return YES;
}

- (BOOL)backToEmptyWithReplacementString:(NSString *)string{
    if ([string isEqualToString:@""]) { // 删除字符
        self.text = @"";
        return YES;
    }
    return YES;
}


@end
