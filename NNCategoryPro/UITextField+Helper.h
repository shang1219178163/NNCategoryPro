//
//  UITextField+Helper.h
//  
//
//  Created by BIN on 2018/6/8.
//  Copyright © 2018年 SHANG. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextField (Helper)

/**
 UITextField创建方法
 */
+ (instancetype)createRect:(CGRect)rect;

- (void)addPasswordEveBlock:(UIImage *)image imageSelected:(UIImage *)imageSelected edge:(UIEdgeInsets)edge block:(void(^)(UIButton *))block;

- (id)asoryImageView:(UIImage *)image;

- (id)asoryView:(NSString *)unitString;

@end

NS_ASSUME_NONNULL_END
