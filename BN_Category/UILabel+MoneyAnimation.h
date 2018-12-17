//
//  UILabel+MoneyAnimation.h
//  MoneyAnimation
//
//  Created by Dwyane on 2018/7/23.
//  Copyright © 2018年 DW. All rights reserved.
//

#import <UIKit/UIKit.h>

//每次数字跳动相差的间隔数
UIKIT_EXTERN NSString * const kNumberRangeKey ;
//起始数字
UIKIT_EXTERN NSString * const kNumberBeginKey ;
//结束跳动时的数字
UIKIT_EXTERN NSString * const kNumberEndKey ;
//数字跳动频率
UIKIT_EXTERN double kFrequency ;

@interface UILabel (MoneyAnimation)

@property (nonatomic, strong) NSNumber *number;


@end
