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
NSString * const kAlertVCTitle = @"attributedTitle";
/// UIAlertController信息富文本key
NSString * const kAlertVCMessage = @"attributedMessage";
/// UIAlertController按钮颜色key
NSString * const kAlertActionColor = @"titleTextColor";


@implementation UIAlertController (Helper)

+ (instancetype)createAlertTitle:(NSString * _Nullable)title
                             msg:(NSString *_Nullable)msg
                    placeholders:(NSArray *_Nullable)placeholders
                    actionTitles:(NSArray *_Nullable)actionTitles
                         handler:(void(^_Nullable)(UIAlertController *alertVC, UIAlertAction *action))handler{
    
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:title
                                                                     message:msg
                                                              preferredStyle:UIAlertControllerStyleAlert];
    for (NSString * placeholder in placeholders) {
        [alertVC addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.placeholder = placeholder;
            textField.textAlignment = NSTextAlignmentCenter;
            
        }];
    }
        
    for (NSString *title in actionTitles) {
        UIAlertActionStyle style = [title isEqualToString:kTitleCancell] == true? UIAlertActionStyleDestructive : UIAlertActionStyleDefault;
        [alertVC addAction:[UIAlertAction actionWithTitle:title style:style handler:^(UIAlertAction * _Nonnull action) {
            if (handler) handler(alertVC, action);
            
        }]];
    }
    
    if (![actionTitles containsObject:kTitleCancell]) {
        [alertVC addAction:[UIAlertAction actionWithTitle:kTitleCancell style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            if (handler) handler(alertVC, action);
            
        }]];
    }
    
//    UIWindow *keyWindow = UIApplication.sharedApplication.delegate.window;
//    [keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
    return alertVC;
}

+ (instancetype)showAlertTitle:(NSString * _Nullable)title
                           msg:(NSString *_Nullable)msg
                  placeholders:(NSArray *_Nullable)placeholders
                  actionTitles:(NSArray *_Nullable)actionTitles
                       handler:(void(^_Nullable)(UIAlertController *alertVC, UIAlertAction *action))handler{
    UIWindow *keyWindow = UIApplication.sharedApplication.delegate.window;

    UIAlertController *alertVC = [UIAlertController createAlertTitle:title
                                                                 msg:msg
                                                        placeholders:placeholders
                                                        actionTitles:actionTitles
                                                             handler:handler];
    if (alertVC.actions.count == 0) {
        [keyWindow.rootViewController presentViewController:alertVC animated:YES completion:^{
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(kDurationToast * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [alertVC dismissViewControllerAnimated:true completion:nil];
            });
            
        }];
    } else {
        [keyWindow.rootViewController presentViewController:alertVC animated:YES completion:nil];
        
    }
    return alertVC;
}

+ (instancetype)createSheetTitle:(NSString *_Nullable)title
                             msg:(NSString *_Nullable)msg
                    actionTitles:(NSArray *_Nullable)actionTitles
                         handler:(void(^_Nullable)(UIAlertController *alertVC, UIAlertAction *action))handler{
    
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:title
                                                                              message:msg
                                                                       preferredStyle:UIAlertControllerStyleActionSheet];
    
    for (NSString *title in actionTitles) {
        UIAlertActionStyle style = [title isEqualToString:kTitleCancell] == true? UIAlertActionStyleCancel : UIAlertActionStyleDefault;
        [alertVC addAction:[UIAlertAction actionWithTitle:title style:style handler:^(UIAlertAction * _Nonnull action) {
            if (handler) handler(alertVC, action);
            
        }]];
    }
    
    if (![actionTitles containsObject:kTitleCancell]) {
        [alertVC addAction:[UIAlertAction actionWithTitle:kTitleCancell style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            if (handler) handler(alertVC, action);
            
        }]];
    }
    return alertVC;
}

+ (instancetype)showSheetTitle:(NSString *_Nullable)title
                           msg:(NSString *_Nullable)msg
                  actionTitles:(NSArray *_Nullable)actionTitles
                       handler:(void(^_Nullable)(UIAlertController *alertVC, UIAlertAction *action))handler{
    UIAlertController *alertVC = [UIAlertController createSheetTitle:title
                                                                 msg:msg
                                                        actionTitles:actionTitles
                                                             handler:handler];
    
    UIWindow *keyWindow = UIApplication.sharedApplication.delegate.window;
    [keyWindow.rootViewController presentViewController:alertVC animated:YES completion:nil];//懒加载会崩溃
    return alertVC;
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
    return [UIAlertController showAlertTitle:title
                                         msg:msg
                                placeholders:nil
                                actionTitles:actionTitles
                                     handler:handler];
}

+ (instancetype)showAlertTitle:(NSString *_Nullable)title
                           msg:(NSString *_Nullable)msg
                       handler:(void(^)(UIAlertController * _Nonnull alertVC, UIAlertAction * _Nullable action))handler{
    return [UIAlertController showAlertTitle:title
                                         msg:msg
                                placeholders:nil
                                actionTitles:@[kTitleCancell, kTitleSure]
                                     handler:handler];
}

+ (void)callPhone:(NSString *)phoneNumber{
    NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@" _转"];
    phoneNumber = [phoneNumber stringByTrimmingCharactersInSet:set];
    
    NSArray *titles = @[@"取消",@"呼叫"];
    [UIAlertController showAlertTitle:nil
                                  msg:phoneNumber
                         actionTitles:titles
                              handler:^(UIAlertController * _Nonnull alertController, UIAlertAction * _Nullable action) {
        if ([action.title isEqualToString: titles.firstObject]) {
            return;
        }
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            NSString * phoneStr = [NSString stringWithFormat:@"tel:%@",phoneNumber];
            if (iOSVer(10)) {
                [UIApplication.sharedApplication openURL:[NSURL URLWithString:phoneStr] options:@{} completionHandler:nil];
            } else {
                [UIApplication.sharedApplication openURL:[NSURL URLWithString:phoneStr]];
            }
        });
    }];
}


- (void)setTitleColor:(UIColor *)color{
    if (self.title == nil || [self.title isEqualToString:@""]) {
        return;
    }

    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]init];
    [attr addAttributes:@{NSForegroundColorAttributeName: color,
                           }
                  range:NSMakeRange(0, self.title.length)];
    [self setValue:attr forKey:kAlertVCTitle];
}

- (void)setMessageParaStyle:(NSMutableParagraphStyle *)style{
    if (self.message == nil || [self.message isEqualToString:@""]) {
        return;
    }
    
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]init];
    [attr addAttributes:@{NSParagraphStyleAttributeName: style,
                           }
                  range:NSMakeRange(0, self.message.length)];
    [self setValue:attr forKey:kAlertVCMessage];
}

@end
