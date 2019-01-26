//
//  UIAlertController+Helper.m
//  ProductTemplet
//
//  Created by Bin Shang on 2019/1/17.
//  Copyright © 2019 BN. All rights reserved.
//

#import "UIAlertController+Helper.h"
#import "BNGloble.h"

@implementation UIAlertController (Helper)

+ (instancetype)createAlertTitle:(NSString * _Nullable)title msg:(NSString *_Nullable)msg placeholders:(NSArray *_Nullable)placeholders actionTitles:(NSArray *_Nullable)actionTitles handler:(void(^)(UIAlertController * _Nonnull alertVC, UIAlertAction * _Nonnull action))handler{
    
    UIWindow * keyWindow = UIApplication.sharedApplication.delegate.window;
    
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
    for (NSString * placeholder in placeholders) {
        [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.placeholder = placeholder;
            textField.textAlignment = NSTextAlignmentCenter;
            
        }];
    }
        
    for (NSString *title in actionTitles) {
        UIAlertActionStyle style = [title isEqualToString:kActionTitle_Cancell] == true? UIAlertActionStyleDestructive : UIAlertActionStyleDefault;
        [alertController addAction:[UIAlertAction actionWithTitle:title style:style handler:^(UIAlertAction * _Nonnull action) {
            if (handler) handler(alertController,action);
            
        }]];
    }
    
    if (![actionTitles containsObject:kActionTitle_Cancell]) {
        [alertController addAction:[UIAlertAction actionWithTitle:kActionTitle_Cancell style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            if (handler) handler(alertController,action);
            
        }]];
    }
    
    [keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
    return alertController;
}

+ (void)showAlertTitle:(NSString * _Nullable)title msg:(NSString *_Nullable)msg placeholders:(NSArray *_Nullable)placeholders actionTitles:(NSArray *_Nullable)actionTitles handler:(void(^)(UIAlertController * _Nonnull alertVC, UIAlertAction * _Nonnull action))handler{
    UIWindow * keyWindow = UIApplication.sharedApplication.delegate.window;

    UIAlertController * alertController = [UIAlertController createAlertTitle:title msg:msg placeholders:placeholders actionTitles:actionTitles handler:handler];
    if (actionTitles.count == 0) {
        [keyWindow.rootViewController presentViewController:alertController animated:YES completion:^{
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(kDurationToast * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [alertController dismissViewControllerAnimated:true completion:nil];
            });
            
        }];
        return ;
    }
    [keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
}

+ (instancetype)createSheetTitle:(NSString *_Nullable)title msg:(NSString *_Nullable)msg actionTitles:(NSArray *_Nullable)actionTitles handler:(void(^)(UIAlertController * _Nonnull alertVC, UIAlertAction * _Nonnull action))handler{
    
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleActionSheet];
    
    for (NSString *title in actionTitles) {
        UIAlertActionStyle style = [title isEqualToString:kActionTitle_Cancell] == true? UIAlertActionStyleDestructive : UIAlertActionStyleDefault;
        [alertController addAction:[UIAlertAction actionWithTitle:title style:style handler:^(UIAlertAction * _Nonnull action) {
            if (handler) handler(alertController,action);
            
        }]];
    }
    
    if (![actionTitles containsObject:kActionTitle_Cancell]) {
        [alertController addAction:[UIAlertAction actionWithTitle:kActionTitle_Cancell style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            if (handler) handler(alertController,action);
            
        }]];
    }
    return alertController;
}

+ (void)showSheetTitle:(NSString *_Nullable)title msg:(NSString *_Nullable)msg actionTitles:(NSArray *_Nullable)actionTitles handler:(void(^)(UIAlertController * _Nonnull alertVC, UIAlertAction * _Nonnull action))handler{
    UIAlertController * alertController = [UIAlertController createSheetTitle:title msg:msg actionTitles:actionTitles handler:handler];
    
    UIWindow * keyWindow = UIApplication.sharedApplication.delegate.window;
    [keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];//懒加载会崩溃
}

@end
