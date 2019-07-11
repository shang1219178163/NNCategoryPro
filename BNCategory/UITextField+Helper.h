//
//  UITextField+Helper.h
//  
//
//  Created by BIN on 2018/6/8.
//  Copyright © 2018年 SHANG. All rights reserved.
//

#import <UIKit/UIKit.h>

/// NSUserDefault 存储Key
FOUNDATION_EXPORT NSString * const kDeafult_textFieldHistory ;

NS_ASSUME_NONNULL_BEGIN

@interface UITextField (Helper)

@property (nonatomic, assign) NSInteger maxLength;//if <=0, no limit

- (BOOL)handlePhoneWithReplacementString:(NSString *)string;

- (BOOL)backToEmptyWithReplacementString:(NSString *)string;

/**
 *  identity of this textfield
 */
@property (nonatomic, retain) NSString *identify;
@property (nonatomic, strong) UITableView *historyTableView;

- (NSArray *)loadHistroy;

- (void)synchronize;

- (void)showHistory;

- (void)hideHistroy;

- (void)clearHistory;

@end

NS_ASSUME_NONNULL_END
