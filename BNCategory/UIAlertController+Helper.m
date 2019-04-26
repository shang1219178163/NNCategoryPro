//
//  UIAlertController+Helper.m
//  ProductTemplet
//
//  Created by Bin Shang on 2019/1/17.
//  Copyright © 2019 BN. All rights reserved.
//

#import "UIAlertController+Helper.h"
#import "BNGloble.h"

/// UIAlertController标题富文本key
NSString * const kAlertCtlrTitle = @"attributedTitle";
/// UIAlertController信息富文本key
NSString * const kAlertCtlrMessage = @"attributedMessage";
/// UIAlertController按钮颜色key
NSString * const kAlertActionColor = @"titleTextColor";


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

+ (instancetype)showAlertTitle:(NSString * _Nullable)title msg:(NSString *_Nullable)msg placeholders:(NSArray *_Nullable)placeholders actionTitles:(NSArray *_Nullable)actionTitles handler:(void(^)(UIAlertController * _Nonnull alertVC, UIAlertAction * _Nonnull action))handler{
    UIWindow * keyWindow = UIApplication.sharedApplication.delegate.window;

    UIAlertController * alertController = [UIAlertController createAlertTitle:title msg:msg placeholders:placeholders actionTitles:actionTitles handler:handler];
    if (alertController.actions.count == 0) {
        [keyWindow.rootViewController presentViewController:alertController animated:YES completion:^{
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(kDurationToast * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [alertController dismissViewControllerAnimated:true completion:nil];
            });
            
        }];
    }
    [keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
    return alertController;
}

+ (instancetype)createSheetTitle:(NSString *_Nullable)title msg:(NSString *_Nullable)msg actionTitles:(NSArray *_Nullable)actionTitles handler:(void(^)(UIAlertController * _Nonnull alertVC, UIAlertAction * _Nonnull action))handler{
    
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleActionSheet];
    
    for (NSString *title in actionTitles) {
        UIAlertActionStyle style = [title isEqualToString:kActionTitle_Cancell] == true? UIAlertActionStyleCancel : UIAlertActionStyleDefault;
        [alertController addAction:[UIAlertAction actionWithTitle:title style:style handler:^(UIAlertAction * _Nonnull action) {
            if (handler) handler(alertController,action);
            
        }]];
    }
    
    if (![actionTitles containsObject:kActionTitle_Cancell]) {
        [alertController addAction:[UIAlertAction actionWithTitle:kActionTitle_Cancell style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            if (handler) handler(alertController,action);
            
        }]];
    }
    return alertController;
}

+ (instancetype)showSheetTitle:(NSString *_Nullable)title msg:(NSString *_Nullable)msg actionTitles:(NSArray *_Nullable)actionTitles handler:(void(^)(UIAlertController * _Nonnull alertVC, UIAlertAction * _Nonnull action))handler{
    UIAlertController * alertController = [UIAlertController createSheetTitle:title msg:msg actionTitles:actionTitles handler:handler];
    
    UIWindow * keyWindow = UIApplication.sharedApplication.delegate.window;
    [keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];//懒加载会崩溃
    return alertController;
}

/**
 展示alert,然后执行异步block代码,然后主线程dismiss
 */
+ (instancetype)showAletTitle:(NSString *_Nullable)title msg:(NSString *_Nullable)msg block:(void(^)(void))block{
    UIWindow * keyWindow = UIApplication.sharedApplication.delegate.window;
    //UIApplication.sharedApplication.keyWindow.rootViewController
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
    [keyWindow.rootViewController presentViewController:alertController animated:false completion:nil];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        block();
        dispatch_async(dispatch_get_main_queue(), ^{
            [alertController dismissViewControllerAnimated:true completion:nil];
            
        });
    });
    return alertController;
}

- (void)setTitleColor:(UIColor *)color{
    assert(self.title != nil);
    
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]init];
    [attr addAttributes:@{
                           NSForegroundColorAttributeName: color,
                           } range:NSMakeRange(0, self.title.length)];
    [self setValue:attr forKey:kAlertCtlrTitle];
}

- (void)setMessageParaStyle:(NSMutableParagraphStyle *)style{
    assert(self.message != nil);
    
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]init];
    [attr addAttributes:@{
                           NSParagraphStyleAttributeName: style,
                           } range:NSMakeRange(0, self.message.length)];
    [self setValue:attr forKey:kAlertCtlrMessage];
}

@end
