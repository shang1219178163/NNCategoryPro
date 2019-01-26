//
//  UIApplication+Other.h
//  
//
//  Created by BIN on 2018/9/18.
//  Copyright © 2018年 SHANG. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BNShareModel;

typedef NS_ENUM(NSUInteger,PrivacyType) {
    PrivacyTypePhoto = 0,
    PrivacyTypeCamera,
    PrivacyTypeMedia,
    PrivacyTypeMicrophone,
    PrivacyTypeBluetooth,
    PrivacyTypePushNotification,
    PrivacyTypeSpeech,
    PrivacyTypeEvent,
    PrivacyTypeReminder,
    PrivacyTypeContact,

};

typedef NS_ENUM(NSUInteger,PrivacyStatus) {
    PrivacyStatusAuthorized = 0,
    PrivacyStatusDenied,
    PrivacyStatusNotDetermined,
    PrivacyStatusRestricted,
    PrivacyStatusUnkonwn,
};

@interface UIApplication (Other)

@property (class, nonatomic, readonly) NSDictionary * dictPrivacy;


/**
 * @brief `Function for access the permissions` -> 获取权限函数
 * @param type `The enumeration type for access permission` -> 获取权限枚举类型
 * @param completion `A block for the permission result and the value of authorization status` -> 获取权限结果和对应权限状态的block
 */
+ (void)privacy:(PrivacyType)type completion:(void(^)(BOOL response,PrivacyStatus status, NSString *name))completion;

+ (BOOL)privacy:(PrivacyType)type handler:(void(^)(BOOL response, NSString *name))handler;

+ (BOOL)hasRightOfPhotosLibrary;

+ (BOOL)hasRightOfCameraUsage;

+ (BOOL)hasRightOfAVCapture;

+ (void)setupIQKeyboardManager;

//+ (void)registerShareSDK;
//+ (void)handleMsgShareDataModel:(BNShareModel *)dataModel type:(NSNumber *)type;
//+ (void)registerUMengSDKAppKey:(NSString *_Nonnull)appKey channel:(NSString *_Nonnull)channel;

- (BOOL)checkVersion;
    
//- (BOOL)updateVersion;

@end


@interface BNShareModel : NSObject

@property (nonatomic, copy) NSString * shareTitle;
@property (nonatomic, copy) NSString * shareDate;
@property (nonatomic, copy) NSString * shareDesc;
@property (nonatomic, copy) NSString * shareContent;
@property (nonatomic, copy) NSString * shareFrom;
@property (nonatomic, copy) NSArray * shareImages;

@property (nonatomic, copy) NSString * shareUrl;

@end

