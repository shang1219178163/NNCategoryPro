//
//  UIScreen+Helper.h
//  HuiZhuBang
//
//  Created by BIN on 2018/9/18.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScreen (Helper)

@property (class, nonatomic, assign, readonly) CGFloat statusBarHeight;
@property (class, nonatomic, assign, readonly) CGFloat navBarHeight;
@property (class, nonatomic, assign, readonly) CGFloat barHeight;

@property (class, nonatomic, assign, readonly) CGFloat tabBarHeight;
@property (class, nonatomic, assign, readonly) CGRect  bounds;
@property (class, nonatomic, assign, readonly) CGFloat width;
@property (class, nonatomic, assign, readonly) CGFloat height;
@property (class, nonatomic, assign, readonly) CGFloat scale;

@end

