//
//  UIAlertController+Helper.m
//  ProductTemplet
//
//  Created by Bin Shang on 2019/1/17.
//  Copyright © 2019 BN. All rights reserved.
//

#import "UIAlertController+Helper.h"
#import <NNGloble/NNGloble.h>

/// UIAlertController标题富文本key
NSString * const kAlertCtlrTitle = @"attributedTitle";
/// UIAlertController信息富文本key
NSString * const kAlertCtlrMessage = @"attributedMessage";
/// UIAlertController按钮颜色key
NSString * const kAlertActionColor = @"titleTextColor";


@implementation UIAlertController (Helper)

+ (instancetype)createAlertTitle:(NSString * _Nullable)title
                             msg:(NSString *_Nullable)msg
                    placeholders:(NSArray *_Nullable)placeholders
                    actionTitles:(NSArray *_Nullable)actionTitles
                         handler:(void(^_Nullable)(UIAlertController *alertVC, UIAlertAction *action))handler{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
    for (NSString * placeholder in placeholders) {
        [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.placeholder = placeholder;
            textField.textAlignment = NSTextAlignmentCenter;
            
        }];
    }
        
    for (NSString *title in actionTitles) {
        UIAlertActionStyle style = [title isEqualToString:kTitleCancell] == true? UIAlertActionStyleDestructive : UIAlertActionStyleDefault;
        [alertController addAction:[UIAlertAction actionWithTitle:title style:style handler:^(UIAlertAction * _Nonnull action) {
            if (handler) handler(alertController,action);
            
        }]];
    }
    
    if (![actionTitles containsObject:kTitleCancell]) {
        [alertController addAction:[UIAlertAction actionWithTitle:kTitleCancell style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            if (handler) handler(alertController,action);
            
        }]];
    }
    
//    UIWindow *keyWindow = UIApplication.sharedApplication.delegate.window;
//    [keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
    return alertController;
}

+ (instancetype)showAlertTitle:(NSString * _Nullable)title
                           msg:(NSString *_Nullable)msg
                  placeholders:(NSArray *_Nullable)placeholders
                  actionTitles:(NSArray *_Nullable)actionTitles
                       handler:(void(^_Nullable)(UIAlertController *alertVC, UIAlertAction *action))handler{
    UIWindow *keyWindow = UIApplication.sharedApplication.delegate.window;

    UIAlertController *alertController = [UIAlertController createAlertTitle:title msg:msg placeholders:placeholders actionTitles:actionTitles handler:handler];
    if (alertController.actions.count == 0) {
        [keyWindow.rootViewController presentViewController:alertController animated:YES completion:^{
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(kDurationToast * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [alertController dismissViewControllerAnimated:true completion:nil];
            });
            
        }];
    } else {
        [keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
        
    }
    return alertController;
}

+ (instancetype)createSheetTitle:(NSString *_Nullable)title
                             msg:(NSString *_Nullable)msg
                    actionTitles:(NSArray *_Nullable)actionTitles
                         handler:(void(^_Nullable)(UIAlertController *alertVC, UIAlertAction *action))handler{
    
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleActionSheet];
    
    for (NSString *title in actionTitles) {
        UIAlertActionStyle style = [title isEqualToString:kTitleCancell] == true? UIAlertActionStyleCancel : UIAlertActionStyleDefault;
        [alertController addAction:[UIAlertAction actionWithTitle:title style:style handler:^(UIAlertAction * _Nonnull action) {
            if (handler) handler(alertController,action);
            
        }]];
    }
    
    if (![actionTitles containsObject:kTitleCancell]) {
        [alertController addAction:[UIAlertAction actionWithTitle:kTitleCancell style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            if (handler) handler(alertController,action);
            
        }]];
    }
    return alertController;
}

+ (instancetype)showSheetTitle:(NSString *_Nullable)title
                           msg:(NSString *_Nullable)msg
                  actionTitles:(NSArray *_Nullable)actionTitles
                       handler:(void(^_Nullable)(UIAlertController *alertVC, UIAlertAction *action))handler{
    UIAlertController * alertController = [UIAlertController createSheetTitle:title msg:msg actionTitles:actionTitles handler:handler];
    
    UIWindow *keyWindow = UIApplication.sharedApplication.delegate.window;
    [keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];//懒加载会崩溃
    return alertController;
}

/**
 展示alert,然后执行异步block代码,然后主线程dismiss
 */
//+ (instancetype)showAletTitle:(NSString *_Nullable)title msg:(NSString *_Nullable)msg handler:(void(^ _Nullable)(void))handler{
//    UIWindow *keyWindow = UIApplication.sharedApplication.delegate.window;
//    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
//    [keyWindow.rootViewController presentViewController:alertController animated:false completion:nil];
//
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        if (handler) {
//            handler();
//        }
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [alertController dismissViewControllerAnimated:true completion:nil];
//        });
//    });
//    return alertController;
//}

+ (instancetype)showAlertTitle:(NSString * _Nullable)title
                           msg:(NSString *_Nullable)msg
                  actionTitles:(NSArray *_Nullable)actionTitles
                       handler:(void(^_Nullable)(UIAlertController *alertVC, UIAlertAction *action))handler{
    return [UIAlertController showAlertTitle:title msg:msg placeholders:nil actionTitles:actionTitles handler:handler];
}

+ (instancetype)showAlertTitle:(NSString *_Nullable)title
                           msg:(NSString *_Nullable)msg
                       handler:(void(^)(UIAlertController * _Nonnull alertVC, UIAlertAction * _Nullable action))handler{
    return [UIAlertController showAlertTitle:title msg:msg placeholders:nil actionTitles:@[kTitleCancell, kTitleSure] handler:handler];
}


- (void)setTitleColor:(UIColor *)color{
    assert(self.title != nil);
    
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]init];
    [attr addAttributes:@{NSForegroundColorAttributeName: color,
                           }
                  range:NSMakeRange(0, self.title.length)];
    [self setValue:attr forKey:kAlertCtlrTitle];
}

- (void)setMessageParaStyle:(NSMutableParagraphStyle *)style{
    assert(self.message != nil);
    
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]init];
    [attr addAttributes:@{NSParagraphStyleAttributeName: style,
                           }
                  range:NSMakeRange(0, self.message.length)];
    [self setValue:attr forKey:kAlertCtlrMessage];
}

@end
