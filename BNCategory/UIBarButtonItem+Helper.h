//
//  UIBarButtonItem+Helper.h
//  AESCrypt-ObjC
//
//  Created by BIN on 2018/11/28.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIBarButtonItem (Helper)

@property (nonatomic, copy) void(^itemBlock)(UIBarButtonItem *item);

- (void)setActionBlock:(void (^)(void))actionBlock;
/// 是否隐藏按钮
- (void)setHidden:(BOOL)hidden;

@end

NS_ASSUME_NONNULL_END
