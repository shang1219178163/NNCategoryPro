//
//  UITabBarItem+Helper.h
//  NNCategoryPro
//
//  Created by Bin Shang on 2019/11/11.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITabBarItem (Helper)

+ (instancetype)createItem:(NSString *_Nullable)title image:(NSString *_Nullable)image selectedImage:(NSString *_Nullable)selectedImage;

@end

NS_ASSUME_NONNULL_END
