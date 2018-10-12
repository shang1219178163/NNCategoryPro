//
//  UIApplication+Other.m
//  HuiZhuBang
//
//  Created by BIN on 2018/9/18.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//

#import "UIApplication+Other.h"

//#import <ShareSDK/ShareSDK.h>
//#import <ShareSDKConnector/ShareSDKConnector.h>
//腾讯开放平台（对应QQ和QQ空间）SDK头文件
//#import <TencentOpenAPI/TencentOAuth.h>
//#import <TencentOpenAPI/QQApiInterface.h>
//微信SDK头文件
//#import "WXApi.h"
//新浪微博SDK头文件
//#import “WeiboSDK.h”
//新浪微博SDK需要在项目Build Settings中的Other Linker Flags添加”-ObjC”
//#import "UMMobClick/MobClick.h"


#import <Photos/Photos.h>

#import "UIApplication+Helper.h"
#import "UIWindow+Helper.h"

#import "NSObject+Helper.h"
#import "UIView+Helper.h"
#import "UIViewController+Helper.h"

#import "BN_Globle.h"
#import <YYModel/YYModel.h>

//#import <AFNetworking/AFNetworking.h>
//#import "BN_NetRootAppInfoModel.h"

@implementation UIApplication (Other)

+ (BOOL)hasRightOfPhotosLibrary{
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if (status == PHAuthorizationStatusRestricted ||
        status == PHAuthorizationStatusDenied) {
        //无权限
        return NO;
    }
    return YES;
}
+ (BOOL)hasRightOfCameraUsage{
    //相机权限
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus ==AVAuthorizationStatusRestricted ||//此应用程序没有被授权访问的照片数据。可能是家长控制权限
        authStatus ==AVAuthorizationStatusDenied)  //用户已经明确否认了这一照片数据的应用程序访问
    {
        return NO;
        
    }
    return YES;
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
                        DDLog(@"用户第一次同意了访问相机权限 - - %@", [NSThread currentThread]);
                    } else {
                        DDLog(@"用户第一次拒绝了访问相机权限 - - %@", [NSThread currentThread]);
                    }
                }];
                break;
            }
            case AVAuthorizationStatusAuthorized: {
                isHasRight = YES;
                break;
            }
            case AVAuthorizationStatusDenied: {
                NSString * msg = [NSString stringWithFormat:@"请去-> [设置 - 隐私 - 相机 - %@] 打开访问开关",UIApplication.app_Name];
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
//+ (void)handleMsgShareDataModel:(BN_ShareModel *)dataModel patternType:(NSString *)patternType{
//
//    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
//    [shareParams SSDKSetupShareParamsByText:dataModel.shareContent
//                                     images:dataModel.shareImages //传入要分享的图片
//                                        url:[NSURL URLWithString:dataModel.shareUrl]
//                                      title:dataModel.shareTitle
//                                       type:SSDKContentTypeAuto];
//
//    SSDKPlatformType thePlatformType = SSDKPlatformSubTypeQZone;
//    switch ([patternType integerValue]) {
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

//+ (void)setupIQKeyboardManager{
//    IQKeyboardManager *keyboardManager = [IQKeyboardManager sharedManager]; // 获取类库的单例变量
//    keyboardManager.enable = YES; // 控制整个功能是否启用
//    keyboardManager.shouldResignOnTouchOutside = YES; // 控制点击背景是否收起键盘
//    keyboardManager.shouldToolbarUsesTextFieldTintColor = YES; // 控制键盘上的工具条文字颜色是否用户自定义
//    keyboardManager.toolbarManageBehaviour = IQAutoToolbarBySubviews; // 有多个输入框时，可以通过点击Toolbar 上的“前一个”“后一个”按钮来实现移动到不同的输入框
//    keyboardManager.enableAutoToolbar = NO; // 控制是否显示键盘上的工具条
//    keyboardManager.shouldShowToolbarPlaceholder = YES; // 是否显示占位文字
//    keyboardManager.placeholderFont = [UIFont boldSystemFontOfSize:14]; // 设置占位文字的字体
//    keyboardManager.keyboardDistanceFromTextField = 10.0f; // 输入框距离键盘的距离
//    
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

- (BOOL)checkVersion {
    __block BOOL isUpdate = NO;
    
    NSString *path = [NSString stringWithFormat:@"http://itunes.apple.com/cn/lookup?id=%@",kID_AppStoreConnect];    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:path] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10];
    request.HTTPMethod = @"POST";
    
    NSURLSessionDataTask *dataTask = [NSURLSession.sharedSession dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            if ([dic[@"resultCount"] isEqualToNumber:@1]) {
                
                NSDictionary * dicInfo = [dic[@"results"] firstObject];
                
                NSString * appStoreVersion = dicInfo[@"version"];
                NSString * releaseNotes = dicInfo[@"releaseNotes"];
//            NSString *trackViewUrl = dataModel.trackViewUrl;// appStore 跳转版本链接

                NSString *currentVersion = NSBundle.mainBundle.infoDictionary[@"CFBundleShortVersionString"]; // 就是在info.plist里面的 version
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSString * versionInfo = [NSString stringWithFormat:@"新版本V%@!",appStoreVersion];
                    // AppStore版本号大于当前版本号，强制更新
                    if ([appStoreVersion compare:currentVersion options:NSNumericSearch] == NSOrderedDescending) {
                        // 弹窗 更新
                        [UIApplication.rootController showAlertWithTitle:versionInfo msg:releaseNotes actionTitleList:@[kActionTitle_Call,kActionTitle_Update] handler:^(UIAlertController * _Nonnull alertVC, UIAlertAction * _Nullable action) {
                            isUpdate = [action.title isEqualToString:kActionTitle_Update] == YES ? YES : NO;
                            if (isUpdate == YES) {
                                // 升级去
                                
                            }
                        }];
                    }
                });
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
//            BN_NetRootAppInfoModel * rootModel = [BN_NetRootAppInfoModel yy_modelWithJSON:responseObject];
//            BN_NetResultsAppInfoModel * dataModel = rootModel.results.firstObject;
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
//                    [UIApplication.rootController showAlertWithTitle:versionInfo msg:releaseNotes actionTitleList:@[kActionTitle_Call,kActionTitle_Update] handler:^(UIAlertController * _Nonnull alertVC, UIAlertAction * _Nullable action) {
//                        isUpdate = [action.title isEqualToString:kActionTitle_Update] == YES ? YES : NO;
//                        if (isUpdate == YES) {
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


@implementation BN_ShareModel

@end


