//
//  UITextField+Helper.m
//  
//
//  Created by BIN on 2018/6/8.
//  Copyright © 2018年 SHANG. All rights reserved.
//

#import "UITextField+Helper.h"
#import "UIView+Helper.h"
#import "UIGestureRecognizer+Helper.h"

@interface UITextField()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation UITextField (Helper)

/**
 [源]UITextField创建
 */
+ (instancetype)createRect:(CGRect)rect{
    UITextField * textField = [[self alloc]initWithFrame:rect];
    textField.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    textField.placeholder = @"请输入";
    textField.textAlignment = NSTextAlignmentLeft;
    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
    textField.keyboardAppearance = UIKeyboardAppearanceDefault;
    textField.keyboardType = UIReturnKeyDone;
    
//    textField.returnKeyType = UIReturnKeyDone;
//    textField.clearButtonMode = UITextFieldViewModeAlways;
    
    textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    textField.autocorrectionType = UITextAutocorrectionTypeNo;
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;//清楚键
    textField.borderStyle = UITextBorderStyleRoundedRect;

    textField.backgroundColor = UIColor.whiteColor;
//    textField.backgroundColor = UIColor.clearColor;
    
    return textField;
}

/**
 [源]UITextField密码输入框创建(NNTextFieldOne 调用)
 */
+ (instancetype)createPwdRect:(CGRect)rect image:(UIImage *)image imageSelected:(UIImage *)imageSelected {
    UITextField *textField = [[self alloc]initWithFrame:rect];
    textField.placeholder = @"  请输入密码";
    textField.backgroundColor = UIColor.greenColor;
    textField.clearsOnBeginEditing = true;
    textField.clearButtonMode = UITextFieldViewModeAlways;
    textField.secureTextEntry = true;
    
    textField.leftViewMode = UITextFieldViewModeAlways;
    textField.leftView = ({
        CGRect imgViewRect = CGRectEqualToRect(CGRectZero, rect) ? CGRectMake(0, 0, 30, 30) : CGRectMake(0, 0, CGRectGetHeight(rect) - 5, CGRectGetHeight(rect) - 5);
        UIImageView *imgView = [[UIImageView alloc]initWithFrame: imgViewRect];
        imgView.userInteractionEnabled = true;
        imgView.contentMode = UIViewContentModeCenter;
        //        imgView.backgroundColor = UIColor.redColor;
        imgView.image = image;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
        tap.numberOfTapsRequired = 1;
        tap.numberOfTouchesRequired = 1;
        //    tapGesture.cancelsTouchesInView = NO;
        //    tapGesture.delaysTouchesEnded = NO;
        [tap addActionBlock:^(UIGestureRecognizer * _Nonnull reco) {
            //            DDLog(@"%@", reco)
            UIImageView * sender = (UIImageView *)reco.view;
            sender.selected = !sender.selected;
            sender.image = sender.selected == false ? image : imageSelected;
            
            NSString *tempPwdStr = textField.text;
            textField.text = @""; // 这句代码可以防止切换的时候光标偏移
            textField.secureTextEntry = !sender.selected;
            textField.text = tempPwdStr;
        }];
        
        [imgView addGestureRecognizer:tap];
        
        imgView;
    });
    return textField;
}

@end
