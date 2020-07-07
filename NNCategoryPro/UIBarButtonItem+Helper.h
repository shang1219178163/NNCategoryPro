//
//  UIBarButtonItem+Helper.h
//  
//
//  Created by BIN on 2018/11/28.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIBarButtonItem (Helper)

/**
 导航栏 UIBarButtonItem
 */
+ (instancetype)createItem:(NSString *)obj style:(UIBarButtonItemStyle)style;

/**
 [源] 导航栏 UIBarButtonItem
 */
+ (instancetype)createItem:(NSString *)obj style:(UIBarButtonItemStyle)style target:(id _Nullable)target action:(SEL _Nullable)action;

/// 闭包回调
- (void)addActionBlock:(void (^)(UIBarButtonItem *item))block;
/// 是否隐藏按钮
- (void)setHidden:(BOOL)hidden;

@end

NS_ASSUME_NONNULL_END
