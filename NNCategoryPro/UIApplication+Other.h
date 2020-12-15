//
//  UIApplication+Other.h
//  
//
//  Created by BIN on 2018/9/18.
//  Copyright © 2018年 SHANG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UserNotifications/UserNotifications.h>

@class NNShareModel;

NS_ASSUME_NONNULL_BEGIN

@interface UIApplication (Other)

+ (BOOL)hasRightOfPhotosLibrary;

+ (BOOL)hasRightOfCameraUsage;

+ (BOOL)hasRightOfAVCapture;

+ (BOOL)hasRightOfPush;

+ (void)setupIQKeyboardManager;

+ (void)registerAPNsWithDelegate:(id)delegate;

+ (void)addLocalUserNotiTrigger:(id)trigger
                        content:(UNMutableNotificationContent *)content
                     identifier:(NSString *)identifier
                 notiCategories:(id)notiCategories
                        repeats:(BOOL)repeats
                        handler:(void(^)(UNUserNotificationCenter *center, UNNotificationRequest *request, NSError * _Nullable error))handler API_AVAILABLE(ios(10.0));
///获取已过期或者未过期的本地通知
+ (NSArray<UNNotification *> *)getNotifications:(BOOL)isDelivered titles:(NSArray * __nullable)titles API_AVAILABLE(ios(10.0));

+ (void)addLocalNotification;
/**
 iOS10添加本地通知
 */
+ (void)addLocalNoti:(NSString *)title
                body:(NSString *)body
            userInfo:(NSDictionary *)userInfo
          identifier:(NSString *)identifier
             handler:(void(^)(UNUserNotificationCenter* center, UNNotificationRequest *request, NSError * _Nullable error))handler API_AVAILABLE(ios(10.0));

+ (UILocalNotification *)addLocalNoti:(NSString *)title
                                 body:(NSString *)body
                             userInfo:(NSDictionary *)userInfo
                             fireDate:(NSDate *)fireDate
                       repeatInterval:(NSCalendarUnit)repeatInterval
                               region:(CLRegion *)region;

//+ (void)registerShareSDK;
//+ (void)handleMsgShareDataModel:(NNShareModel *)dataModel type:(NSNumber *)type;
//+ (void)registerUMengSDKAppKey:(NSString *_Nonnull)appKey channel:(NSString *_Nonnull)channel;

+ (void)updateVersion:(NSString *)appStoreID handler:(void(^)(NSDictionary *dic, NSString *appStoreVer, NSString *releaseNotes, bool isUpdate))handler;

+ (void)checkVersion:(NSString *_Nonnull)appStoreID;

@end

NS_ASSUME_NONNULL_END

@interface NNShareModel : NSObject

@property (nonatomic, copy) NSString * _Nonnull shareTitle;
@property (nonatomic, copy) NSString * _Nonnull shareDate;
@property (nonatomic, copy) NSString * _Nullable shareDesc;
@property (nonatomic, copy) NSString * _Nullable shareContent;
@property (nonatomic, copy) NSString * _Nullable shareFrom;
@property (nonatomic, copy) NSArray * _Nullable shareImages;

@property (nonatomic, copy) NSString * _Nonnull shareUrl;

@end

