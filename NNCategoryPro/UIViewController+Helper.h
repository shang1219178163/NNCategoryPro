//
//  UIViewController+Helper.h
//  
//
//  Created by BIN on 2017/8/14.
//  Copyright © 2017年 SHANG. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UIViewController+AddView.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (Helper)

/// 字符串->UIViewController
FOUNDATION_EXPORT UIViewController * _Nullable UICtrFromString(NSString *obj);
/// 字符串->UINavigationController
FOUNDATION_EXPORT UINavigationController * _Nullable UINavCtrFromObj(id obj);

@property (nonatomic, strong, readonly) NSString * _Nullable controllerName;
@property (nonatomic, strong, readonly) UIViewController * _Nullable frontVC;
@property (nonatomic, strong, readonly) UIViewController * _Nullable currentVC;

/// 返回按钮
@property (nonatomic, strong) UIButton *backBtn;

- (BOOL)isCurrentVisibleVC;

- (UIButton *)createBackItem:(UIImage *)image;

- (void)setupExtendedLayout;

- (void)setupContentInsetAdjustmentBehavior:(BOOL)isAutomatic;

- (void)present:(BOOL)animated completion:(void (^ __nullable)(void))completion;

/// [源]创建UISearchController(设置IQKeyboardManager.shared.enable = false;//避免searchbar下移)
- (UISearchController *)createSearchVC:(UIViewController *)resultsController;

/**
  导航栏按钮
 */
- (UIButton *)createBarItemTitle:(NSString *)title
                         imgName:(NSString *_Nullable)imageName
                          isLeft:(BOOL)isLeft
                        isHidden:(BOOL)isHidden
                         handler:(void(^)(id obj, UIButton * item, NSInteger idx))handler;

- (UIView *)createBarItem:(NSString *)obj isLeft:(BOOL)isLeft handler:(void(^)(id obj, UIView *item, NSInteger idx))handler;
 
- (__kindof UIViewController * _Nullable)frontViewController:(UINavigationController *)navContoller;

- (void)pushVC:(NSString *)vcName
         title:(NSString *)title
      animated:(BOOL)animated
         block:(void(^ _Nullable)(__kindof UIViewController *vc))block;

- (void)pushVCType:(Class)classVC
             title:(NSString *)title
          animated:(BOOL)animated
             block:(void(^ _Nullable)(__kindof UIViewController *vc))block;

- (void)presentVC:(NSString *)vcName
            title:(NSString *)title
         animated:(BOOL)animated
            block:(void(^ _Nullable)(__kindof UIViewController *vc))block;

- (void)presentVCType:(Class)classVC
                title:(NSString *)title
             animated:(BOOL)animated
                block:(void(^ _Nullable)(__kindof UIViewController *vc))block;

- (UIViewController *)addControllerName:(NSString *)className;
/// 添加子控制器(对应方法 removeControllerVC)
- (void)addControllerVC:(UIViewController *)controller;

- (void)removeFromSuperVC;
/// 显示controller(手动调用viewWillAppear和viewDidAppear,viewWillDisappear)
- (void)transitionToVC:(UIViewController *)controller;

/**
// 系统弹窗__无按钮 toast
// */
//- (void)showAlertTitle:(NSString *_Nullable)title msg:(NSString *_Nullable)msg;
//
///**
// 系统弹窗__按钮默认(取消,确认)
// */
//- (void)showAlertTitle:(NSString *_Nullable)title msg:(NSString *_Nullable)msg handler:(void(^)(UIAlertController *alertVC, UIAlertAction * _Nullable action))handler;
//
///**
// 系统弹窗__按钮自定义(actionTitleList传入按钮标题)
// */
//- (void)showAlertTitle:(NSString *_Nullable)title msg:(NSString *_Nullable)msg actionTitles:(NSArray *_Nullable)actionTitles handler:(void(^_Nullable)(UIAlertController *alertVC, UIAlertAction *_Nullable action))handler;

//app星际评价,自定义app链接
- (void)dispalyAppEvalutionStarLevelAppID:(NSString *)appID;

- (void)setupNavigationBarBackgroundImage:(UIImage *)image;

@end


@interface UINavigationController (Helper)

- (__kindof UIViewController * _Nullable)findController:(Class)classVC;

- (__kindof UIViewController * _Nullable)findControllerName:(NSString *)vcName;

@end

NS_ASSUME_NONNULL_END
