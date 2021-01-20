//
//  UITabBarItem+Helper.m
//  NNCategoryPro
//
//  Created by Bin Shang on 2019/11/11.
//

#import "UITabBarItem+Helper.h"

@implementation UITabBarItem (Helper)

/**
 [源]UITabBarItem创建方法
 */
+ (instancetype)createItem:(NSString *)title image:(NSString *)image selectedImage:(NSString *_Nullable)selectedImage{
    assert([UIImage imageNamed:image] && [UIImage imageNamed:selectedImage]);

    UITabBarItem *tabBarItem = [[self alloc]initWithTitle:title
                                                    image:[UIImage imageNamed:image]
                                            selectedImage:[UIImage imageNamed:selectedImage]];
    return tabBarItem;
}

@end
