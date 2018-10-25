

//
//  UITextField+Helper.m
//  HuiZhuBang
//
//  Created by BIN on 2018/6/8.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//

#import "UITextField+Helper.h"
#import "BN_Globle.h"

#import "NSObject+Helper.h"
#import "UIView+Helper.h"
#import "UIScreen+Helper.h"
#import "UIColor+Helper.h"

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

- (id)asoryView:(NSString *)unitString{
    //    NSArray * unitList = @[@"元",@"公斤"];
    NSParameterAssert(unitString != nil && ![unitString isEqualToString:@""]);
    
    if ([unitString containsString:@".png"]) {
        CGSize size = CGSizeMake(20, 20);
        UIImageView * imgView = [UIView createImgViewWithRect:CGRectMake(0, 0, size.width, size.height) image:unitString tag:kTAG_IMGVIEW patternType:@"0"];
        return imgView;
    }
    
    CGSize size = [self sizeWithText:unitString font:@(KFZ_Third) width:UIScreen.width];
    UILabel * label = [UIView createLabelWithRect:CGRectMake(0, 0, size.width+2, 25) text:unitString textColor:kC_TextColor_Title tag:kTAG_LABEL patternType:@"2" font:KFZ_Third backgroudColor:UIColor.clearColor alignment:NSTextAlignmentCenter];
    return label;
    
}


@end
