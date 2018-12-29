//
//  UITableViewCell+Helper.m
//  
//
//  Created by BIN on 2018/1/9.
//  Copyright © 2018年 SHANG. All rights reserved.
//

#import "UITableViewCell+Helper.h"

#import <objc/runtime.h>

@implementation UITableViewCell (Helper)

@dynamic imgView,label;

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
                UILabel * label = [[UILabel alloc] initWithFrame:CGRectZero];
                label.font = [UIFont systemFontOfSize:15];
                label.textColor = UIColor.grayColor;
                label.textAlignment = NSTextAlignmentCenter;
            
                label.numberOfLines = 0;
                label.userInteractionEnabled = YES;
                label.backgroundColor = UIColor.greenColor;
                label;
        });
        objc_setAssociatedObject(self, @selector(label), obj, OBJC_ASSOCIATION_RETAIN_NONATOMIC);

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
            UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectZero];
            imgView.userInteractionEnabled = YES;
            imgView.backgroundColor = UIColor.orangeColor;
            
            imgView;
            
        });
        objc_setAssociatedObject(self, @selector(imgView), obj, OBJC_ASSOCIATION_RETAIN_NONATOMIC);

    }
    return obj;
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
