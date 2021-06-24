//
//  UITextField+Helper.m
//  
//
//  Created by BIN on 2018/6/8.
//  Copyright © 2018年 SHANG. All rights reserved.
//

#import "UITextField+Helper.h"
#import <NNGloble/NNGloble.h>
#import "UIButton+Helper.h"

#import "UIView+Helper.h"
#import "UIGestureRecognizer+Helper.h"
#import "NSObject+Helper.h"

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
    textField.keyboardType = UIKeyboardTypeDefault;
    
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

- (void)addPasswordEveBlock:(UIImage *)image imageSelected:(UIImage *)imageSelected edge:(UIEdgeInsets)edge block:(void(^)(UIButton *))block{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 40, 30)];
    
    UIButton *sender = [UIButton buttonWithType:UIButtonTypeSystem];
    [sender setImage:image forState:UIControlStateNormal];
    [sender setImage:imageSelected forState:UIControlStateSelected];

    [sender addActionHandler:^(UIButton * _Nonnull sender) {
        sender.selected = !sender.isSelected;
        self.secureTextEntry = !sender.selected;
        block(sender);
    } forControlEvents:UIControlEventTouchUpInside];
    
    sender.frame = CGRectMake(edge.left, edge.top, view.bounds.size.width - edge.left - edge.right, view.bounds.size.height - edge.top - edge.bottom);
    [view addSubview:sender];
    self.rightView = view;
    self.rightViewMode = UITextFieldViewModeAlways;
    
    self.clearButtonMode = UITextFieldViewModeNever;
    self.secureTextEntry = true;
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
    label.textColor = UIColor.titleColor3;
    label.textAlignment = NSTextAlignmentCenter;
    return label;
}

@end
