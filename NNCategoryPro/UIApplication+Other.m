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
#import <IQKeyboardManager/IQKeyboardManager.h>

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

/**
 是否有消息推送权限
 */
+ (BOOL)hasRightOfPush{
    BOOL isHasRight = true;
    if (UIApplication.sharedApplication.currentUserNotificationSettings.types == UIUserNotificationTypeNone) {
        isHasRight = false;
    }
    return isHasRight;
}

+ (void)setupIQKeyboardManager{
    IQKeyboardManager *keyboardManager = [IQKeyboardManager sharedManager]; // 获取类库的单例变量
    keyboardManager.enable = YES; // 控制整个功能是否启用
    keyboardManager.shouldResignOnTouchOutside = YES; // 控制点击背景是否收起键盘
    keyboardManager.shouldToolbarUsesTextFieldTintColor = YES; // 控制键盘上的工具条文字颜色是否用户自定义
    keyboardManager.toolbarManageBehaviour = IQAutoToolbarBySubviews; // 有多个输入框时，可以通过点击Toolbar 上的“前一个”“后一个”按钮来实现移动到不同的输入框
    keyboardManager.enableAutoToolbar = NO; // 控制是否显示键盘上的工具条
    keyboardManager.shouldShowToolbarPlaceholder = YES; // 是否显示占位文字
    keyboardManager.placeholderFont = [UIFont boldSystemFontOfSize:14]; // 设置占位文字的字体
    keyboardManager.keyboardDistanceFromTextField = 10.0f; // 输入框距离键盘的距离
}

/**
 注册APNs远程推送
 */
+ (void)registerAPNsWithDelegate:(id)delegate{
    if (@available(iOS 10.0, *)) {
        UNAuthorizationOptions options = UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert;
        UNUserNotificationCenter *center = UNUserNotificationCenter.currentNotificationCenter;
        center.delegate = delegate;
        [center requestAuthorizationWithOptions:options completionHandler:^(BOOL granted, NSError * _Nullable error) {
            if (granted) {
            }
        }];
        [UIApplication.sharedApplication registerForRemoteNotifications];
        
    }
    else {
        UIUserNotificationType types = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
        [UIApplication.sharedApplication registerUserNotificationSettings:settings];
        [UIApplication.sharedApplication registerForRemoteNotifications];
    }
}


/**
 iOS10添加本地通知
 */
+ (void)addLocalNoti:(NSString *)title
                body:(NSString *)body
            userInfo:(NSDictionary *)userInfo
          identifier:(NSString *)identifier
             handler:(void(^)(UNUserNotificationCenter *center, UNNotificationRequest *request, NSError * _Nullable error))handler{
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
    if (UIApplication.sharedApplication.currentUserNotificationSettings.types == UIUserNotificationTypeNone) {
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"请在[设置]-[通知]中打开推送功能"
                                                                         message:nil
                                                                  preferredStyle:UIAlertControllerStyleAlert];
        [alertVC addActionTitles:@[kTitleKnow] handler:nil];
        [alertVC present:true completion:nil];
#ifdef DEBUG
        NSLog(@"请在[设置]-[通知]中打开推送功能");
#endif
        return;
    }
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


@end

