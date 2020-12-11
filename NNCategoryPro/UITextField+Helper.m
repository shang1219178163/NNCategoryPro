//
//  UITextField+Helper.m
//  
//
//  Created by BIN on 2018/6/8.
//  Copyright © 2018年 SHANG. All rights reserved.
//

#import "UITextField+Helper.h"
#import <NNGloble/NNGloble.h>
#import "UIView+Helper.h"
#import "UIGestureRecognizer+Helper.h"
#import "NSObject+Helper.h"

@interface UITextField()

@end

@implementation UITextField (Helper)

/**
 [源]UITextField创建
 */
+ (instancetype)createRect:(CGRect)rect{
    UITextField *textField = [[self alloc]initWithFrame:rect];
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

- (id)asoryView:(NSString *)unitString{
    //    NSArray * unitList = @[@"元",@"公斤"];
    NSParameterAssert([self isKindOfClass:[UITextField class]]);
    NSParameterAssert(unitString != nil && ![unitString isEqualToString:@""]);
    if ([UIImage imageNamed:unitString]) {
        CGSize size = CGSizeMake(20, 20);
        UIImageView *imgView = [[UIImageView alloc]init];
        imgView.frame = CGRectMake(0, 0, size.width, size.height);
        imgView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        imgView.contentMode = UIViewContentModeScaleAspectFit;
        imgView.userInteractionEnabled = YES;
        imgView.image = [UIImage imageNamed:unitString];
        return imgView;
    }
    
    CGSize size = [self sizeWithText:unitString font:@(14) width:kScreenWidth];
    UILabel *label = [[UILabel alloc]init];
    label.frame = CGRectMake(0, 0, size.width+2, 25);
    label.numberOfLines = 1;
    label.lineBreakMode = NSLineBreakByTruncatingTail;
    label.adjustsFontSizeToFitWidth = YES;
    label.text = unitString;
    label.textColor = UIColor.titleColor;
    label.textAlignment = NSTextAlignmentCenter;
    return label;
}

@end
