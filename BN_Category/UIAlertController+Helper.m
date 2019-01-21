//
//  UIAlertController+Helper.m
//  ProductTemplet
//
//  Created by Bin Shang on 2019/1/17.
//  Copyright © 2019 BN. All rights reserved.
//

#import "UIAlertController+Helper.h"
#import "BN_Globle.h"

@implementation UIAlertController (Helper)

+ (instancetype)showAlertTitle:(NSString * _Nullable)title msg:(NSString *_Nullable)msg placeholders:(NSArray *_Nullable)placeholders actionTitles:(NSArray *_Nullable)actionTitles handler:(void(^)(UIAlertController * _Nonnull alertVC, UIAlertAction * _Nonnull action))handler{
    
    UIWindow * keyWindow = UIApplication.sharedApplication.delegate.window;
    
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
    for (NSString * placeholder in placeholders) {
        [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.placeholder = placeholder;
            textField.textAlignment = NSTextAlignmentCenter;
            
        }];
    }
    
    if (actionTitles.count == 0) {
        [keyWindow.rootViewController presentViewController:alertController animated:YES completion:^{
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(kAnimDuration_Toast * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [alertController dismissViewControllerAnimated:true completion:nil];
            });
            
        }];
        return alertController;
    }
    
    for (NSString *title in actionTitles) {
        UIAlertActionStyle style = [title isEqualToString:kActionTitle_Cancell] == true? UIAlertActionStyleDestructive : UIAlertActionStyleDefault;
        [alertController addAction:[UIAlertAction actionWithTitle:title style:style handler:^(UIAlertAction * _Nonnull action) {
            if (handler) handler(alertController,action);
            
        }]];
    }
    [keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
    return alertController;
}

+ (instancetype)showSheetTitle:(NSString *_Nullable)title msg:(NSString *_Nullable)msg actionTitles:(NSArray *_Nonnull)actionTitles handler:(void(^)(UIAlertController * _Nonnull alertVC, UIAlertAction * _Nonnull action))handler{
    
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleActionSheet];
    
    for (NSString *title in actionTitles) {
        UIAlertActionStyle style = [title isEqualToString:kActionTitle_Cancell] == true? UIAlertActionStyleDestructive : UIAlertActionStyleDefault;
        [alertController addAction:[UIAlertAction actionWithTitle:title style:style handler:^(UIAlertAction * _Nonnull action) {
            if (handler) handler(alertController,action);
            
        }]];
    }
    
    UIWindow * keyWindow = UIApplication.sharedApplication.delegate.window;
    [keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
    return alertController;
}


@end
