//
//  UISlider+Helper.h
//  NNCategoryPro
//
//  Created by Bin Shang on 2019/11/11.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UISlider (Helper)

- (void)addActionHandler:(void(^)(UISlider *sender))handler forControlEvents:(UIControlEvents)controlEvents;

+ (instancetype)createRect:(CGRect)rect minValue:(CGFloat)minValue maxValue:(CGFloat)maxValue;

@end

NS_ASSUME_NONNULL_END
