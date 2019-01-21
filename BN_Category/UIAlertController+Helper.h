//
//  UIAlertController+Helper.h
//  ProductTemplet
//
//  Created by Bin Shang on 2019/1/17.
//  Copyright © 2019 BN. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIAlertController (Helper)

+ (instancetype)showAlertTitle:(nullable NSString *)title msg:(NSString *)msg placeholders:(NSArray *)placeholders actionTitles:(NSArray *_Nonnull)actionTitles handler:(void(^)(UIAlertController * _Nonnull alertVC, UIAlertAction * _Nullable action))handler;

+ (instancetype)showSheetTitle:(nullable NSString *)title msg:(NSString *)msg actionTitles:(NSArray *_Nonnull)actionTitles handler:(void(^)(UIAlertController * _Nonnull alertVC, UIAlertAction * _Nullable action))handler;

@end

NS_ASSUME_NONNULL_END
