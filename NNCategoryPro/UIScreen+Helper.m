//
//  UIScreen+Helper.m
//  
//
//  Created by BIN on 2018/9/18.
//  Copyright © 2018年 SHANG. All rights reserved.
//

#import "UIScreen+Helper.h"

@implementation UIScreen (Helper)

+ (bool)isIPhoneX{
    return UIScreen.mainScreen.bounds.size.height >= 812;
}

+(CGFloat)statusBarHeight{
    return self.isIPhoneX ? 44 : 20;
}

+ (CGFloat)navBarHeight{
    return self.isIPhoneX ? 88 : 64;
}

+ (CGFloat)barHeight{
    return (UIScreen.statusBarHeight + UIScreen.navBarHeight);
}

+ (CGFloat)tabBarHeight{
    return self.isIPhoneX ? (49.0 + 34.0) : 49;
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

+ (CGSize)DPISize{
    CGSize size = UIScreen.mainScreen.bounds.size;
    CGFloat scale = UIScreen.mainScreen.scale;
    return CGSizeMake(size.width * scale, size.height * scale);
}

@end
