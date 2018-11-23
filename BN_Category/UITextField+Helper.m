//
//  UITextField+Helper.m
//  HuiZhuBang
//
//  Created by BIN on 2018/6/8.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//

#import "UITextField+Helper.h"

#import <objc/runtime.h>
#import "BN_Globle.h"

#import "NSObject+Helper.h"
#import "UIView+Helper.h"
#import "UIScreen+Helper.h"
#import "UIColor+Helper.h"


@interface UITextField()<UITableViewDataSource,UITableViewDelegate>

//@property (strong, nonatomic) UITableView *historyTableView;

@end

@implementation UITextField (Helper)

- (BOOL)handlePhoneWithReplacementString:(NSString *)string{
    //只有手机号需要空格,密码不需要
    if ([string isEqualToString:@""]) { // 删除字符
        return YES;
    }
    else {
        if (self.text.length == 3 || self.text.length == 8) {//输入
            NSString * temStr = self.text;
            temStr = [temStr stringByAppendingString:@" "];
            self.text = temStr;
            
        }
        else if (self.text.length >= 13){
            return NO;
        }
    }
    return YES;
}

- (BOOL)backToEmptyWithReplacementString:(NSString *)string{
    if ([string isEqualToString:@""]) { // 删除字符
        self.text = @"";
        return YES;
    }
    return YES;
}

#pragma makr- - history
- (NSString *)identify{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setIdentify:(NSString *)identify {
    objc_setAssociatedObject(self, @selector(identify), identify, OBJC_ASSOCIATION_RETAIN);
}

- (UITableView *)historyTableView {
    UITableView* table = objc_getAssociatedObject(self, _cmd);
    if (table == nil) {
        table = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        [table registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITextFieldHistoryCell"];
        table.layer.borderColor = UIColor.grayColor.CGColor;
        table.layer.borderWidth = 1;
        table.delegate = self;
        table.dataSource = self;
        objc_setAssociatedObject(self, @selector(historyTableView), table, OBJC_ASSOCIATION_RETAIN);
    }
    return table;
}

- (NSArray*)loadHistroy {
    if (self.identify == nil) return nil;
    NSUserDefaults* def = [NSUserDefaults standardUserDefaults];
    NSDictionary* dic = [def objectForKey:@"UITextField+JKHistory"];
    
    if (dic != nil) {
        return [dic objectForKey:self.identify];
    }
    return nil;
}

- (void)synchronize {
    if (self.identify == nil || [self.text length] == 0) {
        return;
    }
    
    NSUserDefaults* def = [NSUserDefaults standardUserDefaults];
    NSDictionary* dic = [def objectForKey:@"UITextField+JKHistory"];
    NSArray* history = [dic objectForKey:self.identify];
    
    NSMutableArray* newHistory = [NSMutableArray arrayWithArray:history];
    
    __block BOOL haveSameRecord = false;
    __weak typeof(self) weakSelf = self;
    
    [newHistory enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([(NSString*)obj isEqualToString:weakSelf.text]) {
            *stop = true;
            haveSameRecord = true;
        }
    }];
    
    if (haveSameRecord) {
        return;
    }
    
    [newHistory addObject:self.text];
    
    NSMutableDictionary* dic2 = [NSMutableDictionary dictionaryWithDictionary:dic];
    [dic2 setObject:newHistory forKey:self.identify];
    
    [def setObject:dic2 forKey:@"UITextField+JKHistory"];
    
    [def synchronize];
}

- (void)showHistory{
    NSArray* history = [self loadHistroy];
    
    if (self.historyTableView.superview != nil || history == nil || history.count == 0) {
        return;
    }
    
    self.historyTableView.frame = CGRectMake(self.x, CGRectGetMaxY(self.frame) + 1, self.w, 1);
    [self.superview addSubview:self.historyTableView];
    
    CGRect rect = self.historyTableView.frame;
    rect.size.height = self.h*(history.count + 1);
    
    [UIView animateWithDuration:kAnimDuration animations:^{
        self.historyTableView.frame = rect;
    }];
}

- (void)clearHistoryButtonClick:(UIButton*) button {
    [self clearHistory];
    [self hideHistroy];
}

- (void)hideHistroy{
    if (self.historyTableView.superview == nil) {
        return;
    }
    
    CGRect rect = self.historyTableView.frame;
    rect.size.height = 1;
    
    [UIView animateWithDuration:kAnimDuration animations:^{
        self.historyTableView.frame = rect;
    } completion:^(BOOL finished) {
        [self.historyTableView removeFromSuperview];
    }];
}

- (void)clearHistory; {
    NSUserDefaults* def = [NSUserDefaults standardUserDefaults];
    
    [def setObject:nil forKey:@"UITextField+JKHistory"];
    [def synchronize];
}


#pragma mark tableview datasource
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView; {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section; {
    return [self loadHistroy].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath; {
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"UITextFieldHistoryCell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITextFieldHistoryCell"];
    }
    cell.separatorInset = UIEdgeInsetsZero;
    
    cell.textLabel.text = [self loadHistroy][indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    

}

#pragma clang diagnostic pop

#pragma mark tableview delegate
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section; {
    UIButton* clearButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [clearButton setTitle:@"全部清除" forState:UIControlStateNormal];
    [clearButton addTarget:self action:@selector(clearHistoryButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    return clearButton;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath; {
    return self.h;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section; {
    return self.h;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath; {
    self.text = [self loadHistroy][indexPath.row];
    [self hideHistroy];
}


@end
