//
//  UIPageControl+Helper.h
//  AESCrypt-ObjC
//
//  Created by Bin Shang on 2019/11/11.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIPageControl (Helper)

+ (instancetype)createRect:(CGRect)rect numberOfPages:(NSInteger)numberOfPages;

@end

NS_ASSUME_NONNULL_END
