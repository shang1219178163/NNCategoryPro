//
//  UITextField+History.h
//  NNCategoryPro
//
//  Created by Bin Shang on 2019/11/11.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

FOUNDATION_EXPORT NSString * const kTextFieldHistory;

@interface UITextField (History)

@property (nonatomic, assign) NSInteger maxLength;//if <=0, no limit

- (BOOL)handlePhoneWithReplacementString:(NSString *)string;

- (BOOL)backToEmptyWithReplacementString:(NSString *)string;

@property (nonatomic, strong) NSString *identify;
@property (nonatomic, strong) UITableView *historyTableView;

- (NSArray *)loadHistroy;

- (void)synchronize;

- (void)showHistory;

- (void)hideHistroy;

- (void)clearHistory;

@end

NS_ASSUME_NONNULL_END

