//
//  UIViewController+Helper.h
//  
//
//  Created by BIN on 2017/8/14.
//  Copyright © 2017年 SHANG. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UIViewController+AddView.h"

@protocol FailRefreshViewDelegate<NSObject>

@optional
- (void)failRefresh;

@end

NS_ASSUME_NONNULL_BEGIN

typedef void(^BlockAlertController)(UIAlertController *alertController, UIAlertAction *_Nullable action);


@interface UIViewController (Helper)

/// 字符串->UIViewController
FOUNDATION_EXPORT UIViewController * _Nullable UICtrFromString(NSString *obj);
/// 字符串->UINavigationController
FOUNDATION_EXPORT UINavigationController * _Nullable UINavCtrFromObj(id obj);

- (BOOL)isCurrentVisibleViewController;

- (void)addFailRefreshViewWithTitle:(NSString *)title;

- (void)addNoDataRefreshViewWithTitle:(NSString *_Nullable)title;
- (void)addNoDataRefreshViewWithTitle:(NSString *_Nullable)title inView:(UIView *_Nullable)inView;

- (void)removeFailRefreshView;

- (void)removeFailRefreshView:(UIView *)inView;

@property (nonatomic, weak) id<FailRefreshViewDelegate> delegate;

@property (nonatomic, copy) BlockAlertController _Nullable blockAlertController;

@property (nonatomic, strong) UIViewController * _Nullable frontVC;
@property (nonatomic, strong, readonly) UIViewController * _Nullable currentVC;

@property (nonatomic, strong) id obj;
@property (nonatomic, strong) id objOne;
@property (nonatomic, strong) id objModel;

@property (nonatomic, assign) NSTimeInterval timeInterval;
@property (nonatomic, strong, readonly) NSString * _Nullable controllerName;

- (void)setupExtendedLayout;

/**
  导航栏按钮
 */
- (UIButton *)createBarItemTitle:(NSString *)title imgName:(NSString *_Nullable)imageName isLeft:(BOOL)isLeft isHidden:(BOOL)isHidden handler:(void(^)(id obj, UIButton * item, NSInteger idx))handler;

- (UIView *)createBarItem:(NSString *)obj isLeft:(BOOL)isLeft handler:(void(^)(id obj, UIView *item, NSInteger idx))handler;

- (UITableViewCell *)cellByClickView:(UIView *)view;

- (NSIndexPath *)indexPathByClickView:(UIView *)view tableView:(UITableView *)tableView;

/**
 找导航控制器栈中控制器
 */
- (id _Nullable )findController:(NSString *)contollerName navController:(UINavigationController *)navController;

/**
 (推荐)跳转到contollerName控制器中去,先在navController栈中查找有就返回没有就创建一个(用于无参数跳转界面)
 
 */
- (void)goController:(NSString *)contollerName title:(NSString *_Nullable)title;
- (void)goController:(NSString *)contollerName title:(NSString *_Nullable)title obj:(id _Nullable)obj;
- (void)goController:(NSString *)contollerName title:(NSString *_Nullable)title obj:(id _Nullable)obj objOne:(id _Nullable)objOne;

- (void)presentController:(NSString *)contollerName title:(NSString *_Nullable)title;
- (void)presentController:(NSString *)contollerName title:(NSString *_Nullable)title animated:(BOOL)animated;

- (void)presentController:(NSString *)contollerName title:(NSString *_Nullable)title obj:(id _Nullable)obj;
- (void)presentController:(NSString *)contollerName title:(NSString *_Nullable)title obj:(id _Nullable)obj objOne:(id _Nullable)objOne;
- (void)presentController:(NSString *)contollerName title:(NSString * _Nullable)title obj:(id _Nullable)obj objOne:(id _Nullable)objOne animated:(BOOL)animated;

/**
 堆栈中查找控制器,找到返回,没有创建
 */
- (UIViewController *)getController:(NSString *)contollerName navController:(UINavigationController *_Nullable)navController;

- (UIViewController *_Nullable)getController:(NSString *)contollerName;

- (UIViewController *)addControllerName:(NSString *)className;

- (void)addControllerVC:(UIViewController *)controller;

- (void)removeFromSuperVC;

- (void)transitionToVC:(UIViewController *)controller;

/**
 系统弹窗__无按钮 toast
 */
- (void)showAlertTitle:(NSString *_Nullable)title msg:(NSString *_Nullable)msg;

/**
 系统弹窗__按钮默认(取消,确认)
 */
- (void)showAlertTitle:(NSString *_Nullable)title msg:(NSString *_Nullable)msg handler:(void(^)(UIAlertController *alertVC, UIAlertAction * _Nullable action))handler;

/**
 系统弹窗__按钮自定义(actionTitleList传入按钮标题)
 */
- (void)showAlertTitle:(NSString *_Nullable)title msg:(NSString *_Nullable)msg actionTitles:(NSArray *_Nullable)actionTitles handler:(void(^_Nullable)(UIAlertController *alertVC, UIAlertAction *_Nullable action))handler;

//app星际评价,自定义app链接
- (void)dispalyAppEvalutionStarLevelAppID:(NSString *)appID;

- (void)callPhone:(NSString *)phoneNumber;

- (void)setupNavigationBarBackgroundImage:(UIImage *)image;

- (UIButton *)createBackItem:(UIImage *)image;
- (UIButton *)createBackItem:(UIImage *)image tintColor:(UIColor *)tintColor;

@end

NS_ASSUME_NONNULL_END
