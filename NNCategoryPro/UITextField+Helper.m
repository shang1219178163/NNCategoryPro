//
//  UITextField+Helper.m
//  
//
//  Created by BIN on 2018/6/8.
//  Copyright © 2018年 SHANG. All rights reserved.
//

#import "UITextField+Helper.h"

//#import <objc/runtime.h>
//#import <NNGloble/NNGloble.h>
//
//#import "NSObject+Helper.h"
//#import "UIView+Helper.h"
//#import "UIScreen+Helper.h"
//#import "UIColor+Helper.h"
//
//NSString * const kDeafult_textFieldHistory = @"kDeafult_textFieldHistory" ;

#import "UIView+Helper.h"
#import "UIGestureRecognizer+Helper.h"

@interface UITextField()<UITableViewDataSource,UITableViewDelegate>

//@property (strong, nonatomic) UITableView *historyTableView;

@end

@implementation UITextField (Helper)

/**
 [源]UITextField创建
 */
+ (instancetype)createRect:(CGRect)rect{
    UITextField * textField = [[self alloc]initWithFrame:rect];
    textField.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    textField.placeholder = @"请输入";
    textField.textAlignment = NSTextAlignmentLeft;
    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
    textField.keyboardAppearance = UIKeyboardAppearanceDefault;
    textField.keyboardType = UIReturnKeyDone;
    
//    textField.returnKeyType = UIReturnKeyDone;
//    textField.clearButtonMode = UITextFieldViewModeAlways;
    
    textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    textField.autocorrectionType = UITextAutocorrectionTypeNo;
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;//清楚键
    textField.borderStyle = UITextBorderStyleRoundedRect;

    textField.backgroundColor = UIColor.whiteColor;
//    textField.backgroundColor = UIColor.clearColor;
    
    return textField;
}

/**
 [源]UITextField密码输入框创建(NNTextFieldOne 调用)
 */
+ (instancetype)createPwdRect:(CGRect)rect image:(UIImage *)image imageSelected:(UIImage *)imageSelected {
    UITextField *textField = [[self alloc]initWithFrame:rect];
    textField.placeholder = @"  请输入密码";
    textField.backgroundColor = UIColor.greenColor;
    textField.clearsOnBeginEditing = true;
    textField.clearButtonMode = UITextFieldViewModeAlways;
    textField.secureTextEntry = true;
    
    textField.leftViewMode = UITextFieldViewModeAlways;
    textField.leftView = ({
        CGRect imgViewRect = CGRectEqualToRect(CGRectZero, rect) ? CGRectMake(0, 0, 30, 30) : CGRectMake(0, 0, CGRectGetHeight(rect) - 5, CGRectGetHeight(rect) - 5);
        UIImageView *imgView = [[UIImageView alloc]initWithFrame: imgViewRect];
        imgView.userInteractionEnabled = true;
        imgView.contentMode = UIViewContentModeCenter;
        //        imgView.backgroundColor = UIColor.redColor;
        imgView.image = image;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
        tap.numberOfTapsRequired = 1;
        tap.numberOfTouchesRequired = 1;
        //    tapGesture.cancelsTouchesInView = NO;
        //    tapGesture.delaysTouchesEnded = NO;
        [tap addActionBlock:^(UIGestureRecognizer * _Nonnull reco) {
            //            DDLog(@"%@", reco)
            UIImageView * sender = (UIImageView *)reco.view;
            sender.selected = !sender.selected;
            sender.image = sender.selected == false ? image : imageSelected;
            
            NSString *tempPwdStr = textField.text;
            textField.text = @""; // 这句代码可以防止切换的时候光标偏移
            textField.secureTextEntry = !sender.selected;
            textField.text = tempPwdStr;
        }];
        
        [imgView addGestureRecognizer:tap];
        
        imgView;
    });
    return textField;
}
//

//- (NSInteger)maxLength {
//    return [objc_getAssociatedObject(self, _cmd) integerValue];
//}
//
//- (void)setMaxLength:(NSInteger)maxLength {
//    objc_setAssociatedObject(self, @selector(maxLength), @(maxLength), OBJC_ASSOCIATION_ASSIGN);
//    [self addTarget:self action:@selector(textFieldTextDidChange) forControlEvents:UIControlEventEditingChanged];
//}
//
//- (void)textFieldTextDidChange {
//    NSString *toBeString = self.text;
//    //获取高亮部分
//    UITextRange *selectedRange = [self markedTextRange];
//    UITextPosition *position = [self positionFromPosition:selectedRange.start offset:0];
//
//    //没有高亮选择的字，则对已输入的文字进行字数统计和限制
//    //在iOS7下,position对象总是不为nil
//    if ( (!position ||!selectedRange) && (self.maxLength > 0 && toBeString.length > self.maxLength))
//    {
//        NSRange rangeIndex = [toBeString rangeOfComposedCharacterSequenceAtIndex:self.maxLength];
//        if (rangeIndex.length == 1)
//        {
//            self.text = [toBeString substringToIndex:self.maxLength];
//        }
//        else
//        {
//            NSRange rangeRange = [toBeString rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, self.maxLength)];
//            NSInteger tmpLength;
//            if (rangeRange.length > self.maxLength) {
//                tmpLength = rangeRange.length - rangeIndex.length;
//            } else {
//                tmpLength = rangeRange.length;
//            }
//            self.text = [toBeString substringWithRange:NSMakeRange(0, tmpLength)];
//        }
//    }
//}
//
//- (BOOL)handlePhoneWithReplacementString:(NSString *)string{
//    //只有手机号需要空格,密码不需要
//    if ([string isEqualToString:@""]) { // 删除字符
//        return YES;
//    }
//    else {
//        if (self.text.length == 3 || self.text.length == 8) {//输入
//            NSString * temStr = self.text;
//            temStr = [temStr stringByAppendingString:@" "];
//            self.text = temStr;
//
//        }
//        else if (self.text.length >= 13){
//            return NO;
//        }
//    }
//    return YES;
//}
//
//- (BOOL)backToEmptyWithReplacementString:(NSString *)string{
//    if ([string isEqualToString:@""]) { // 删除字符
//        self.text = @"";
//        return YES;
//    }
//    return YES;
//}
//
//#pragma makr- - history
//- (NSString *)identify{
//    return objc_getAssociatedObject(self, _cmd);
//}
//
//- (void)setIdentify:(NSString *)identify {
//    objc_setAssociatedObject(self, @selector(identify), identify, OBJC_ASSOCIATION_RETAIN);
//}
//
//- (UITableView *)historyTableView {
//    UITableView* table = objc_getAssociatedObject(self, _cmd);
//    if (!table) {
//        table = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
//        [table registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITextFieldHistoryCell"];
//        table.layer.borderColor = UIColor.grayColor.CGColor;
//        table.layer.borderWidth = 1;
//        table.delegate = self;
//        table.dataSource = self;
//        objc_setAssociatedObject(self, @selector(historyTableView), table, OBJC_ASSOCIATION_RETAIN);
//    }
//    return table;
//}
//
//- (void)setHistoryTableView:(UITableView *)historyTableView{
//    objc_setAssociatedObject(self, @selector(historyTableView), historyTableView, OBJC_ASSOCIATION_RETAIN);
//
//}
//
//- (NSArray*)loadHistroy {
//    if (!self.identify) return nil;
//    NSUserDefaults* def = NSUserDefaults.standardUserDefaults;
//    NSDictionary* dic = [def objectForKey:kDeafult_textFieldHistory];
//
//    id data = [dic objectForKey:self.identify];
//    if ([data isKindOfClass:[NSArray class]]) {
//        return data;
//    }
//    if ([data isKindOfClass:[NSDictionary class]]) {
//        return [data allKeys];
//    }
//    return nil;
//}
//
//- (void)synchronize {
//    if (!self.identify || self.text.length == 0) {
//        return;
//    }
//
//    NSUserDefaults* def = NSUserDefaults.standardUserDefaults;
//    NSDictionary* dic = [def objectForKey:kDeafult_textFieldHistory];
//    NSArray* history = [dic objectForKey:self.identify];
//
//    NSMutableArray* newHistory = [NSMutableArray arrayWithArray:history];
//
//    __block BOOL haveSameRecord = false;
//    __weak typeof(self) weakSelf = self;
//
//    [newHistory enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//        if ([(NSString*)obj isEqualToString:weakSelf.text]) {
//            *stop = true;
//            haveSameRecord = true;
//        }
//    }];
//
//    if (haveSameRecord) {
//        return;
//    }
//
//    [newHistory addObject:self.text];
//
//    NSMutableDictionary* dic2 = [NSMutableDictionary dictionaryWithDictionary:dic];
//    [dic2 setObject:newHistory forKey:self.identify];
//
//    [def setObject:dic2 forKey:kDeafult_textFieldHistory];
//
//    [def synchronize];
//}
//
//- (void)showHistory{
//    NSArray* history = [self loadHistroy];
//
//    if (self.historyTableView.superview || !history || history.count == 0) {
//        return;
//    }
//
//    self.historyTableView.frame = CGRectMake(self.minX, CGRectGetMaxY(self.frame), self.sizeWidth, 1);
//    [self.superview addSubview:self.historyTableView];
//
//    CGRect rect = self.historyTableView.frame;
//    rect.size.height = self.maxY*(history.count + 1);
//
//    [UIView animateWithDuration:kDurationDrop animations:^{
//        self.historyTableView.frame = rect;
//    }];
//}
//
//- (void)clearHistoryButtonClick:(UIButton*) button {
//    [self clearHistory];
//    [self hideHistroy];
//}
//
//- (void)hideHistroy{
//    if (!self.historyTableView.superview) {
//        return;
//    }
//
//    CGRect rect = self.historyTableView.frame;
//    rect.size.height = 1;
//
//    [UIView animateWithDuration:kDurationDrop animations:^{
//        self.historyTableView.frame = rect;
//    } completion:^(BOOL finished) {
//        [self.historyTableView removeFromSuperview];
//    }];
//}
//
//- (void)clearHistory{
//    NSUserDefaults* def = NSUserDefaults.standardUserDefaults;
//
//    [def setObject:nil forKey:kDeafult_textFieldHistory];
//    [def synchronize];
//}
//
//#pragma mark -tableview
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return 1;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return [self loadHistroy].count;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"UITextFieldHistoryCell"];
//    if (!cell) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITextFieldHistoryCell"];
//    }
//    cell.separatorInset = UIEdgeInsetsZero;
//    cell.textLabel.text = [self loadHistroy][indexPath.row];
//
//    return cell;
//}
//
//-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
//
//
//}
//
//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
//    UIButton* clearButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    [clearButton setTitle:@"全部清除" forState:UIControlStateNormal];
//    [clearButton addTarget:self action:@selector(clearHistoryButtonClick:) forControlEvents:UIControlEventTouchUpInside];
//
//    return clearButton;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return self.maxY;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    return self.maxY;
//}
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    self.text = [self loadHistroy][indexPath.row];
//    [self hideHistroy];
//}


@end
