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

typedef void(^BlockAlertController)(UIAlertController * _Nonnull alertController, UIAlertAction * _Nullable action);

@interface UIViewController (Helper)

- (BOOL)isCurrentVisibleViewController;

- (void)addFailRefreshViewWithTitle:(NSString *_Nonnull)title;

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
@property (nonatomic, strong) id _Nonnull objModel;

@property (nonatomic, assign) NSTimeInterval timeInterval;
@property (nonatomic, strong, readonly) NSString * _Nullable controllerName;

- (void)configureDefault;

/**
  导航栏按钮
 */
- (UIButton *)createBarItemTitle:(NSString *)title imageName:(NSString *)imageName isLeft:(BOOL)isLeft isHidden:(BOOL)isHidden handler:(void(^)(id obj, UIButton * item, NSInteger idx))handler;

- (UITableViewCell *_Nonnull)cellByClickView:(UIView *_Nonnull)view;

- (NSIndexPath *_Nonnull)indexPathByClickView:(UIView *_Nonnull)view tableView:(UITableView *_Nonnull)tableView;

/**
 找导航控制器栈中控制器
 */
- (id _Nullable )findController:(NSString *_Nonnull)contollerName navController:(UINavigationController *_Nonnull)navController;

/**
 (推荐)跳转到contollerName控制器中去,先在navController栈中查找有就返回没有就创建一个(用于无参数跳转界面)
 
 */
- (void)goController:(NSString *_Nonnull)contollerName title:(NSString *_Nullable)title;
- (void)goController:(NSString *_Nonnull)contollerName title:(NSString *_Nullable)title obj:(id _Nullable)obj;
- (void)goController:(NSString *_Nonnull)contollerName title:(NSString *_Nullable)title obj:(id _Nullable)obj objOne:(id _Nullable)objOne;

- (void)presentController:(NSString *_Nonnull)contollerName title:(NSString *_Nullable)title;
- (void)presentController:(NSString *_Nonnull)contollerName title:(NSString *_Nullable)title obj:(id _Nullable)obj;
- (void)presentController:(NSString *_Nonnull)contollerName title:(NSString *_Nullable)title obj:(id _Nullable)obj objOne:(id _Nullable)objOne;

/**
 堆栈中查找控制器,找到返回,没有创建
 */
- (UIViewController *_Nonnull)getController:(NSString *_Nonnull)contollerName navController:(UINavigationController *_Nullable)navController;

- (UIViewController *_Nullable)getController:(NSString *_Nonnull)contollerName;

- (UIViewController *)addChildControllerView:(NSString *)className;

/**
 系统弹窗__按钮默认(知道了)
 */
- (void)showAlertTitle:(NSString *_Nullable)title msg:(NSString *_Nullable)msg;

/**
 系统弹窗__按钮默认(取消,确认)
 */
- (void)showAlertTitle:(NSString *_Nullable)title msg:(NSString *_Nullable)msg handler:(void(^)(UIAlertController * _Nonnull alertVC, UIAlertAction * _Nullable action))handler;

/**
 系统弹窗__按钮自定义(actionTitleList传入按钮标题)
 */
- (void)showAlertTitle:(nullable NSString *)title msg:(nullable NSString *)msg actionTitles:(NSArray *_Nonnull)actionTitles handler:(void(^_Nullable)(UIAlertController * _Nonnull alertVC, UIAlertAction * _Nullable action))handler;

/**
 弹窗源方法
 placeholderList或者 msg  其中一个必须为nil
 */
- (void)showAlertTitle:(NSString *_Nullable)title placeholders:(NSArray *_Nullable)placeholders msg:(NSString *)msg actionTitles:(NSArray *_Nonnull)actionTitles handler:(void(^)(UIAlertController * _Nonnull alertVC, UIAlertAction * _Nonnull action))handler;

//app星际评价,自定义app链接
- (void)dispalyAppEvalutionStarLevelAppID:(NSString *_Nonnull)appID;

- (void)callPhone:(NSString *_Nonnull)phoneNumber;


@end
