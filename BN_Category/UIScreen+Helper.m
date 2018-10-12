//
//  UIScreen+Helper.m
//  HuiZhuBang
//
//  Created by BIN on 2018/9/18.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//

#import "UIScreen+Helper.h"

@implementation UIScreen (Helper)

+(CGFloat)statusBarHeight{
    return 20.0;
}

+ (CGFloat)navBarHeight{
    return 44.0;
}

+ (CGFloat)barHeight{
    return (UIScreen.statusBarHeight + UIScreen.navBarHeight);
}

+ (CGFloat)tabBarHeight{
    return 49.0;
}

+ (CGRect)bounds{
    return UIScreen.mainScreen.bounds;
}

+(CGFloat)width{
    return UIScreen.mainScreen.bounds.size.width;
}

+ (CGFloat)height{
    return UIScreen.mainScreen.bounds.size.height;
}

+ (CGFloat)scale{
    return UIScreen.mainScreen.scale;
}

@end
