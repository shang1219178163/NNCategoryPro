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
#import <EventKit/EventKit.h>
#import <Contacts/Contacts.h>
#import <Speech/Speech.h>
#import <HealthKit/HealthKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import <UserNotifications/UserNotifications.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import <CoreLocation/CoreLocation.h>
#import <HealthKit/HealthKit.h>

#import "UIApplication+Helper.h"
#import "UIAlertController+Helper.h"

#import "UIWindow+Helper.h"

#import "NSObject+Helper.h"
#import "UIView+Helper.h"
#import "UIViewController+Helper.h"

#import "BNGloble.h"
#import <YYModel/YYModel.h>
#import <IQKeyboardManager/IQKeyboardManager.h>

//#import <AFNetworking/AFNetworking.h>
//#import "BNNetRootAppInfoModel.h"

@implementation UIApplication (Other)

static NSDictionary *_dictPrivacy = nil;

+ (NSDictionary *)dictPrivacy{
    if (!_dictPrivacy) {
        _dictPrivacy = @{
                         @0 : @"相册",
                         @1 : @"相机",
                         @2 : @"媒体资料库",
                         @3 : @"麦克风",
                         @4 : @"蓝牙",
                         @5 : @"推送",
                         @6 : @"语音识别",
                         @7 : @"日历",
                         @8 : @"提醒事项",
                         @9 : @"通讯录",
                         @10 : @"健康",

                         };
    }
    return _dictPrivacy;
}

+ (void)privacy:(PrivacyType)type completion:(void(^)(BOOL response,PrivacyStatus status, NSString *name))completion{
    NSParameterAssert(completion != nil);
    switch (type) {
        case PrivacyTypePhoto: {
            [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
                if (status == PHAuthorizationStatusAuthorized) {
                    completion(YES,PrivacyStatusAuthorized, UIApplication.dictPrivacy[@(type)]);
                }
                else if (status == PHAuthorizationStatusDenied) {
                    completion(NO,PrivacyStatusDenied,UIApplication.dictPrivacy[@(type)]);
                }
                else if (status == PHAuthorizationStatusNotDetermined) {
                    completion(NO,PrivacyStatusNotDetermined, UIApplication.dictPrivacy[@(type)]);
                }
                else if (status == PHAuthorizationStatusRestricted) {
                    completion(NO,PrivacyStatusRestricted, UIApplication.dictPrivacy[@(type)]);
                }
                else {
                    completion(NO,PrivacyStatusUnkonwn, UIApplication.dictPrivacy[@(type)]);
                }
            }];
        }
            break;
        case PrivacyTypeCamera: {
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
                if (granted) {
                    completion(YES,PrivacyStatusAuthorized, UIApplication.dictPrivacy[@(type)]);
                }
                else {
                    if (status == AVAuthorizationStatusAuthorized) {
                        completion(YES,PrivacyStatusAuthorized, UIApplication.dictPrivacy[@(type)]);
                    }
                    else if (status == AVAuthorizationStatusDenied) {
                        completion(NO,PrivacyStatusDenied, UIApplication.dictPrivacy[@(type)]);
                    }
                    else if (status == AVAuthorizationStatusNotDetermined) {
                        completion(NO,PrivacyStatusNotDetermined, UIApplication.dictPrivacy[@(type)]);
                    }
                    else if (status == AVAuthorizationStatusRestricted) {
                        completion(NO,PrivacyStatusRestricted, UIApplication.dictPrivacy[@(type)]);
                    }
                    else {
                        completion(NO,PrivacyStatusUnkonwn, UIApplication.dictPrivacy[@(type)]);
                    }
                }
            }];
        }
            break;
        case PrivacyTypeMedia: {
            if (@available(iOS 9.3, *)) {
                [MPMediaLibrary requestAuthorization:^(MPMediaLibraryAuthorizationStatus status) {
                    if (status == MPMediaLibraryAuthorizationStatusAuthorized) {
                        completion(YES,PrivacyStatusAuthorized, UIApplication.dictPrivacy[@(type)]);
                    }
                    else if (status == MPMediaLibraryAuthorizationStatusDenied) {
                        completion(NO,PrivacyStatusDenied, UIApplication.dictPrivacy[@(type)]);
                    }
                    else if (status == MPMediaLibraryAuthorizationStatusNotDetermined) {
                        completion(NO,PrivacyStatusNotDetermined, UIApplication.dictPrivacy[@(type)]);
                    }
                    else if (status == MPMediaLibraryAuthorizationStatusRestricted) {
                        completion(NO,PrivacyStatusRestricted, UIApplication.dictPrivacy[@(type)]);
                    }
                    else {
                        completion(NO,PrivacyStatusUnkonwn, UIApplication.dictPrivacy[@(type)]);
                    }
                }];
            } else {
                // Fallback on earlier versions
                //虽然没有查看是否开启权限的接口，但是还是需要在Info.plist中添加说明。
            }
        }
            break;
        case PrivacyTypeMicrophone: {
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeAudio completionHandler:^(BOOL granted) {
                AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeAudio];
                if (granted) {
                    completion(YES,PrivacyStatusAuthorized, UIApplication.dictPrivacy[@(type)]);
                }
                else {
                    if (status == AVAuthorizationStatusAuthorized) {
                        completion(YES,PrivacyStatusAuthorized, UIApplication.dictPrivacy[@(type)]);
                    }
                    else if (status == AVAuthorizationStatusDenied) {
                        completion(NO,PrivacyStatusDenied, UIApplication.dictPrivacy[@(type)]);
                    }
                    else if (status == AVAuthorizationStatusNotDetermined) {
                        completion(NO,PrivacyStatusNotDetermined, UIApplication.dictPrivacy[@(type)]);
                    }
                    else if (status == AVAuthorizationStatusRestricted) {
                        completion(NO,PrivacyStatusRestricted, UIApplication.dictPrivacy[@(type)]);
                    }
                    else {
                        completion(NO,PrivacyStatusUnkonwn, UIApplication.dictPrivacy[@(type)]);
                    }
                }
            }];
        }
            break;
        case PrivacyTypeBluetooth: {
            if (@available(iOS 10.0, *)) {
                CBCentralManager *centralManager = [[CBCentralManager alloc] init];
                CBManagerState state = [centralManager state];
                if (state == CBManagerStateUnsupported || state == CBManagerStateUnauthorized || state == CBManagerStateUnknown) {
                    completion(NO,PrivacyStatusDenied, UIApplication.dictPrivacy[@(type)]);
                }
                else {
                    completion(YES,PrivacyStatusAuthorized, UIApplication.dictPrivacy[@(type)]);
                }
            } else {
                // Fallback on earlier versions
                
            }
            
        }break;
            
        case PrivacyTypePushNotification: {
            if (@available(iOS 10.0, *)) {
                UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
                UNAuthorizationOptions types = UNAuthorizationOptionBadge|UNAuthorizationOptionAlert|UNAuthorizationOptionSound;
                [center requestAuthorizationWithOptions:types completionHandler:^(BOOL granted, NSError * _Nullable error) {
                    if (granted) {
                        [center getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
                            //
                            completion(YES,PrivacyStatusAuthorized, UIApplication.dictPrivacy[@(type)]);
                            
                        }];
                    } else {
                        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{UIApplicationOpenURLOptionUniversalLinksOnly:@""} completionHandler:^(BOOL success) { }];
                    }
                }];
            } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wdeprecated-declarations"
                [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert | UIUserNotificationTypeSound | UIUserNotificationTypeBadge categories:nil]];
            }
#pragma clang diagnostic pop
        }break;
            
        case PrivacyTypeSpeech: {
            if (@available(iOS 10.0, *)) {
                [SFSpeechRecognizer requestAuthorization:^(SFSpeechRecognizerAuthorizationStatus status) {
                    if (status == SFSpeechRecognizerAuthorizationStatusAuthorized) {
                        completion(YES,PrivacyStatusAuthorized, UIApplication.dictPrivacy[@(type)]);
                    }
                    else if (status == SFSpeechRecognizerAuthorizationStatusDenied) {
                        completion(NO,PrivacyStatusDenied, UIApplication.dictPrivacy[@(type)]);
                    }
                    else if (status == SFSpeechRecognizerAuthorizationStatusNotDetermined) {
                        completion(NO,PrivacyStatusNotDetermined, UIApplication.dictPrivacy[@(type)]);
                    }
                    else if (status == SFSpeechRecognizerAuthorizationStatusRestricted) {
                        completion(NO,PrivacyStatusRestricted, UIApplication.dictPrivacy[@(type)]);
                    }
                    else {
                        completion(NO,PrivacyStatusUnkonwn, UIApplication.dictPrivacy[@(type)]);
                    }
                }];
            } else {
                // Fallback on earlier versions
                //不支持
            }
        }
            break;
        case PrivacyTypeEvent: {
            EKEventStore *store = [[EKEventStore alloc] init];
            [store requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError * _Nullable error) {
                EKAuthorizationStatus status = [EKEventStore  authorizationStatusForEntityType:EKEntityTypeEvent];
                if (granted) {
                    completion(YES,PrivacyStatusAuthorized, UIApplication.dictPrivacy[@(type)]);
                }
                else {
                    if (status == EKAuthorizationStatusAuthorized) {
                        completion(YES ,PrivacyStatusAuthorized, UIApplication.dictPrivacy[@(type)]);
                    }
                    else if (status == EKAuthorizationStatusDenied) {
                        completion(NO,PrivacyStatusDenied, UIApplication.dictPrivacy[@(type)]);
                    }
                    else if (status == EKAuthorizationStatusNotDetermined) {
                        completion(NO,PrivacyStatusNotDetermined, UIApplication.dictPrivacy[@(type)]);
                    }
                    else if (status == EKAuthorizationStatusRestricted) {
                        completion(NO,PrivacyStatusRestricted, UIApplication.dictPrivacy[@(type)]);
                    }
                    else {
                        completion(NO,PrivacyStatusUnkonwn, UIApplication.dictPrivacy[@(type)]);
                    }
                }
            }];
        }
            break;
        case PrivacyTypeReminder: {
            EKEventStore *eventStore = [[EKEventStore alloc] init];
            [eventStore requestAccessToEntityType:EKEntityTypeReminder completion:^(BOOL granted, NSError * _Nullable error) {
                EKAuthorizationStatus status = [EKEventStore authorizationStatusForEntityType:EKEntityTypeEvent];
                if (granted) {
                    completion(YES,PrivacyStatusAuthorized, UIApplication.dictPrivacy[@(type)]);
                }
                else {
                    if (status == EKAuthorizationStatusAuthorized) {
                        completion(YES ,PrivacyStatusAuthorized, UIApplication.dictPrivacy[@(type)]);
                    }
                    else if (status == EKAuthorizationStatusDenied) {
                        completion(NO,PrivacyStatusDenied, UIApplication.dictPrivacy[@(type)]);
                    }
                    else if (status == EKAuthorizationStatusNotDetermined){
                        completion(NO,PrivacyStatusNotDetermined, UIApplication.dictPrivacy[@(type)]);
                    }
                    else if (status == EKAuthorizationStatusRestricted){
                        completion(NO,PrivacyStatusRestricted, UIApplication.dictPrivacy[@(type)]);
                    }
                    else{
                        completion(NO,PrivacyStatusUnkonwn, UIApplication.dictPrivacy[@(type)]);
                    }
                }
            }];
        }
            break;
        case PrivacyTypeContact: {
            CNContactStore *contactStore = [[CNContactStore alloc] init];
            [contactStore requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
                CNAuthorizationStatus status = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
                if (granted) {
                    completion(YES,PrivacyStatusAuthorized, UIApplication.dictPrivacy[@(type)]);
                }
                else {
                    if (status == EKAuthorizationStatusAuthorized) {
                        completion(YES ,PrivacyStatusAuthorized, UIApplication.dictPrivacy[@(type)]);
                    }
                    else if (status == CNAuthorizationStatusDenied) {
                        completion(NO,PrivacyStatusDenied, UIApplication.dictPrivacy[@(type)]);
                    }
                    else if (status == CNAuthorizationStatusRestricted){
                        completion(NO,PrivacyStatusNotDetermined, UIApplication.dictPrivacy[@(type)]);
                    }
                    else if (status == CNAuthorizationStatusNotDetermined){
                        completion(NO,PrivacyStatusRestricted, UIApplication.dictPrivacy[@(type)]);
                    }
                    else{
                        completion(NO,PrivacyStatusUnkonwn, UIApplication.dictPrivacy[@(type)]);
                    }
                }
            }];
        }
            break;
        default:
            break;
    }
}

+ (BOOL)privacy:(PrivacyType)type handler:(void(^)(BOOL response, NSString *name))handler{
    __block BOOL isHasRight = NO;
    [UIApplication privacy:type completion:^(BOOL response, PrivacyStatus status, NSString *name) {
        isHasRight = response;
        if(handler) handler(response,name);
        
        switch (status) {
            case PrivacyStatusAuthorized:
            {
                //通过
                
            }
                break;
            case PrivacyStatusDenied:
            case PrivacyStatusNotDetermined:
            case PrivacyStatusRestricted:
            case PrivacyStatusUnkonwn:
            {
                NSString * msg = [NSString stringWithFormat:@"请去-> [设置 - 隐私 - %@ - %@] 打开访问开关",UIApplication.dictPrivacy[@(type)],UIApplication.appName];
                [UIWindow showToastWithTips:msg place:@1];
                
            }
                break;
            default:
                break;
        }
    }];
    return isHasRight;
}


+ (BOOL)hasRightOfPhotosLibrary{
    return [UIApplication privacy:PrivacyTypePhoto handler:nil];
}
+ (BOOL)hasRightOfCameraUsage{
    //相机权限
    return [UIApplication privacy:PrivacyTypeCamera handler:nil];

}

+ (BOOL)hasRightOfAVCapture{
    
    __block BOOL isHasRight = NO;
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (device) {
        AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        switch (status) {
            case AVAuthorizationStatusNotDetermined: {
                [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                    if (granted) {
                        isHasRight = YES;
                        DDLog(@"用户第一次同意了访问相机权限 - - %@", NSThread.currentThread);
                    } else {
                        DDLog(@"用户第一次拒绝了访问相机权限 - - %@", NSThread.currentThread);
                    }
                }];
                break;
            }
            case AVAuthorizationStatusAuthorized: {
                isHasRight = YES;
                break;
            }
            case AVAuthorizationStatusDenied: {
                NSString * msg = [NSString stringWithFormat:@"请去-> [设置 - 隐私 - 相机 - %@] 打开访问开关",UIApplication.appName];
                [UIWindow showToastWithTips:msg place:@1];
                
                break;
            }
            case AVAuthorizationStatusRestricted: {
                NSString * msg = @"因为系统原因, 无法访问相册";
                [UIWindow showToastWithTips:msg place:@1];
                break;
            }
            default:
                break;
        }
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
 添加本地通知,trigger为NSDate/NSDateComponents未来时间点触发,CLCircularRegion进出特定区域触发
 */
+ (void)addLocalUserNotiTrigger:(id)trigger content:(UNMutableNotificationContent *)content identifier:(NSString *)identifier notiCategories:(id)notiCategories handler:(void(^)(UNUserNotificationCenter* center, UNNotificationRequest *request,NSError * _Nullable error))handler API_AVAILABLE(ios(10.0)){
    NSParameterAssert([trigger isKindOfClass: NSDate.class] || [trigger isKindOfClass: NSDateComponents.class] || [trigger isKindOfClass: CLCircularRegion.class]);

    UNNotificationTrigger * notiTrigger = nil;
    if ([trigger isKindOfClass: NSDate.class]) {
        NSTimeInterval interval = ((NSDate *)trigger).timeIntervalSince1970 - NSDate.date.timeIntervalSince1970;
        DDLog(@"_%@_",@(interval));
        interval = interval < 0 ? 1 : interval;
        
        UNTimeIntervalNotificationTrigger *timeTrigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:interval repeats:NO];
        notiTrigger = timeTrigger;
        
    }
    else if ([trigger isKindOfClass: NSDateComponents.class]){
        // 创建日期组建
        //        NSDateComponents *components = [[NSDateComponents alloc] init];
        //        components.weekday = 4;
        //        components.hour = 10;
        //        components.minute = 12;
        UNCalendarNotificationTrigger *calendarTrigger = [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:trigger repeats:YES];
        notiTrigger = calendarTrigger;
        
    }
    else if ([trigger isKindOfClass: CLCircularRegion.class]){
        //        CLLocationCoordinate2D center = CLLocationCoordinate2DMake(39.788857, 116.5559392);
        //        CLCircularRegion *region = [[CLCircularRegion alloc] initWithCenter:center1 radius:500 identifier:@"经海五路"];
        //        region.notifyOnEntry = YES;
        //        region.notifyOnExit = YES
        UNLocationNotificationTrigger *locationTrigger = [UNLocationNotificationTrigger triggerWithRegion:trigger repeats:YES];
        notiTrigger = locationTrigger;
        
    }
    
    // 创建通知请求 UNNotificationRequest 将触发条件和通知内容添加到请求中
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:identifier content:content trigger:notiTrigger];
    
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    [center setNotificationCategories:[UIApplication notiCategories:notiCategories identifier:@"locationCategory"]];
    // 将通知请求 add 到 UNUserNotificationCenter
    
    __weak typeof(center) weakCenter = center;
    [center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        __strong typeof(weakCenter) strongCenter = weakCenter;
        handler(strongCenter,request,error);
        if (!error) {
            DDLog(@"推送已添加成功 %@", identifier);
            //你自己的需求例如下面：
//            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"本地通知" message:@"成功添加推送" preferredStyle:UIAlertControllerStyleAlert];
//            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
//            [alert addAction:cancelAction];
//            [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
//此处省略一万行需求。。。。
            
        }
    }];
}

/**
 UNNotificationCategory
 */
+ (NSSet *)notiCategories:(id)obj identifier:(NSString *)identifier API_AVAILABLE(ios(10.0)){
    if (obj == nil) {
        return [NSSet set];
    }
    
    NSParameterAssert([obj isKindOfClass: UNTextInputNotificationAction.class] || [obj isKindOfClass: NSArray.class]);
    UNNotificationCategory *notiCategory = nil;
    if ([obj isKindOfClass: UNTextInputNotificationAction.class]) {
        notiCategory = [UNNotificationCategory categoryWithIdentifier:identifier actions:@[obj] intentIdentifiers:@[] options:UNNotificationCategoryOptionCustomDismissAction];
        
    }
    else{
        if ([obj isKindOfClass: NSArray.class]) {
            NSArray * actions = [UIApplication actionsBylist:obj];
            notiCategory = [UNNotificationCategory categoryWithIdentifier:identifier actions:actions intentIdentifiers:@[] options:UNNotificationCategoryOptionCustomDismissAction];
            
        }
    }
    // 注册 category
    // * identifier 标识符
    // * actions 操作数组
    // * intentIdentifiers 意图标识符 可在 <Intents/INIntentIdentifiers.h> 中查看，主要是针对电话、carplay 等开放的 API。
    // * options 通知选项 枚举类型 也是为了支持 carplay
    
    // 将 category 添加到通知中心
    //    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    //    [center setNotificationCategories:[NSSet setWithObject:notiCategory]];
    return [NSSet setWithObject:notiCategory];
}


/**
  list 包含 0,actionid;1,title;2,UNNotificationActionOptions
 */
+ (NSArray *)actionsBylist:(NSArray *)list API_AVAILABLE(ios(10.0)){
    NSMutableArray * marr = [NSMutableArray array];
    
    for (NSArray * array in list) {
        //        array包含 0,actionid;1,title;2,UNNotificationActionOptions
        UNNotificationAction *action = [UNNotificationAction actionWithIdentifier:[array firstObject] title:array[1] options:[array[2] integerValue]];
        [marr addObject:action];
        
    }
    return marr;
}

/**
 ios10之前本地通知创建
 */
+ (void)addLocalNotification{
    /*
     ios8以上版本需要在appdelegate中注册申请权限 本地通知在软件杀死状态也可以接收到消息
     */
    
    // 1.创建本地通知
    UILocalNotification *localNote = [[UILocalNotification alloc] init];
    // 2.设置本地通知(发送的时间和内容是必须设置的)
    localNote.fireDate = [NSDate dateWithTimeIntervalSinceNow:3.0];
    localNote.alertBody = @"吃饭了么?";
    
    /**
     其他属性: timeZone 时区
     repeatInterval 多长时间重复一次:一年,一个世纪,一天..
     region 区域 : 传入中心点和半径就可以设置一个区域 (如果进入这个区域或者出来这个区域就发出一个通知)
     regionTriggersOnce  BOOL 默认为YES, 如果进入这个区域或者出来这个区域 只会发出 一次 通知,以后就不发送了
     alertAction: 设置锁屏状态下本地通知下面的 滑动来 ...字样  默认为滑动来查看
     hasAction: alertAction的属性是否生效
     alertLaunchImage: 点击通知进入app的过程中显示图片,随便写,如果设置了(不管设置的是什么),都会加载app默认的启动图
     alertTitle: 以前项目名称所在的位置的文字: 不设置显示项目名称, 在通知内容上方
     soundName: 有通知时的音效 UILocalNotificationDefaultSoundName默认声音
     可以更改这个声音: 只要将音效导入到工程中,localNote.soundName = @"nihao.waw"
     */
    
    localNote.alertAction = @"快点啊"; // 锁屏状态下显示: 滑动来快点啊
    //    localNote.alertLaunchImage = @"123";
    localNote.alertTitle = @"东方_未明";
    localNote.soundName = UILocalNotificationDefaultSoundName;
    localNote.soundName = @"nihao.waw";
    
    /* 这里接到本地通知,badge变为5, 如果打开app,消除掉badge, 则在appdelegate中实现
     [application setApplicationIconBadgeNumber:0];
     */
    localNote.applicationIconBadgeNumber = 5;
    
    // 设置额外信息,appdelegate中收到通知,可以根据不同的通知的额外信息确定跳转到不同的界面
    localNote.userInfo = @{@"type":@1};
    
    // 3.调用通知
    [UIApplication.sharedApplication scheduleLocalNotification:localNote];
    
}

//+ (void)registerShareSDK{
//    /**初始化ShareSDK应用
//     @param activePlatforms
//     使用的分享平台集合
//     @param importHandler (onImport)
//     导入回调处理，当某个平台的功能需要依赖原平台提供的SDK支持时，需要在此方法中对原平台SDK进行导入操作
//     @param configurationHandler (onConfiguration)
//     配置回调处理，在此方法中根据设置的platformType来填充应用配置信息
//     */
//    [ShareSDK registerActivePlatforms:@[
//                                        @(SSDKPlatformTypeQQ),
//                                        @(SSDKPlatformTypeWechat),
//                                        ]
//                             onImport:^(SSDKPlatformType platformType)
//     {
//         switch (platformType)
//         {
//             case SSDKPlatformTypeQQ:
//                 [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
//                 break;
//             case SSDKPlatformTypeWechat:
////                 [ShareSDKConnector connectWeChat:[WXApi class]];
//                 break;
//             default:
//                 break;
//         }
//     }
//                      onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo)
//     {
//         switch (platformType)
//         {
//             case SSDKPlatformTypeQQ:
//                 [appInfo SSDKSetupQQByAppId:kAppID_QQ
//                                      appKey:kAppKey_QQ
//                                    authType:SSDKAuthTypeBoth];
//                 break;
//             case SSDKPlatformTypeWechat:
//                 [appInfo SSDKSetupWeChatByAppId:kAppID_WX
//                                       appSecret:kAppKey_WX];
//                 break;
//             default:
//                 break;
//         }
//     }];
//
//}
//
//+ (void)handleMsgShareDataModel:(BNShareModel *)dataModel type:(NSNumber *)type{
//
//    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
//    [shareParams SSDKSetupShareParamsByText:dataModel.shareContent
//                                     images:dataModel.shareImages //传入要分享的图片
//                                        url:[NSURL URLWithString:dataModel.shareUrl]
//                                      title:dataModel.shareTitle
//                                       type:SSDKContentTypeAuto];
//
//    SSDKPlatformType thePlatformType = SSDKPlatformSubTypeQZone;
//    switch (type.integerValue) {
//        case 0:
//        {
//            thePlatformType = SSDKPlatformSubTypeQZone;
//        }
//            break;
//        case 1:
//        {
//            thePlatformType = SSDKPlatformSubTypeWechatSession;
//
//        }
//            break;
//        case 2:
//        {
//            thePlatformType = SSDKPlatformSubTypeWechatTimeline;
//
//        }
//            break;
//        case 3:
//        {
//            thePlatformType = SSDKPlatformSubTypeQQFriend;
//
//        }
//            break;
//        default:
//            break;
//    }
//
//    //进行分享
//    [ShareSDK share:thePlatformType//传入分享的平台类型
//         parameters:shareParams
//     onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) { /* 回调处理....*/
//
//         DDLog(@"error_%ld",(NSInteger)state);
//
//         NSString * tipMsg = @"";
//         switch (state) {
//             case SSDKResponseStateSuccess:
//             {
//                 tipMsg = @"分享成功";
//                 DDLog(@"分享成功!");
//
//             }
//                 break;
//             case SSDKResponseStateFail:
//             {
//                 tipMsg = @"分享失败";
//                 DDLog(@"分享失败%@",error);
//             }
//                 break;
//             case SSDKResponseStateCancel:
//             {
//                 tipMsg = @"分享已取消";
//                 DDLog(@"分享已取消");
//             }
//                 break;
//             default:
//                 break;
//         }
//
//         UIAlertController * alertCtl = [UIAlertController alertControllerWithTitle:tipMsg message:nil  preferredStyle:UIAlertControllerStyleAlert];
//         [alertCtl addAction:[UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//
//         }]];
//         [UIApplication.rootController presentViewController:alertCtl animated:YES completion:nil];
//     }];
//}

//+ (void)registerUMengSDKAppKey:(NSString *)appKey channel:(NSString *)channel{
//
//    [MobClick setLogEnabled:YES];
//
//    UMConfigInstance.appKey = appKey;
//    UMConfigInstance.channelId = channel;
//
//    [MobClick startWithConfigure:UMConfigInstance];//配置以上参数后调用此方法初始化SDK！
//    [MobClick setCrashCBBlock:^{
//        DDLog(@"--------setCrashCBBlock---------------");
//    }];
//    //    [MobClick setLogEnabled:NO];
//}

+ (NSString *)appUrlWithID:(NSString *)appStoreID {
    NSString * urlString = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/app/id%@?mt=8", appStoreID];
    return urlString;
}

+ (NSString *)appDetailUrlWithID:(NSString *)appStoreID {
    NSString * urlString = [NSString stringWithFormat:@"http://itunes.apple.com/cn/lookup?id=%@", appStoreID];
    return urlString;
}

+ (BOOL)checkVersion:(NSString *)appStoreID {

    __block BOOL isUpdate = NO;
    
    NSString *path = [UIApplication appDetailUrlWithID:appStoreID];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:path] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:6];
    request.HTTPMethod = @"POST";
    
    NSURLSessionDataTask *dataTask = [NSURLSession.sharedSession dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            if ([dic[@"resultCount"] isEqualToNumber:@1]) {
                
                NSDictionary * dicInfo = [dic[@"results"] firstObject];
                
                NSString * appStoreVer = dicInfo[@"version"];
                NSString * releaseNotes = dicInfo[@"releaseNotes"];
//            NSString *trackViewUrl = dataModel.trackViewUrl;// appStore 跳转版本链接
                
                isUpdate = [appStoreVer compare:UIApplication.appVer options:NSNumericSearch] == NSOrderedDescending;
                if (isUpdate == true) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        NSString * versionInfo = [NSString stringWithFormat:@"新版本V%@!",appStoreVer];
                        // AppStore版本号大于当前版本号，强制更新
                        // 弹窗 更新
                        UIAlertController * alertController = [UIAlertController showAlertTitle:versionInfo msg:releaseNotes placeholders:nil actionTitles:@[kActionTitle_Call,kActionTitle_Update] handler:^(UIAlertController * _Nonnull alertVC, UIAlertAction * _Nonnull action) {
                            if ([action.title isEqualToString:kActionTitle_Update]) {
                                // 升级去
                                [UIApplication openURL: [UIApplication appUrlWithID:appStoreID]];
                                
                            }
                        }];
                
                        NSMutableParagraphStyle * paraStyle = [NSMutableParagraphStyle createBreakModel: NSLineBreakByCharWrapping alignment: NSTextAlignmentLeft lineSpacing: 5.0];
                        [alertController setTitleColor: UIColor.themeColor];
                        [alertController setMessageParaStyle:paraStyle];
                    });
                }
            }
        }
    }];
    [dataTask resume];
    return isUpdate;
}

//- (BOOL)updateVersion {
//    __block BOOL isUpdate = NO;
//
//    // 获取本地版本号
//    NSString *currentVersion = NSBundle.mainBundle.infoDictionary[@"CFBundleShortVersionString"]; // 就是在info.plist里面的 version
//    // 取得AppStore信息
//    NSString *url = [NSString stringWithFormat:@"http://itunes.apple.com/cn/lookup?id=%@", kID_AppStoreConnect];
//
//
//    AFHTTPSessionManager *manager = AFHTTPSessionManager.manager;
//    manager.requestSerializer = AFJSONRequestSerializer.serializer;
//    manager.responseSerializer = AFJSONResponseSerializer.serializer;
//    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
////        NSLog(@"responseObject --- %@", responseObject);
////        NSString * json = [responseObject JSONValue];
//
//        dispatch_async(dispatch_get_global_queue(0, 0), ^{
//
//            BNNetRootAppInfoModel * rootModel = [BNNetRootAppInfoModel yy_modelWithJSON:responseObject];
//            BNNetResultsAppInfoModel * dataModel = rootModel.results.firstObject;
//
//            NSString * appStoreVersion = dataModel.version;// appStore 最新版本号
//            NSString *releaseNotes = dataModel.releaseNotes;// 取更新日志信息
////            NSString *trackViewUrl = dataModel.trackViewUrl;// appStore 跳转版本链接
//
//            dispatch_async(dispatch_get_main_queue(), ^{
//                NSString * versionInfo = [NSString stringWithFormat:@"新版本V%@!",appStoreVersion];
//                // AppStore版本号大于当前版本号，强制更新
//                if ([appStoreVersion compare:currentVersion options:NSNumericSearch] == NSOrderedDescending) {
//                    // 弹窗 更新
//                    [UIApplication.rootController createAlertTitle:versionInfo msg:releaseNotes actionTitleList:@[kActionTitle_Call,kActionTitle_Update] handler:^(UIAlertController * _Nonnull alertVC, UIAlertAction * _Nullable action) {
//                        isUpdate = [action.title isEqualToString:kActionTitle_Update]  ? YES : NO;
//                        if (isUpdate) {
//                            // 升级去
//
//                        }
//                    }];
//                }
//            });
//        });
//
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        // 网络异常时，正常进入程序
//
//    }];
//    return isUpdate;
//
//}

@end


@implementation BNShareModel

@end


