//
//  UIApplication+Other.h
//  
//
//  Created by BIN on 2018/9/18.
//  Copyright © 2018年 SHANG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UserNotifications/UserNotifications.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIApplication (Other)

+ (BOOL)hasRightOfPhotosLibrary;

+ (BOOL)hasRightOfCameraUsage;

+ (BOOL)hasRightOfAVCapture;

+ (void)setupIQKeyboardManager;

+ (void)registerAPNsWithDelegate:(id)delegate;

///添加本地通知
+ (void)addLocalNoti:(NSString *)title
                body:(NSString *)body
            userInfo:(NSDictionary *)userInfo
          identifier:(NSString *)identifier
             handler:(void(^)(UNUserNotificationCenter *center, UNNotificationRequest *request, NSError * _Nullable error))handler;

///获取已过期或者未过期的本地通知
+ (void)getNotifications:(BOOL)isDelivered handler:(void(^)(NSArray *items))handler;

+ (void)updateVersion:(NSString *)appStoreID handler:(void(^)(NSDictionary *dic, NSString *appStoreVer, NSString *releaseNotes, bool isUpdate))handler;

+ (void)checkVersion:(NSString *)appStoreID;

@end



@interface UNMutableNotificationContent (Other)

- (instancetype)initWithTitle:(NSString *)title
                         body:(NSString *)body
                     userInfo:(NSDictionary *)userInfo
                        sound:(UNNotificationSound *)sound;

/// 添加到通知中心
/// @param trigger UNTimeIntervalNotificationTrigger/UNCalendarNotificationTrigger/UNCalendarNotificationTrigger
- (void)addToCenter:(nullable UNNotificationTrigger *)trigger
            handler:(void(^)(UNUserNotificationCenter *center,
                             UNNotificationRequest *request,
                             NSError * _Nullable error))handler;
@end

NS_ASSUME_NONNULL_END
