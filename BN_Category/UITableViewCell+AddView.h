//
//  UITableViewCell+AddView.h
//  BN_SeparatorView
//
//  Created by BIN on 2018/8/23.
//  Copyright © 2018年 BIN. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BN_Kit.h"

@class BN_TextField;

@interface UITableViewCell (AddView)

+(instancetype)cellWithTableView:(UITableView *)tableView identifier:(NSString *)identifier;

+(instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong, class, readonly) NSString * identifier;

@property (nonatomic, assign) CGSize  imgViewLeftSize;

@property (nonatomic, strong) UILabel * labelRight;

@property (nonatomic, strong) UILabel * labelLeft;
@property (nonatomic, strong) UILabel * labelLeftMark;
@property (nonatomic, strong) UILabel * labelLeftSub;
@property (nonatomic, strong) UILabel * labelLeftSubMark;

@property (nonatomic, strong) UIImageView * imgViewLeft;
@property (nonatomic, strong) UIImageView * imgViewRight;

@property (nonatomic, strong) UIButton * btn;
@property (nonatomic, strong) UIButton * radioView;

//@property (nonatomic, strong) UITextField * textField;
@property (nonatomic, strong) UITextView * textView;

@property (nonatomic, strong) BN_TextField * textField;

@end
