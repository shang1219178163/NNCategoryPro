//
//  UISearchBar+Helper.m
//  ProductTemplet
//
//  Created by Bin Shang on 2019/10/8.
//  Copyright © 2019 BN. All rights reserved.
//

#import "UISearchBar+Helper.h"
#import <objc/runtime.h>
#import "UIView+Helper.h"

@implementation UISearchBar (Helper)

- (UITextField *)textField{
    if (@available(iOS 13.0, *)) {
        return self.searchTextField;
    }
    
    UITextField *obj = objc_getAssociatedObject(self, _cmd);
    if (!obj) {
        obj = (UITextField *)[self findSubview:@"UITextField" resursion:YES];
        objc_setAssociatedObject(self, _cmd, obj, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return obj;
}

- (UIButton *)cancellBtn{
    UIButton *obj = objc_getAssociatedObject(self, _cmd);
    if (!obj) {
        obj = (UIButton *)[self findSubview:@"UINavigationButton" resursion:YES];
        objc_setAssociatedObject(self, _cmd, obj, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return obj;
}

/**
 [源]UISearchBar创建方法
 */
+ (instancetype)createRect:(CGRect)rect{
    UISearchBar *searchBar = [[self alloc] initWithFrame:rect];
    searchBar.layer.cornerRadius = CGRectGetHeight(rect)*0.5;
    searchBar.layer.masksToBounds = true;
    //设置背景图是为了去掉上下黑线
    searchBar.backgroundImage = [[UIImage alloc] init];
    //searchBar.backgroundImage = [UIImage imageNamed:@"sexBankgroundImage"];
    // 设置SearchBar的主题颜色
    //searchBar.barTintColor = [UIColor colorWithRed:111 green:212 blue:163 alpha:1];
    //设置背景色
    searchBar.backgroundColor = [UIColor colorWithRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:0.1];
    
    searchBar.barStyle = UIBarStyleDefault;
    searchBar.keyboardType = UIKeyboardTypeNamePhonePad;
    //searchBar.searchBarStyle = UISearchBarStyleMinimal;
    //没有背影，透明样式
    // 修改cancel

    if (@available(iOS 13.0, *)) {

    } else {
        [searchBar setValue:@"取消" forKey:@"cancelButtonText"];
    }
    searchBar.showsCancelButton = true;
//    searchBar.showsSearchResultsButton = true;
    //5. 设置搜索Icon
//    [searchBar setImage:[UIImage imageNamed:@"Search_Icon"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
    
    [searchBar setPositionAdjustment:UIOffsetMake(-8, 1) forSearchBarIcon:UISearchBarIconSearch];
    // 删除按钮往右移一点
    [searchBar setPositionAdjustment:UIOffsetMake(8, 0) forSearchBarIcon:UISearchBarIconClear];
    
    /// textField设置默认配置
    UITextField *textField = (UITextField *)[searchBar findSubview:@"UITextField" resursion:YES];
    [textField setBackgroundColor: UIColor.clearColor];
    // 根据@"_placeholderLabel.textColor" 找到placeholder的字体颜色
    // 输入文本颜色
    textField.textColor = UIColor.whiteColor;
    textField.font = [UIFont systemFontOfSize:13];
    
    return searchBar;
}

@end
