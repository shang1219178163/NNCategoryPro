//
//  UITableViewCell+Helper.h
//  
//
//  Created by BIN on 2018/1/9.
//  Copyright © 2018年 SHANG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <NNGloble/NNGloble.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableViewCell (Helper)

+(instancetype)cellWithTableView:(UITableView *)tableView identifier:(NSString *)identifier style:(UITableViewCellStyle)style;

+(instancetype)cellWithTableView:(UITableView *)tableView identifier:(NSString *)identifier;

+(instancetype)cellWithTableView:(UITableView *)tableView;

@end


@class NNTextField;
@interface UITableViewCell (AddView)

@property (nonatomic, assign) CGSize imgViewLeftSize;

@property (nonatomic, strong) UILabel *labelRight;

@property (nonatomic, strong) UILabel *labelLeft;
@property (nonatomic, strong) UILabel *labelLeftMark;
@property (nonatomic, strong) UILabel *labelLeftSub;
@property (nonatomic, strong) UILabel *labelLeftSubMark;

@property (nonatomic, strong) UIImageView *imgViewLeft;
@property (nonatomic, strong) UIImageView *imgViewRight;

@property (nonatomic, strong) UIButton *btn;
@property (nonatomic, strong) UIButton *radioView;

//@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UITextView *textView;

@property (nonatomic, strong) NNTextField *textField;

@end

NS_ASSUME_NONNULL_END
