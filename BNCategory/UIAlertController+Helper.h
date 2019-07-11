//
//  UIAlertController+Helper.h
//  ProductTemplet
//
//  Created by Bin Shang on 2019/1/17.
//  Copyright © 2019 BN. All rights reserved.
//

#import <UIKit/UIKit.h>

/// UIAlertController标题富文本key
FOUNDATION_EXPORT NSString * _Nonnull const kAlertCtlrTitle;
/// UIAlertController信息富文本key
FOUNDATION_EXPORT NSString * _Nonnull const kAlertCtlrMessage;
/// UIAlertController按钮颜色key
FOUNDATION_EXPORT NSString * _Nonnull const kAlertActionColor;

NS_ASSUME_NONNULL_BEGIN

@interface UIAlertController (Helper)

+ (instancetype)createAlertTitle:(NSString *_Nullable)title msg:(NSString *_Nullable)msg placeholders:(NSArray *_Nullable)placeholders actionTitles:(NSArray *_Nullable)actionTitles handler:(void(^)(UIAlertController * _Nonnull alertVC, UIAlertAction * _Nonnull action))handler;

+ (instancetype)showAlertTitle:(NSString * _Nullable)title msg:(NSString *_Nullable)msg placeholders:(NSArray *_Nullable)placeholders actionTitles:(NSArray *_Nullable)actionTitles handler:(void(^)(UIAlertController * _Nonnull alertVC, UIAlertAction * _Nonnull action))handler;

+ (instancetype)createSheetTitle:(NSString *_Nullable)title msg:(NSString *_Nullable)msg actionTitles:(NSArray *_Nullable)actionTitles handler:(void(^)(UIAlertController * _Nonnull alertVC, UIAlertAction * _Nonnull action))handler;

+ (instancetype)showSheetTitle:(NSString *_Nullable)title msg:(NSString *_Nullable)msg actionTitles:(NSArray *_Nullable)actionTitles handler:(void(^)(UIAlertController * _Nonnull alertVC, UIAlertAction * _Nonnull action))handler;

+ (instancetype)showAletTitle:(NSString *_Nullable)title msg:(NSString *_Nullable)msg handler:(void(^)(void))handler;

/// 设置标题颜色
- (void)setTitleColor:(UIColor *_Nonnull)color;
/// 设置Message文本换行,对齐方式
- (void)setMessageParaStyle:(NSMutableParagraphStyle *_Nonnull)style;

@end

NS_ASSUME_NONNULL_END
