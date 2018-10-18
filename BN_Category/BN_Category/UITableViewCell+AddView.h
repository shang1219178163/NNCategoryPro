//
//  UITableViewCell+AddView.h
//  BN_SeparatorView
//
//  Created by BIN on 2018/8/23.
//  Copyright © 2018年 BIN. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BN_Kit.h"

@class BN_TextField,BN_TextView,BN_RadioView;

@interface UITableViewCell (AddView)

+(instancetype)cellWithTableView:(UITableView *)tableView identifier:(NSString *)identifier;

+(instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, assign) CGSize  imgViewLeftSize;

@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;

@property (nonatomic, strong) UILabel * labelRight;

@property (nonatomic, strong) UILabel * labelLeft;
@property (nonatomic, strong) UILabel * labelLeftMark;
@property (nonatomic, strong) UILabel * labelLeftSub;
@property (nonatomic, strong) UILabel * labelLeftSubMark;

@property (nonatomic, strong) UIImageView * imgViewLeft;
@property (nonatomic, strong) UIImageView * imgViewRight;

@property (nonatomic, strong) UIButton * btn;
//@property (nonatomic, strong) UITextField * textField;
//@property (nonatomic, strong) UITextView * textView;

@property (nonatomic, strong) BN_TextField * textField;
@property (nonatomic, strong) BN_TextView * textView;
@property (nonatomic, strong) BN_RadioView * radioView;


- (id)getTextFieldRightView:(NSString *)unitString;

@end
