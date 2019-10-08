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

- (NSString *)placeholderStr{
    NSString *obj = objc_getAssociatedObject(self, _cmd);
    if (!obj) {
        objc_setAssociatedObject(self, _cmd, obj, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return obj;
}

- (void)setPlaceholderStr:(NSString *)placeholderStr{
    objc_setAssociatedObject(self, @selector(placeholderStr), placeholderStr, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (placeholderStr.length <= 0) {
        return;
    }
    // iOS13不能KVC设置颜色了，所以不能直接设置 self.searchBar.placeholder = _placeholderStr; 。需要通过下面方式来设置颜色
    NSDictionary *attDic = @{
                             NSForegroundColorAttributeName: [UIColor.whiteColor colorWithAlphaComponent:0.5],
                             NSFontAttributeName: [UIFont boldSystemFontOfSize:13],
                             };
    
    UITextField *textField = (UITextField *)[self findSubview:@"UITextField" resursion:YES];
    textField.attributedPlaceholder = [[NSAttributedString alloc]initWithString:placeholderStr
                                                                     attributes:attDic];
}


@end
