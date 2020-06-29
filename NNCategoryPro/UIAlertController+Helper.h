//
//  UIAlertController+Helper.h
//  ProductTemplet
//
//  Created by Bin Shang on 2019/1/17.
//  Copyright © 2019 BN. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// UIAlertController标题富文本key
FOUNDATION_EXPORT NSString * const kAlertVCTitle;
/// UIAlertController信息富文本key
FOUNDATION_EXPORT NSString * const kAlertVCMessage;
/// UIAlertController按钮颜色key
FOUNDATION_EXPORT NSString * const kAlertActionColor;

@interface UIAlertController (Helper)
/// [源]Alert弹窗创建
+ (instancetype)createAlertTitle:(NSString *_Nullable)title
                             msg:(NSString *_Nullable)msg
                    placeholders:(NSArray *_Nullable)placeholders
                    actionTitles:(NSArray *_Nullable)actionTitles
                         handler:(void(^_Nullable)(UIAlertController * alertVC, UIAlertAction * action))handler;
/// [源]Alert弹窗展示
+ (instancetype)showAlertTitle:(NSString * _Nullable)title
                           msg:(NSString *_Nullable)msg
                  placeholders:(NSArray *_Nullable)placeholders
                  actionTitles:(NSArray *_Nullable)actionTitles
                       handler:(void(^_Nullable)(UIAlertController * alertVC, UIAlertAction * action))handler;

/// [源]Sheet弹窗创建
+ (instancetype)createSheetTitle:(NSString *_Nullable)title
                             msg:(NSString *_Nullable)msg
                    actionTitles:(NSArray *_Nullable)actionTitles
                         handler:(void(^_Nullable)(UIAlertController * alertVC, UIAlertAction * action))handler;
/// [源]Sheet弹窗展示
+ (instancetype)showSheetTitle:(NSString *_Nullable)title
                           msg:(NSString *_Nullable)msg
                  actionTitles:(NSArray *_Nullable)actionTitles
                       handler:(void(^_Nullable)(UIAlertController * alertVC, UIAlertAction * action))handler;

//+ (instancetype)showAletTitle:(NSString *_Nullable)title msg:(NSString *_Nullable)msg handler:(void(^ _Nullable)(void))handler;
/// Alert弹窗展示,自定义按钮
+ (instancetype)showAlertTitle:(NSString * _Nullable)title
                           msg:(NSString *_Nullable)msg
                  actionTitles:(NSArray *_Nullable)actionTitles
                       handler:(void(^_Nullable)(UIAlertController *alertVC, UIAlertAction *action))handler;

///Alert弹窗展示,默认(取消,确认)
+ (instancetype)showAlertTitle:(NSString *_Nullable)title
                           msg:(NSString *_Nullable)msg
                       handler:(void(^)(UIAlertController *alertVC, UIAlertAction * _Nullable action))handler;


/// 设置标题颜色
- (void)setTitleColor:(UIColor *)color;
/// 设置Message文本换行,对齐方式
- (void)setMessageParaStyle:(NSMutableParagraphStyle *)style;

@end

NS_ASSUME_NONNULL_END
