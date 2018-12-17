//
//  UILabel+MoneyAnimation.m
//  MoneyAnimation
//
//  Created by Dwyane on 2018/7/23.
//  Copyright © 2018年 DW. All rights reserved.
//

#import "UILabel+MoneyAnimation.h"
#import <objc/runtime.h>

//每次数字跳动相差的间隔数
NSString * const kNumberRangeKey = @"RangeKey";
//起始数字
NSString * const kNumberBeginKey = @"BeginNumberKey";
//结束跳动时的数字
NSString * const kNumberEndKey = @"EndNumberKey";
//数字跳动频率
double kFrequency = 1.0/30.0f;

@interface UILabel()
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) NSString *valueString;
@end

@implementation UILabel (MoneyAnimation)

double RangeNumber(double endNumber, double duration){
    return (endNumber * kFrequency)/duration;
}

- (void)setTimer:(NSTimer *)timer {
    objc_setAssociatedObject(self, @selector(timer), timer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSTimer *)timer {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setValueString:(NSString *)valueString {
    objc_setAssociatedObject(self, @selector(valueString), valueString, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)valueString {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setNumber:(NSNumber *)number {
    objc_setAssociatedObject(self, @selector(number), number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    [self setMoneyNumber:number duration:1.5];
}

- (NSNumber *)number {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setMoneyNumber:(NSNumber *)number duration:(NSTimeInterval)duration {
    [self.timer invalidate];
    self.timer = nil;
    
    //变量初始化
//    self.animatedNumber = @(0);

    NSDictionary *dic = @{
                          kNumberBeginKey:@(1),
                          kNumberEndKey:number,
                          kNumberRangeKey:@(RangeNumber(number.doubleValue, duration)),
                              
                          };
    // 添加定时器，添加到NSRunLoop中
    self.timer = [NSTimer scheduledTimerWithTimeInterval:kFrequency target:self selector:@selector(changeAnimation:) userInfo:dic repeats:YES];
    [NSRunLoop.currentRunLoop addTimer:self.timer forMode:NSRunLoopCommonModes];

}

- (void)changeAnimation:(NSTimer *)timer{

    NSDictionary *info = timer.userInfo;
    double begin = [info[kNumberBeginKey] doubleValue];
    double end = [info[kNumberEndKey] doubleValue];
    double range = [info[kNumberRangeKey] doubleValue];
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = NSNumberFormatterNoStyle;
    formatter.formatWidth = 9;
    formatter.positiveFormat = @",##0.00";

    double value = self.valueString.doubleValue;
    
    if (value == 0) {
        self.valueString = [NSString stringWithFormat:@"%f", begin];
        self.text = [NSString stringWithFormat:@"%.@",[formatter stringFromNumber:@(begin)]];

    } else if (value >= end) {
        self.text = [NSString stringWithFormat:@"%.@",[formatter stringFromNumber:@(end)]];
        self.valueString = [NSString stringWithFormat:@"%f", begin];
        [self.timer invalidate];
        self.timer = nil;
        return;
    } else {
        value += range;
        self.valueString = [NSString stringWithFormat:@"%f", value];
        self.text = [NSString stringWithFormat:@"%.@",[formatter stringFromNumber:@(value)]];
        
    }
    
}

@end
