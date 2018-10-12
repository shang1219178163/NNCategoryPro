//
//  UIApplication+Other.h
//  HuiZhuBang
//
//  Created by BIN on 2018/9/18.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BN_ShareModel;

@interface UIApplication (Other)

+ (BOOL)hasRightOfPhotosLibrary;

+ (BOOL)hasRightOfCameraUsage;

+ (BOOL)hasRightOfAVCapture;

//+ (void)registerShareSDK;
//+ (void)handleMsgShareDataModel:(BN_ShareModel *)dataModel patternType:(NSString *)patternType;
//+ (void)setupIQKeyboardManager;
//+ (void)registerUMengSDKAppKey:(NSString *_Nonnull)appKey channel:(NSString *_Nonnull)channel;

- (BOOL)checkVersion;
    
//- (BOOL)updateVersion;

@end


@interface BN_ShareModel : NSObject

@property (nonatomic, copy) NSString * shareTitle;
@property (nonatomic, copy) NSString * shareDate;
@property (nonatomic, copy) NSString * shareDesc;
@property (nonatomic, copy) NSString * shareContent;
@property (nonatomic, copy) NSString * shareFrom;
@property (nonatomic, copy) NSArray * shareImages;

@property (nonatomic, copy) NSString * shareUrl;

@end

