//
//  UIBarButtonItem+Helper.h
//  
//
//  Created by BIN on 2018/11/28.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIBarButtonItem (Helper)

///导航栏 UIBarButtonItem
+ (instancetype)createItem:(NSString *)obj style:(UIBarButtonItemStyle)style target:(id _Nullable)target action:(SEL _Nullable)action;

+ (instancetype)customViewWithButton:(NSString *)obj handler:(void(^)(UIButton *sender))handler;

/// 闭包回调
- (void)addActionBlock:(void (^)(UIBarButtonItem *item))block;

@end

NS_ASSUME_NONNULL_END
