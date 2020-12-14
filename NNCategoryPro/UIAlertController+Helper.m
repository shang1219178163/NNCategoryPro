//
//  UIAlertController+Helper.m
//  ProductTemplet
//
//  Created by Bin Shang on 2019/1/17.
//  Copyright © 2019 BN. All rights reserved.
//

#import "UIAlertController+Helper.h"
#import <NNGloble/NNGloble.h>
#import "UIViewController+Helper.h"

/// UIAlertController标题富文本key
NSString * const kAlertVCTitle = @"attributedTitle";
/// UIAlertController信息富文本key
NSString * const kAlertVCMessage = @"attributedMessage";
/// UIAlertController按钮颜色key
NSString * const kAlertActionColor = @"titleTextColor";


@implementation UIAlertController (Helper)

- (UIAlertController * _Nonnull (^)(NSArray<NSString *> * _Nonnull, void (^)(UIAlertAction * action)))nn_addAction{
    return ^(NSArray<NSString *> *titles, void(^handler)(UIAlertAction *action)){
        [titles enumerateObjectsUsingBlock:^(NSString * _Nonnull title, NSUInteger idx, BOOL * _Nonnull stop) {
            UIAlertActionStyle style = [title isEqualToString:@"取消"] ? UIAlertActionStyleDestructive : UIAlertActionStyleDefault;
            [self addAction:[UIAlertAction actionWithTitle:title style:style handler:handler]];
        }];
        return self;
    };
}

- (UIAlertController * _Nonnull (^)(NSArray<NSString *> * _Nonnull, void (^ _Nonnull)(UITextField * textField)))nn_addTextField{
    NSParameterAssert(self.preferredStyle == UIAlertControllerStyleAlert);
    if (self.preferredStyle != UIAlertControllerStyleAlert) {
        return ^(NSArray<NSString *> *placeholders, void(^handler)(UITextField *action)){
            return self;
        };
    }
    
    return ^(NSArray<NSString *> *placeholders, void(^handler)(UITextField *action)){
        [placeholders enumerateObjectsUsingBlock:^(NSString * _Nonnull placeholder, NSUInteger idx, BOOL * _Nonnull stop) {
            [self addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
                textField.placeholder = placeholder;
                if (handler) {
                    handler(textField);
                }
            }];
        }];
        return self;
    };
}

- (UIAlertController * _Nonnull (^)(BOOL, void (^ _Nullable)(void)))nn_present{
    return ^(BOOL animated, void(^completion)(void)){
        [self present:animated completion:completion];
        return self;
    };
}

- (instancetype)addActionTitles:(NSArray<NSString *> *)titles handler:(void(^)(UIAlertController *alertVC, UIAlertAction *action))handler {
    [titles enumerateObjectsUsingBlock:^(NSString * _Nonnull title, NSUInteger idx, BOOL * _Nonnull stop) {
        UIAlertActionStyle style = [title isEqualToString:@"取消"] ? UIAlertActionStyleDestructive : UIAlertActionStyleDefault;
        [self addAction:[UIAlertAction actionWithTitle:title style:style handler:^(UIAlertAction * _Nonnull action) {
            handler(self, action);
        }]];
    }];
    return self;
}

- (instancetype)addTextFieldPlaceholders:(NSArray<NSString *> *)placeholders handler:(void(^)(UITextField *textField))handler {
    NSParameterAssert(self.preferredStyle == UIAlertControllerStyleAlert);
    if (self.preferredStyle != UIAlertControllerStyleAlert) {
        return self;
    }

    [placeholders enumerateObjectsUsingBlock:^(NSString * _Nonnull placeholder, NSUInteger idx, BOOL * _Nonnull stop) {
        [self addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.placeholder = placeholder;
            if (handler) {
                handler(textField);
            }
        }];
    }];
    return self;
}

+ (instancetype)createAlertTitle:(NSString * _Nullable)title
                         message:(NSString *_Nullable)message
                    actionTitles:(NSArray *_Nullable)actionTitles
                         handler:(void(^_Nullable)(UIAlertController *alertVC, UIAlertAction *action))handler{
    
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:title
                                                                     message:message
                                                              preferredStyle:UIAlertControllerStyleAlert];
    [alertVC addActionTitles:actionTitles handler:handler];
    return alertVC;
}

+ (instancetype)showAlertTitle:(NSString * _Nullable)title
                       message:(NSString *_Nullable)message
                  actionTitles:(NSArray *_Nullable)actionTitles
                       handler:(void(^_Nullable)(UIAlertController *alertVC, UIAlertAction *action))handler{
    UIAlertController *alertVC = [UIAlertController createAlertTitle:title
                                                             message:message
                                                        actionTitles:actionTitles
                                                             handler:handler];
    [alertVC present:true completion:nil];
    return alertVC;
}

+ (instancetype)createSheetTitle:(NSString *_Nullable)title
                         message:(NSString *_Nullable)message
                    actionTitles:(NSArray *_Nullable)actionTitles
                         handler:(void(^_Nullable)(UIAlertController *alertVC, UIAlertAction *action))handler{
    
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:title
                                                                     message:message
                                                              preferredStyle:UIAlertControllerStyleActionSheet];
    [alertVC addActionTitles:actionTitles handler:handler];
    return alertVC;
}

+ (instancetype)showSheetTitle:(NSString *_Nullable)title
                       message:(NSString *_Nullable)message
                  actionTitles:(NSArray *_Nullable)actionTitles
                       handler:(void(^_Nullable)(UIAlertController *alertVC, UIAlertAction *action))handler{
    UIAlertController *alertVC = [UIAlertController createSheetTitle:title
                                                                 message:message
                                                        actionTitles:actionTitles
                                                             handler:handler];
    [alertVC present:true completion:nil];
    return alertVC;
}


- (instancetype)setTitleColor:(UIColor *)color{
    if (self.title == nil || [self.title isEqualToString:@""]) {
        return self;
    }

    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]init];
    [attr addAttributes:@{NSForegroundColorAttributeName: color,
                           }
                  range:NSMakeRange(0, self.title.length)];
    [self setValue:attr forKey:kAlertVCTitle];
    return self;
}

- (instancetype)setMessageParaStyle:(NSMutableParagraphStyle *)style{
    if (self.message == nil || [self.message isEqualToString:@""]) {
        return self;
    }
    
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]init];
    [attr addAttributes:@{NSParagraphStyleAttributeName: style,
                           }
                  range:NSMakeRange(0, self.message.length)];
    [self setValue:attr forKey:kAlertVCMessage];
    return self;
}

+ (void)callPhone:(NSString *)phoneNumber{
    NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@" _转"];
    phoneNumber = [phoneNumber stringByTrimmingCharactersInSet:set];
    
    NSArray *titles = @[@"取消",@"呼叫"];
    [UIAlertController showAlertTitle:nil
                              message:phoneNumber
                         actionTitles:titles
                              handler:^(UIAlertController *alertVC, UIAlertAction * action) {
        if ([action.title isEqualToString: titles.firstObject]) {
            return;
        }
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            NSString *phoneStr = [NSString stringWithFormat:@"tel:%@",phoneNumber];
            if (@available(iOS 10.0, *)) {
                [UIApplication.sharedApplication openURL:[NSURL URLWithString:phoneStr] options:@{} completionHandler:nil];
            } else {
                [UIApplication.sharedApplication openURL:[NSURL URLWithString:phoneStr]];
            }
        });
    }];
}

@end
