
//
//  UITableViewHeaderFooterView+AddView.m
//  HuiZhuBang
//
//  Created by BIN on 2018/8/24.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//

#import "UITableViewHeaderFooterView+AddView.h"

#import "BN_Globle.h"

#import <objc/runtime.h>
#import "UIView+Helper.h"
#import "UIScreen+Helper.h"
#import "UIColor+Helper.h"


@implementation UITableViewHeaderFooterView (AddView)

@dynamic imgViewLeft,imgViewRight,viewIndicator,labelLeft,labelLeftSub,labelLeftMark,labelLeftSubMark,btn;

+(instancetype)viewWithTableView:(UITableView *)tableView identifier:(NSString *)identifier{
    UITableViewHeaderFooterView * view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:identifier];
    if (!view) {
        view = [[self alloc] initWithReuseIdentifier:identifier];

        [view.layer addSublayer:[view createLayerType:@0]];
        [view.layer addSublayer:[view createLayerType:@2]];
    }
    return view;
}

+(instancetype)viewWithTableView:(UITableView *)tableView{
    NSString *identifier = NSStringFromClass([self class]);
    return [self viewWithTableView:tableView identifier:identifier];
}

#pragma mark -- layz

-(CGFloat)width{
    return CGRectGetWidth(self.contentView.frame);
    
}

-(CGFloat)height{
    return CGRectGetHeight(self.contentView.frame);
    
}

-(UILabel *)labelLeft{
    UILabel * lab = objc_getAssociatedObject(self, _cmd);
    if (lab == nil) {
        lab = [UIView createLabelWithRect:CGRectZero text:@"" textColor:nil tag:kTAG_LABEL patternType:@"2" font:KFZ_Second backgroudColor:UIColor.whiteColor alignment:NSTextAlignmentLeft];
        
        //        lab = ({
        //            UILabel * label = [[UILabel alloc] initWithFrame:CGRectZero];
        //            label.tag = kTAG_LABEL;
        //            label.font = [UIFont systemFontOfSize:17];
        //            label.textAlignment = NSTextAlignmentLeft;
        //
        //            label.numberOfLines = 0;
        //            label.userInteractionEnabled = YES;
        //            //        label.backgroundColor = UIColor.greenColor;
        //            label;
        //        });
        objc_setAssociatedObject(self, _cmd, lab, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return lab;
}

-(UILabel *)labelLeftMark{
    UILabel * lab = objc_getAssociatedObject(self, _cmd);
    if (lab == nil) {
        lab = [UIView createLabelWithRect:CGRectZero text:@"" textColor:nil tag:kTAG_LABEL+1 patternType:@"2" font:KFZ_Second backgroudColor:UIColor.whiteColor alignment:NSTextAlignmentLeft];
        
        //        lab = ({
        //            UILabel * label = [[UILabel alloc] initWithFrame:CGRectZero];
        //            label.tag = kTAG_LABEL + 1;
        //            label.font = [UIFont systemFontOfSize:17];
        //            label.textAlignment = NSTextAlignmentLeft;
        //
        //            label.numberOfLines = 0;
        //            label.userInteractionEnabled = YES;
        //            //        label.backgroundColor = UIColor.greenColor;
        //            label;
        //        });
        objc_setAssociatedObject(self, _cmd, lab, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return lab;
}

-(UILabel *)labelLeftSub{
    UILabel * lab = objc_getAssociatedObject(self, _cmd);
    if (lab == nil) {
        lab = [UIView createLabelWithRect:CGRectZero text:@"" textColor:nil tag:kTAG_LABEL+2 patternType:@"2" font:KFZ_Second backgroudColor:UIColor.whiteColor alignment:NSTextAlignmentLeft];
        
        //        lab = ({
        //            UILabel * label = [[UILabel alloc] initWithFrame:CGRectZero];
        //            label.tag = kTAG_LABEL + 2;
        //
        //            label.font = [UIFont systemFontOfSize:17];
        //            //            label.textColor = UIColor.grayColor;
        //            label.textAlignment = NSTextAlignmentLeft;
        //
        //            label.numberOfLines = 0;
        //            label.userInteractionEnabled = YES;
        //            //        label.backgroundColor = UIColor.greenColor;
        //            label;
        //        });
        objc_setAssociatedObject(self, _cmd, lab, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return lab;
}

-(UILabel *)labelLeftSubMark{
    UILabel * lab = objc_getAssociatedObject(self, _cmd);
    if (lab == nil) {
        lab = [UIView createLabelWithRect:CGRectZero text:@"" textColor:nil tag:kTAG_LABEL+3 patternType:@"2" font:KFZ_Second backgroudColor:UIColor.whiteColor alignment:NSTextAlignmentLeft];
        
        //        lab = ({
        //            UILabel * label = [[UILabel alloc] initWithFrame:CGRectZero];
        //            label.tag = kTAG_LABEL + 3;
        //            label.font = [UIFont systemFontOfSize:17];
        //            //            label.textColor = UIColor.grayColor;
        //            label.textAlignment = NSTextAlignmentLeft;
        //
        //            label.numberOfLines = 0;
        //            label.userInteractionEnabled = YES;
        //            //        label.backgroundColor = UIColor.greenColor;
        //            label;
        //        });
        objc_setAssociatedObject(self, _cmd, lab, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return lab;
}

-(UIImageView *)viewIndicator{
    UIImageView * imgV = objc_getAssociatedObject(self, _cmd);
    if (imgV == nil) {
        imgV = ({
            UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectZero];
            imgView.userInteractionEnabled = YES;
            imgView.contentMode = UIViewContentModeScaleAspectFit;
            //            imgView.backgroundColor = UIColor.orangeColor;
            imgV.tag = kTAG_IMGVIEW+2;

            imgView;
        });
        objc_setAssociatedObject(self, _cmd, imgV, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
    }
    return imgV;
}

-(UIImageView *)imgViewLeft{
    UIImageView * imgV = objc_getAssociatedObject(self, _cmd);
    if (imgV == nil) {
        imgV = ({
            UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectZero];
            imgView.userInteractionEnabled = YES;
            imgView.contentMode = UIViewContentModeScaleAspectFit;
            //            imgView.backgroundColor = UIColor.orangeColor;
            imgV.tag = kTAG_IMGVIEW;

            imgView;
        });
        objc_setAssociatedObject(self, _cmd, imgV, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
    }
    return imgV;
}

-(UIImageView *)imgViewRight{
    UIImageView * imgV = objc_getAssociatedObject(self, _cmd);
    if (imgV == nil) {
        imgV = ({
            UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectZero];
            imgView.userInteractionEnabled = YES;
            imgView.contentMode = UIViewContentModeScaleAspectFit;
            //            imgView.backgroundColor = UIColor.orangeColor;
            imgView.frame = CGRectMake(self.width - kX_GAP - kWH_ArrowRight, (self.height - kWH_ArrowRight)/2.0, kWH_ArrowRight, kWH_ArrowRight);
            imgV.tag = kTAG_IMGVIEW + 1;
            imgView.image = [UIImage imageNamed:kIMAGE_arrowRight];
            imgView.hidden = YES;
            imgView;
        });
        objc_setAssociatedObject(self, _cmd, imgV, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
    }
    return imgV;
}

-(UIButton *)btn{
    UIButton * button = objc_getAssociatedObject(self, _cmd);
    if (button == nil) {
        button = [UIView createBtnWithRect:CGRectZero title:@"按钮" font:KFZ_Second image:nil tag:kTAG_BTN patternType:@"7" target:nil aSelector:nil];
//        button = ({
//            UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
//            [btn setTitle:@"btn" forState:UIControlStateNormal];
//            btn.titleLabel.font = [UIFont systemFontOfSize:17];
//            btn.titleLabel.adjustsFontSizeToFitWidth = YES;
//
//            btn.imageView.contentMode = UIViewContentModeScaleAspectFit;
//
//            btn;
//        });
        objc_setAssociatedObject(self, _cmd, button, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
    }
    return button;
    
}

-(void (^)(UITableViewHeaderFooterView *, NSInteger))blockView{
    return objc_getAssociatedObject(self, _cmd);
    
}

-(void)setBlockView:(void (^)(UITableViewHeaderFooterView *, NSInteger))blockView{
    objc_setAssociatedObject(self, @selector(blockView), blockView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);

}


-(BOOL)isCanOPen{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
    
}

-(void)setIsCanOPen:(BOOL)isCanOPen{
    objc_setAssociatedObject(self, @selector(isCanOPen), @(isCanOPen), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}

-(BOOL)isOpen{
    return [objc_getAssociatedObject(self, _cmd) boolValue];

}

-(void)setIsOpen:(BOOL)isOpen{
    objc_setAssociatedObject(self, @selector(isOpen), @(isOpen), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}

@end


@implementation BN_FoldSectionModel

- (NSString *)description{
    //当然，如果你有兴趣知道出类名字和对象的内存地址，也可以像下面这样调用super的description方法
    //    NSString * desc = [super description];
    NSString * desc = @"\n";
    
    unsigned int outCount;
    //获取obj的属性数目
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    
    for (int i = 0; i < outCount; i ++) {
        objc_property_t property = properties[i];
        //获取property的C字符串
        const char * propName = property_getName(property);
        if (propName) {
            //获取NSString类型的property名字
            NSString * prop = [NSString stringWithCString:propName encoding:[NSString defaultCStringEncoding]];
            
            if (![NSClassFromString(prop) isKindOfClass:[NSObject class]]) {
                continue;
            }
            
            //获取property对应的值
            id obj = [self valueForKey:prop];
            //将属性名和属性值拼接起来
            desc = [desc stringByAppendingFormat:@"%@ : %@;\n",prop,obj];
        }
    }
    
    free(properties);
    return desc;
}

-(NSMutableArray *)dataList{
    if (!_dataList) {
        _dataList = [NSMutableArray arrayWithCapacity:0];
        
    }
    return _dataList;
}

@end
