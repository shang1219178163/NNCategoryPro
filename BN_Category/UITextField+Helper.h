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

/**
 *  identity of this textfield
 */
@property (retain, nonatomic) NSString *identify;

@property (strong, nonatomic) UITableView *historyTableView;

- (NSArray *)loadHistroy;

- (void)synchronize;

- (void)showHistory;
- (void)hideHistroy;

- (void)clearHistory;

@end
