//
//  UIViewController+Helper.h
//  HuiZhuBang
//
//  Created by BIN on 2017/8/14.
//  Copyright © 2017年 WeiHouKeJi. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UIViewController+AddView.h"

@protocol FailRefreshViewDelegate<NSObject>

@optional
- (void)failRefresh;

@end

typedef void(^BlockAlertController)(UIAlertController * _Nonnull alertController, UIAlertAction * _Nullable action);

@interface UIViewController (Helper)

-(BOOL)isCurrentVisibleViewController;

- (void)addFailRefreshViewWithTitle:(NSString *_Nonnull)title;

- (void)addNoDataRefreshViewWithTitle:(NSString *_Nullable)title;
- (void)addNoDataRefreshViewWithTitle:(NSString *_Nullable)title inView:(UIView *_Nullable)inView;

- (void)removeFailRefreshView;

- (void)removeFailRefreshView:(UIView *)inView;

@property (nonatomic, weak) id<FailRefreshViewDelegate> delegate;

@property (nonatomic, copy) BlockAlertController _Nullable blockAlertController;

@property (nonatomic, strong) UIViewController * _Nullable frontVC;
@property (nonatomic, strong, readonly) UIViewController * _Nullable frontController;

@property (nonatomic, strong) id obj;
@property (nonatomic, strong) id objOne;

@property (nonatomic, strong) id _Nonnull objModel;

@property (nonatomic, strong, readonly) NSString * _Nullable controllerName;
@property (nonatomic, strong, readonly) UIViewController * _Nullable currentVC;

@property (nonatomic, assign) NSTimeInterval timeInterval;

- (void)configureDefault;

/**
 (弃用)导航栏按钮
 */
- (UIButton *_Nonnull)createBarBtnItemWithTitle:(NSString *_Nullable)title imageName:(NSString *_Nullable)imageName isLeft:(BOOL)isLeft target:(id _Nonnull)target aSelector:(SEL _Nonnull)aSelector isHidden:(BOOL)isHidden;

/**
  导航栏按钮
 */
- (UIButton *)createBarBtnItemWithTitle:(NSString *)title imageName:(NSString *)imageName isLeft:(BOOL)isLeft isHidden:(BOOL)isHidden handler:(void(^)(id obj, id item, NSInteger idx))handler;
//- (void)addLineViewWithRect:(CGRect)rect inView:(UIView *_Nonnull)inView;
//- (void)addLineDashWithRect:(CGRect)rect tag:(NSInteger)tag inView:(UIView *_Nonnull)inView;

- (UITableViewCell *_Nonnull)getCellByClickView:(UIView *_Nonnull)view;

- (NSIndexPath *_Nonnull)getCellIndexPathByClickView:(UIView *_Nonnull)view tableView:(UITableView *_Nonnull)tableView;

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
 跳转到contollerName控制器中去,先在navController栈中查找有就返回没有就创建一个(用于无参数跳转界面)

 @param contollerName 控制器名称
 @param navController 导航控制器
 */
- (void)goController:(NSString *)contollerName title:(NSString *)title navController:(UINavigationController *)navController obj:(id)obj;

/**
 堆栈中查找控制器,找到返回,没有创建
 */
- (UIViewController *_Nonnull)getController:(NSString *_Nonnull)contollerName navController:(UINavigationController *_Nullable)navController;

- (UIViewController *_Nullable)getController:(NSString *_Nonnull)contollerName;

- (UIViewController *)BN_AddChildControllerView:(NSString *)className;


/**
 系统弹窗__按钮默认(知道了)
 */
- (void)showAlertWithTitle:(nullable NSString *)title msg:(nullable NSString *)msg;

/**
 系统弹窗__按钮默认(取消,确认)
 */
- (void)showAlertWithTitle:(nullable NSString *)title msg:(nullable NSString *)msg handler:(void(^_Nullable)(UIAlertController * _Nonnull alertVC, UIAlertAction * _Nullable action))handler;

/**
 系统弹窗__按钮自定义(actionTitleList传入按钮标题)
 */
- (void)showAlertWithTitle:(nullable NSString *)title msg:(nullable NSString *)msg actionTitleList:(NSArray *_Nonnull)actionTitleList handler:(void(^_Nullable)(UIAlertController * _Nonnull alertVC, UIAlertAction * _Nullable action))handler;

/**
 弹窗源方法
 placeholderList或者 msg  其中一个必须为nil
 */
- (void)showAlertWithTitle:(nullable NSString *)title placeholderList:(NSArray *_Nullable)placeholderList msg:(NSString *_Nullable)msg actionTitleList:(NSArray *_Nonnull)actionTitleList handler:(void(^_Nullable)(UIAlertController * _Nonnull alertVC, UIAlertAction * _Nullable action))handler;

/**
 系统Sheet弹窗__按钮默认(取消按钮)
 */
- (void)showSheetWithTitle:(nullable NSString *)title msgList:(NSArray * _Nonnull)msgList handler:(void(^_Nullable)(UIAlertController * _Nonnull alertVC, UIAlertAction * _Nullable action))handler;

//app星际评价,自定义app链接
- (void)dispalyAppEvalutionStarLevelAppID:(NSString *_Nonnull)appID;


/**
 textfield的rightView

 @param unitString 图片名称或者字符串
 @return UIImageView或者UILabel
 */
- (id _Nullable )getTextFieldRightView:(NSString *_Nonnull)unitString;

//- (BOOL)checkLogin;

- (void)callPhone:(NSString *_Nonnull)phoneNumber;

/**
 添加好友弹窗
 */
- (void)showFriendAdd:(NSString *_Nonnull)msg;

@end
