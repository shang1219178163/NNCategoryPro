//
//  UITableView+Helper.h
//  
//
//  Created by BIN on 2018/2/28.
//  Copyright © 2018年 SHANG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (Helper)

-(void)logTableViewContentInset;

-(void)reloadRowList:(NSArray *)rowList section:(NSInteger)section rowAnimation:(UITableViewRowAnimation)rowAnimation;

-(void)insertRowList:(NSArray *)rowList section:(NSInteger)section rowAnimation:(UITableViewRowAnimation)rowAnimation;

-(void)deleteRowList:(NSArray *)rowList section:(NSInteger)section rowAnimation:(UITableViewRowAnimation)rowAnimation;

-(void)cellAddCornerRadius:(CGFloat)cornerRadius cell:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath;

@end
