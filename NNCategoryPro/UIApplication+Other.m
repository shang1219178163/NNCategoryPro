//
//  UIApplication+Other.m
//  
//
//  Created by BIN on 2018/9/18.
//  Copyright © 2018年 SHANG. All rights reserved.
//

#import "UIApplication+Other.h"
#import <Photos/Photos.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreLocation/CoreLocation.h>

#import "UIApplication+Helper.h"
#import "UIAlertController+Helper.h"

#import "NSObject+Helper.h"
#import "UIView+Helper.h"
#import "UIViewController+Helper.h"

#import <NNGloble/NNGloble.h>
#if __has_include(<IQKeyboardManager/IQKeyboardManager.h>)
#import <IQKeyboardManager/IQKeyboardManager.h>
#endif

@implementation UIApplication (Other)

/**
 是否有相册权限
 */
+ (BOOL)hasRightOfPhotosLibrary{
    __block BOOL isRight = true;
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        if(status == PHAuthorizationStatusAuthorized || status == PHAuthorizationStatusDenied){
            NSString * msg = [NSString stringWithFormat:@"请去-> [设置 - 隐私 - %@ - %@] 打开访问开关", @"相册" , UIApplication.appName];
            [UIAlertController alertControllerWithTitle:@"" message:msg preferredStyle:UIAlertControllerStyleAlert]
            .addAction(@[kTitleKnow], nil)
            .present(true, nil);
            isRight = false;
        }
    }];
    return isRight;
}
/**
 是否有相机权限
 */
+ (BOOL)hasRightOfCameraUsage{
    //相机权限
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeAudio];//读取设备授权状态
    if(status == AVAuthorizationStatusRestricted || status == AVAuthorizationStatusDenied){
        NSString *msg = [NSString stringWithFormat:@"请去-> [设置 - 隐私 - %@ - %@] 打开访问开关", @"相机" , UIApplication.appName];
        [UIAlertController alertControllerWithTitle:@"" message:msg preferredStyle:UIAlertControllerStyleAlert]
        .addAction(@[kTitleKnow], nil)
        .present(true, nil);
        return false;
    }
    return true;
}

/**
  是否有视频拍摄权限
 */
+ (BOOL)hasRightOfAVCapture{
    __block BOOL isHasRight = false;
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (!device) {
        return false;
    }
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    switch (status) {
        case AVAuthorizationStatusNotDetermined: {
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                if (granted) {
                    isHasRight = true;
                    DDLog(@"用户第一次同意了访问相机权限 - - %@", NSThread.currentThread);
                } else {
                    DDLog(@"用户第一次拒绝了访问相机权限 - - %@", NSThread.currentThread);
                }
            }];
            break;
        }
        case AVAuthorizationStatusAuthorized: {
            isHasRight = true;
            break;
        }
        case AVAuthorizationStatusDenied:
        case AVAuthorizationStatusRestricted:
        {
            NSString *msg = [NSString stringWithFormat:@"请去-> [设置 - 隐私 - 相机 - %@] 打开访问开关",UIApplication.appName];
            [UIAlertController alertControllerWithTitle:@"" message:msg preferredStyle:UIAlertControllerStyleAlert]
            .addAction(@[kTitleKnow], nil)
            .present(true, nil);
            break;
        }
        default:
            break;
    }
    return isHasRight;
}


+ (void)setupIQKeyboardManager{
#if __has_include(<IQKeyboardManager/IQKeyboardManager.h>)
    IQKeyboardManager *keyboardManager = [IQKeyboardManager sharedManager];
    keyboardManager.enable = YES;
    keyboardManager.shouldResignOnTouchOutside = YES;
    keyboardManager.shouldToolbarUsesTextFieldTintColor = YES;
    keyboardManager.toolbarManageBehaviour = IQAutoToolbarBySubviews;
    keyboardManager.enableAutoToolbar = NO;
    keyboardManager.shouldShowToolbarPlaceholder = YES;
    keyboardManager.placeholderFont = [UIFont boldSystemFontOfSize:14];
    keyboardManager.keyboardDistanceFromTextField = 10.0f;
#else
    NSLog(@"[NNCategoryPro] 未集成 IQKeyboardManager，setupIQKeyboardManager 已跳过（SPM 请自行添加该依赖）");
#endif
}

/**
 注册APNs远程推送
 */
+ (void)registerAPNsWithDelegate:(id)delegate{
    UNAuthorizationOptions options = UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert;
    UNUserNotificationCenter *center = UNUserNotificationCenter.currentNotificationCenter;
    center.delegate = delegate;
    [center requestAuthorizationWithOptions:options completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (granted) {
        }
    }];
    [UIApplication.sharedApplication registerForRemoteNotifications];
}

/**
 添加本地通知
 */
+ (void)addLocalNoti:(NSString *)title
                body:(NSString *)body
            userInfo:(NSDictionary *)userInfo
          identifier:(NSString *)identifier
             handler:(void(^)(UNUserNotificationCenter *center,
                              UNNotificationRequest *request,
                              NSError * _Nullable error))handler{
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
    content.sound = UNNotificationSound.defaultSound;
    content.title = title;
    content.body = body;
    content.userInfo = userInfo;
    
    [content addToCenter:nil handler:handler];
}

+ (void)getNotifications:(BOOL)isDelivered handler:(void(^)(NSArray *items))handler{
    UNUserNotificationCenter *center = UNUserNotificationCenter.currentNotificationCenter;
//    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"identifier" ascending:YES];

    if (isDelivered == YES) {
        //获取设备已收到的消息推送
        [center getDeliveredNotificationsWithCompletionHandler:^(NSArray<UNNotification *> * notifications) {
            DDLog(@"Delivered %ld", notifications.count);
            handler(notifications);
        }];
    }
    else{
        [center getPendingNotificationRequestsWithCompletionHandler:^(NSArray<UNNotificationRequest *> * requests) {
            DDLog(@"Pending %ld", requests.count);
            handler(requests);
        }];
    }
}


+ (NSString *)appUrlWithID:(NSString *)appStoreID {
    NSString *urlString = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/app/id%@?mt=8", appStoreID];
    return urlString;
}

+ (NSString *)appDetailUrlWithID:(NSString *)appStoreID {
    NSString *urlString = [NSString stringWithFormat:@"http://itunes.apple.com/cn/lookup?id=%@", appStoreID];
    return urlString;
}


+ (void)updateVersion:(NSString *)appStoreID handler:(void(^)(NSDictionary *dic, NSString *appStoreVer, NSString *releaseNotes, bool isUpdate))handler {
    NSString *path = [UIApplication appDetailUrlWithID:appStoreID];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:path] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:6];
    request.HTTPMethod = @"POST";
    
    NSURLSessionDataTask *dataTask = [NSURLSession.sharedSession dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!data) {
            return;
        }
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        if (!dic || ![dic[@"resultCount"] isEqualToNumber:@1]) {
            return;
        }
                        
        NSDictionary *dicInfo = [dic[@"results"] firstObject];
        
        NSString *appStoreVer = dicInfo[@"version"];
        NSString *releaseNotes = dicInfo[@"releaseNotes"];
//       NSString *trackViewUrl = dicInfo[@"trackViewUrl"];// appStore 跳转版本链接
        
        BOOL isUpdate = [appStoreVer compare:UIApplication.appVer options:NSNumericSearch] == NSOrderedDescending;
        if (handler) {
            handler(dicInfo, appStoreVer, releaseNotes, isUpdate);
        }
    }];
    [dataTask resume];
}


+ (void)checkVersion:(NSString *)appStoreID {
    [UIApplication updateVersion:appStoreID handler:^(NSDictionary *dic, NSString *appStoreVer, NSString *releaseNotes, bool isUpdate) {
        if (isUpdate == false) {
            return;
        }

        dispatch_async(dispatch_get_main_queue(), ^{
            NSString *versionInfo = [NSString stringWithFormat:@"新版本V%@!",appStoreVer];
            // AppStore版本号大于当前版本号，强制更新
            // 弹窗 更新
            UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:versionInfo message:releaseNotes preferredStyle:UIAlertControllerStyleAlert];
            alertVC.addAction(@[kTitleCall,kTitleUpdate], ^(UIAlertAction * _Nonnull action) {
                if ([action.title isEqualToString:kTitleUpdate]) {
                    // 升级去
                    NSString *urlStr = [UIApplication appUrlWithID:appStoreID];
                    [UIApplication openURLString:urlStr prefix:@"http://" completion:^(BOOL success) {
//                                if (!success) {
//                                    NSString *tips = [urlStr stringByAppendingString:@"打开失败"];
//                                    [UIAlertController showAlertTitle:tips message:nil actionTitles:nil handler:nil];
//                                }
                    }];
                }
            })
            .present(true, nil);
               
            // 富文本效果
            NSMutableParagraphStyle * style = [[NSMutableParagraphStyle alloc]init];
            style.lineBreakMode = NSLineBreakByCharWrapping;
            style.alignment = NSTextAlignmentLeft;
            style.lineSpacing = 5;
            
            [alertVC setTitleColor: UIColor.themeColor];
            [alertVC setMessageParaStyle:style];
        });
    }];
}

@end



@implementation UNMutableNotificationContent

- (instancetype)initWithTitle:(NSString *)title
                         body:(NSString *)body
                     userInfo:(NSDictionary *)userInfo
                        sound:(UNNotificationSound *)sound {
    self = [super init];
    if (self) {
        self.title = title;
        self.body = body;
        self.userInfo = userInfo;
        self.sound = sound;
    }
    return self;
}


/// 添加到通知中心
/// @param trigger UNTimeIntervalNotificationTrigger/UNCalendarNotificationTrigger/UNCalendarNotificationTrigger
- (void)addToCenter:(nullable UNNotificationTrigger *)trigger
            handler:(void(^)(UNUserNotificationCenter *center,
                             UNNotificationRequest *request,
                             NSError * _Nullable error))handler{
    NSString *identifier = [NSString stringWithFormat:@"%@", NSDate.date];
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier: identifier
                                                                          content: self
                                                                          trigger: trigger];
    
    UNUserNotificationCenter *center = UNUserNotificationCenter.currentNotificationCenter;
    @weakify(center);
    [center addNotificationRequest:request withCompletionHandler:^(NSError *_Nullable error) {
        @strongify(center);
        if (handler) handler(center, request, error);
        if (error) {
#ifdef DEBUG
            NSLog(@"%@", error.localizedDescription);
#endif
            return ;
        }
        UIApplication.sharedApplication.applicationIconBadgeNumber += 1;
        NSLog(@"成功添加推送");
    }];
}


- (void)addTimeIntervalRequestToCenter:(NSTimeInterval)timeInterval
                               repeats:(BOOL)repeats
                               handler:(void(^)(UNUserNotificationCenter *center,
                                                UNNotificationRequest *request,
                                                NSError * _Nullable error))handler{    
    UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:timeInterval
                                                                                                    repeats:repeats];
    
    [self addToCenter:trigger handler:handler];
}


- (void)addCalendarRequestToCenter:(NSDateComponents *)dateComponents
                           repeats:(BOOL)repeats
                           handler:(void(^)(UNUserNotificationCenter *center,
                                            UNNotificationRequest *request,
                                            NSError * _Nullable error))handler{
    UNCalendarNotificationTrigger *trigger = [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:dateComponents
                                                                                                      repeats:repeats];
    [self addToCenter:trigger handler:handler];
}


- (void)addLocationRequestToCenter:(CLRegion *)region
                           repeats:(BOOL)repeats
                           handler:(void(^)(UNUserNotificationCenter *center,
                                            UNNotificationRequest *request,
                                            NSError * _Nullable error))handler{
    UNLocationNotificationTrigger *trigger = [UNLocationNotificationTrigger triggerWithRegion:region
                                                                                      repeats:repeats];
    
    [self addToCenter:trigger handler:handler];
}

@end

