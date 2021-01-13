//
//  UITextField+History.h
//  NNCategoryPro
//
//  Created by Bin Shang on 2019/11/11.
//

/*
 示例:
 @property (nonatomic, strong) UITextField *textField;

 #pragma mark -lazy
 - (UITextField *)textField{
     if (!_textField) {
         _textField = [[UITextField alloc]init];
         _textField.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"请输入" attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14]}];

         _textField.target.list = @[@"111", @"222", @"333", @"444", @"555"].mutableCopy;
         _textField.target.block = ^(UITextFieldHistoryTarget *tagget) {
             DDLog(@"%@", tagget.selectedText);
         };
     }
     return _textField;
 }
 **/

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class UITextFieldHistoryTarget;
@interface UITextField (History)

@property (nonatomic, strong, readonly) UITextFieldHistoryTarget *target;

@end


@interface UITextFieldHistoryTarget : NSObject

@property (nonatomic, strong) NSMutableArray<NSString *> *list;
@property (nonatomic, strong, readonly, nullable) NSString *selectedText;

@property (nonatomic, copy) UITableViewCell *(^blockCellForRow)(UITableView *tableView, NSIndexPath *indexPath);
@property (nonatomic, copy) void(^block)(UITextFieldHistoryTarget *);

- (void)showHistory;

- (void)hideHistroy;

- (void)clearHistory;

@end


NS_ASSUME_NONNULL_END
