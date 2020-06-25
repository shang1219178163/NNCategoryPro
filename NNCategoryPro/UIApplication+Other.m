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
#import <UserNotifications/UserNotifications.h>
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
            [UIAlertController showAlertTitle:@"提示" msg:msg actionTitles:@[kTitleKnow] handler:nil];
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
        NSString * msg = [NSString stringWithFormat:@"请去-> [设置 - 隐私 - %@ - %@] 打开访问开关", @"相机" , UIApplication.appName];
        [UIAlertController showAlertTitle:@"提示" msg:msg actionTitles:@[kTitleKnow] handler:nil];
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
            NSString * msg = [NSString stringWithFormat:@"请去-> [设置 - 隐私 - 相机 - %@] 打开访问开关",UIApplication.appName];
            [UIAlertController showAlertTitle:@"提示" msg:msg actionTitles:@[kTitleKnow] handler:nil];
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
 iOS10添加本地通知,trigger为NSDate/NSDateComponents未来时间点触发,CLCircularRegion进出特定区域触发
 */
+ (void)addLocalUserNotiTrigger:(id)trigger
                        content:(UNMutableNotificationContent *)content
                     identifier:(NSString *)identifier
                 notiCategories:(id)notiCategories
                        repeats:(BOOL)repeats
                        handler:(void(^)(UNUserNotificationCenter* center, UNNotificationRequest *request, NSError * _Nullable error))handler API_AVAILABLE(ios(10.0)){
    NSParameterAssert([trigger isKindOfClass: NSDate.class] || [trigger isKindOfClass: NSDateComponents.class] || [trigger isKindOfClass: CLCircularRegion.class]);

    UNNotificationTrigger * notiTrigger = nil;
    if ([trigger isKindOfClass: NSDate.class]) {
        NSTimeInterval interval = ((NSDate *)trigger).timeIntervalSince1970 - NSDate.date.timeIntervalSince1970;
        DDLog(@"_%@_",@(interval));
        interval = interval < 0 ? 1 : interval;
        
        UNTimeIntervalNotificationTrigger *timeTrigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:interval repeats:repeats];
        notiTrigger = timeTrigger;
        
    }
    else if ([trigger isKindOfClass: NSDateComponents.class]){
        // 创建日期组建
        //        NSDateComponents *components = [[NSDateComponents alloc] init];
        //        components.weekday = 4;
        //        components.hour = 10;
        //        components.minute = 12;
        UNCalendarNotificationTrigger *calendarTrigger = [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:trigger repeats:repeats];
        notiTrigger = calendarTrigger;
        
    }
    else if ([trigger isKindOfClass: CLCircularRegion.class]){
        //        CLLocationCoordinate2D center = CLLocationCoordinate2DMake(39.788857, 116.5559392);
        //        CLCircularRegion *region = [[CLCircularRegion alloc] initWithCenter:center1 radius:500 identifier:@"经海五路"];
        //        region.notifyOnEntry = YES;
        //        region.notifyOnExit = YES
        UNLocationNotificationTrigger *locationTrigger = [UNLocationNotificationTrigger triggerWithRegion:trigger repeats:repeats];
        notiTrigger = locationTrigger;
        
    }
    
    // 创建通知请求 UNNotificationRequest 将触发条件和通知内容添加到请求中
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:identifier content:content trigger:notiTrigger];
    
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    [center setNotificationCategories:[UIApplication notiCategories:notiCategories identifier:@"locationCategory"]];
    // 将通知请求 add 到 UNUserNotificationCenter
    
    @weakify(center);
    [center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        @strongify(center);
        handler(center, request, error);
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
 iOS10添加本地通知
 */
+ (void)addLocalNoti:(NSString *)title
                                      body:(NSString *)body
                                  userInfo:(NSDictionary *)userInfo
                                identifier:(NSString *)identifier
                                   handler:(void(^)(UNUserNotificationCenter* center, UNNotificationRequest *request, NSError * _Nullable error))handler API_AVAILABLE(ios(10.0)){
    if (UIApplication.sharedApplication.currentUserNotificationSettings.types == UIUserNotificationTypeNone) {
#ifdef DEBUG
        NSLog(@"请在[设置]-[通知]中打开推送功能");
#endif
        return;
    }
  
    UNUserNotificationCenter *center = UNUserNotificationCenter.currentNotificationCenter;
    
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
    content.sound = UNNotificationSound.defaultSound;
    content.title = title;
    content.body = body;
    content.userInfo = userInfo;
    
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:identifier content:content trigger:nil];
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

/**
 iOS8-9添加本地通知
 */
+ (UILocalNotification *)addLocalNoti:(NSString *)title body:(NSString *)body userInfo:(NSDictionary *)userInfo fireDate:(NSDate *)fireDate repeatInterval:(NSCalendarUnit)repeatInterval region:(CLRegion *)region{
    if (UIApplication.sharedApplication.currentUserNotificationSettings.types == UIUserNotificationTypeNone) {
#ifdef DEBUG
        NSLog(@"请在[设置]-[通知]中打开推送功能");
#endif
        return nil;
    }
    // 1.创建本地通知
    UILocalNotification *localNote = [[UILocalNotification alloc] init];
    localNote.soundName = UILocalNotificationDefaultSoundName;
    // 2.设置本地通知(发送的时间和内容是必须设置的)
    localNote.fireDate = fireDate;
    localNote.repeatInterval = repeatInterval;
    localNote.region = region;

    localNote.alertTitle = title;
    localNote.alertBody = body;
    localNote.alertAction = title; // 锁屏状态下显示: 滑动来快点啊
    
    localNote.applicationIconBadgeNumber += 1;
    localNote.userInfo = userInfo;
    // 3.调用通知
    [UIApplication.sharedApplication scheduleLocalNotification:localNote];
    return localNote;
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
//+ (void)handleMsgShareDataModel:(NNShareModel *)dataModel type:(NSNumber *)type{
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
                
                NSDictionary *dicInfo = [dic[@"results"] firstObject];
                
                NSString *appStoreVer = dicInfo[@"version"];
                NSString *releaseNotes = dicInfo[@"releaseNotes"];
//            NSString *trackViewUrl = dataModel.trackViewUrl;// appStore 跳转版本链接
                
                isUpdate = [appStoreVer compare:UIApplication.appVer options:NSNumericSearch] == NSOrderedDescending;
                if (isUpdate == true) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        NSString * versionInfo = [NSString stringWithFormat:@"新版本V%@!",appStoreVer];
                        // AppStore版本号大于当前版本号，强制更新
                        // 弹窗 更新
                        UIAlertController *alertController = [UIAlertController showAlertTitle:versionInfo msg:releaseNotes placeholders:nil actionTitles:@[kTitleCall,kTitleUpdate] handler:^(UIAlertController * _Nonnull alertVC, UIAlertAction * _Nonnull action) {
                            if ([action.title isEqualToString:kTitleUpdate]) {
                                // 升级去
                                [UIApplication openURLStr: [UIApplication appUrlWithID:appStoreID] prefix:@"http://"];
                                
                            }
                        }];
                
                        // 富文本效果
                        NSMutableParagraphStyle * style = [[NSMutableParagraphStyle alloc]init];
                        style.lineBreakMode = NSLineBreakByCharWrapping;
                        style.alignment = NSTextAlignmentLeft;
                        style.lineSpacing = 5;
                        
                        [alertController setTitleColor: UIColor.themeColor];
                        [alertController setMessageParaStyle:style];
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
////        NSString * json = [responseObject jsonString];
//
//        dispatch_async(dispatch_get_global_queue(0, 0), ^{
//
//            NNRootAppInfoModel * rootModel = [NNRootAppInfoModel yy_modelWithJSON:responseObject];
//            NNResultsAppInfoModel * dataModel = rootModel.results.firstObject;
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
//                    [UIApplication.rootController createAlertTitle:versionInfo msg:releaseNotes actionTitleList:@[kTitleCall,kTitleUpdate] handler:^(UIAlertController * _Nonnull alertVC, UIAlertAction * _Nullable action) {
//                        isUpdate = [action.title isEqualToString:kTitleUpdate]  ? YES : NO;
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


@implementation NNShareModel

@end


