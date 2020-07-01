//
//  UISwitch+Helper.m
//  NNCategoryPro
//
//  Created by Bin Shang on 2019/11/11.
//

#import "UISwitch+Helper.h"
#import "UIColor+Helper.h"

@implementation UISwitch (Helper)
/**
 [源]UISwitch创建方法
 */
+ (instancetype)createRect:(CGRect)rect isOn:(BOOL)isOn{
    UISwitch *view = [[self alloc]initWithFrame:rect];
    view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    view.on = isOn;//设置初始为ON的一边
    view.onTintColor = UIColor.themeColor;
//    view.tintColor = UIColor.whiteColor;
    
    return view;
}

@end
