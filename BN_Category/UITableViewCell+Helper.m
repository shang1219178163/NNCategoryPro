//
//  UITableViewCell+Helper.m
//  
//
//  Created by BIN on 2018/1/9.
//  Copyright © 2018年 SHANG. All rights reserved.
//

#import "UITableViewCell+Helper.h"

#import <objc/runtime.h>
#import "BN_Globle.h"

@implementation UITableViewCell (Helper)

-(NSMutableDictionary *)mdict{
    return objc_getAssociatedObject(self, _cmd);
}

-(void)setMdict:(NSMutableDictionary *)mdict{
    objc_setAssociatedObject(self, @selector(mdict), mdict, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)cellHeightFor:(NSIndexPath *)indexPath keyPath:(NSString *)keyPath{
    NSString *cachKey = [NSString stringWithFormat:@"%@%@",@(indexPath.section),@(indexPath.row)];
    NSNumber *cachHeight = self.mdict[cachKey];
    if (cachHeight) {
        return [cachHeight floatValue];
    }
    return 60;
}

-(UILabel *)label{
    id obj = objc_getAssociatedObject(self, _cmd);
    if (!obj) {
        obj = ({
            UILabel * view = [[UILabel alloc] initWithFrame:CGRectZero];
            view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;

            view.font = [UIFont systemFontOfSize:15];
            view.textColor = UIColor.grayColor;
            view.textAlignment = NSTextAlignmentCenter;
        
            view.numberOfLines = 0;
            view.userInteractionEnabled = YES;
//            view.backgroundColor = UIColor.greenColor;
            view;
        });
        objc_setAssociatedObject(self, _cmd, obj, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return obj;
}

-(void)setLabel:(UILabel *)label{
    objc_setAssociatedObject(self, @selector(label), label, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(UIImageView *)imgView{
    id obj = objc_getAssociatedObject(self, _cmd);
    if (!obj) {
        obj = ({
            UIImageView *view = [[UIImageView alloc] initWithFrame:CGRectZero];
            view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
            view.contentMode = UIViewContentModeScaleAspectFit;
            view.userInteractionEnabled = YES;
            view.tag = kTAG_IMGVIEW;
            view;
        });
        objc_setAssociatedObject(self, @selector(imgView), obj, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return obj;
}

- (void)setImgView:(UIImageView *)imgView{
    objc_setAssociatedObject(self, @selector(imgView), imgView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+(instancetype)cellWithTableView:(UITableView *)tableView identifier:(NSString *)identifier{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(!cell){
        cell = [[self alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.separatorInset = UIEdgeInsetsZero;
    
    return cell;
}

+(instancetype)cellWithTableView:(UITableView *)tableView{
    NSString *identifier = NSStringFromClass(self.class);
    return [self cellWithTableView:tableView identifier:identifier];
}

@end
