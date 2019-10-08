//
//  UISearchBar+Helper.m
//  ProductTemplet
//
//  Created by Bin Shang on 2019/10/8.
//  Copyright © 2019 BN. All rights reserved.
//

#import "UISearchBar+Helper.h"

@implementation UISearchBar (Helper)

/**
 配置UISearchBar 字体颜色
 */
- (void)setupTextField{
    UITextField *searchField = [self valueForKey:@"_searchField"];
    if (!searchField) {
        return;
    }
    
    [searchField setBackgroundColor: UIColor.clearColor];
    // 根据@"_placeholderLabel.textColor" 找到placeholder的字体颜色
    [searchField setValue:[UIFont boldSystemFontOfSize:13] forKeyPath:@"_placeholderLabel.font"];
    [searchField setValue:[UIColor.whiteColor colorWithAlphaComponent:0.5] forKeyPath:@"_placeholderLabel.textColor"];
    // 输入文本颜色
    searchField.textColor = UIColor.whiteColor;
    searchField.font = [UIFont systemFontOfSize:13];
}

@end
