//
//  UISearchBar+Helper.h
//  ProductTemplet
//
//  Created by Bin Shang on 2019/10/8.
//  Copyright © 2019 BN. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UISearchBar (Helper)
/// 输入框textField
@property (nonatomic, strong, readonly) UITextField *textField;
/// 输入框取消按钮,仅在按钮可见时存在
@property (nonatomic, strong, readonly, nullable) UIButton *cancellBtn;

//@property (nonatomic, strong) NSString *placeholderStr;

@end

NS_ASSUME_NONNULL_END
