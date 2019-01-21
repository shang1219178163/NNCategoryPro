//
//  UIControl+Helper.h
//  ProductTemplet
//
//  Created by dev on 2018/12/10.
//  Copyright © 2018年 BN. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIControl (Helper)

- (void)addActionHandler:(void(^)(UIControl *control))handler forControlEvents:(UIControlEvents)controlEvents;

@end

NS_ASSUME_NONNULL_END
