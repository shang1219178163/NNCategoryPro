//
//  UISlider+Helper.m
//  NNCategoryPro
//
//  Created by Bin Shang on 2019/11/11.
//

#import "UISlider+Helper.h"
#import "UIColor+Helper.h"

@implementation UISlider (Helper)

/**
 [源]UISlider创建方法
 */
+ (instancetype)createRect:(CGRect)rect
                  minValue:(CGFloat)minValue
                  maxValue:(CGFloat)maxValue{
    UISlider *view = [[self alloc] initWithFrame:rect];
    view.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    view.minimumValue = minValue;
    view.maximumValue = maxValue;
    view.value = minValue;
    
    view.minimumTrackTintColor = UIColor.themeColor;
//    view.maximumTrackTintColor = UIColor.redColor;
//    view.thumbTintColor = UIColor.yellowColor;
    return view;
}


@end
