
//
//  UITableViewCell+AddView.m
//  BN_SeparatorView
//
//  Created by BIN on 2018/8/23.
//  Copyright © 2018年 BIN. All rights reserved.
//

#import "UITableViewCell+AddView.h"

#import <objc/runtime.h>

#import "BN_Globle.h"

#import "UIView+Helper.h"
#import "NSObject+Helper.h"

#import "BN_TextField.h"
#import "BN_TextView.h"
#import "BN_RadioView.h"

@implementation UITableViewCell (AddView)

@dynamic labelRight,labelLeft,labelLeftMark,labelLeftSub,labelLeftSubMark,imgViewLeft,imgViewRight,btn,textField,textView,radioView;

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
//    NSString *identifier = NSStringFromClass(self.class);
    return [self cellWithTableView:tableView identifier:self.identifier];
}

+(NSString *)identifier{
    id obj = objc_getAssociatedObject(self, _cmd);
    if (!obj) {
        obj = NSStringFromClass(self.class);
        objc_setAssociatedObject(self, @selector(identifier), obj, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
    }
    return obj;
}

#pragma mark - -layz

- (CGSize)imgViewLeftSize{
    return [objc_getAssociatedObject(self, _cmd) CGSizeValue];
}

- (void)setImgViewLeftSize:(CGSize)imgViewLeftSize{
    objc_setAssociatedObject(self, @selector(imgViewLeftSize), @(imgViewLeftSize), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(void)setLabelRight:(UILabel *)labelRight{
    objc_setAssociatedObject(self, @selector(labelRight), labelRight, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(UILabel *)labelRight{
    UILabel * lab = objc_getAssociatedObject(self, _cmd);
    if (!lab) {
        lab = [UIView createLabelRect:CGRectZero text:@"" textColor:nil tag:kTAG_LABEL+4 type:@2 font:kFZ_Second backgroudColor:UIColor.whiteColor alignment:NSTextAlignmentRight];

//        lab = ({
//            UILabel * label = [[UILabel alloc] initWithFrame:CGRectZero];
//            label.tag = kTAG_LABEL + 4;
//            label.font = [UIFont systemFontOfSize:17];
//            label.textAlignment = NSTextAlignmentRight;
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

-(void)setLabelLeft:(UILabel *)labelLeft{
    objc_setAssociatedObject(self, @selector(labelLeft), labelLeft, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(UILabel *)labelLeft{
    UILabel * lab = objc_getAssociatedObject(self, _cmd);
    if (!lab) {
        lab = [UIView createLabelRect:CGRectZero text:@"" textColor:nil tag:kTAG_LABEL type:@2 font:kFZ_Second backgroudColor:UIColor.whiteColor alignment:NSTextAlignmentLeft];

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

- (void)setLabelLeftMark:(UILabel *)labelLeftMark{
    objc_setAssociatedObject(self, @selector(labelLeftMark), labelLeftMark, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}

-(UILabel *)labelLeftMark{
    UILabel * lab = objc_getAssociatedObject(self, _cmd);
    if (!lab) {
        lab = [UIView createLabelRect:CGRectZero text:@"" textColor:nil tag:kTAG_LABEL+1 type:@2 font:kFZ_Second backgroudColor:UIColor.whiteColor alignment:NSTextAlignmentLeft];

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

-(void)setLabelLeftSub:(UILabel *)labelLeftSub{
    objc_setAssociatedObject(self, @selector(labelLeftSub), labelLeftSub, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(UILabel *)labelLeftSub{
    UILabel * lab = objc_getAssociatedObject(self, _cmd);
    if (!lab) {
        lab = [UIView createLabelRect:CGRectZero text:@"" textColor:nil tag:kTAG_LABEL+2 type:@2 font:kFZ_Second backgroudColor:UIColor.whiteColor alignment:NSTextAlignmentLeft];

//        lab = ({
//            UILabel * label = [[UILabel alloc] initWithFrame:CGRectZero];
//            label.tag = kTAG_LABEL + 2;
//
//            label.font = [UIFont systemFontOfSize:17];
//            label.textColor = UIColor.grayColor;
//            label.textAlignment = NSTextAlignmentLeft;
//
//            label.numberOfLines = 0;
//            label.userInteractionEnabled = YES;
//            label.backgroundColor = UIColor.greenColor;
//            label;
//        });
        objc_setAssociatedObject(self, _cmd, lab, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return lab;
}

-(void)setLabelLeftSubMark:(UILabel *)labelLeftSubMark{
    objc_setAssociatedObject(self, @selector(labelLeftSubMark), labelLeftSubMark, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(UILabel *)labelLeftSubMark{
    UILabel * lab = objc_getAssociatedObject(self, _cmd);
    if (!lab) {
        lab = [UIView createLabelRect:CGRectZero text:@"" textColor:nil tag:kTAG_LABEL+3 type:@2 font:kFZ_Second backgroudColor:UIColor.whiteColor alignment:NSTextAlignmentLeft];

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

-(void)setImgViewLeft:(UIImageView *)imgViewLeft{
    objc_setAssociatedObject(self, @selector(imgViewLeft), imgViewLeft, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(UIImageView *)imgViewLeft{
    UIImageView * imgV = objc_getAssociatedObject(self, _cmd);
    if (!imgV) {
        imgV = ({
            UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectZero];
            imgView.userInteractionEnabled = YES;
            imgView.contentMode = UIViewContentModeScaleAspectFit;
            //            imgView.backgroundColor = UIColor.orangeColor;
            
            imgView;
        });
        objc_setAssociatedObject(self, _cmd, imgV, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
    }
    return imgV;
}

-(void)setImgViewRight:(UIImageView *)imgViewRight{
    objc_setAssociatedObject(self, @selector(imgViewRight), imgViewRight, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(UIImageView *)imgViewRight{
    UIImageView * imgV = objc_getAssociatedObject(self, _cmd);
    if (!imgV) {
        imgV = ({
            UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectZero];
            imgView.userInteractionEnabled = YES;
            imgView.contentMode = UIViewContentModeScaleAspectFit;
            //            imgView.backgroundColor = UIColor.orangeColor;
            imgView.frame = CGRectMake(self.contentView.maxX - kX_GAP - kWH_ArrowRight, (self.contentView.maxY - kWH_ArrowRight)/2.0, kWH_ArrowRight, kWH_ArrowRight);
            imgView.image = [UIImage imageNamed:kIMG_arrowRight];
            
            imgView.hidden = YES;
            imgView;
        });
        objc_setAssociatedObject(self, _cmd, imgV, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
    }
    return imgV;
}

-(void)setBtn:(UIButton *)btn{
    objc_setAssociatedObject(self, @selector(btn), btn, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(UIButton *)btn{
    UIButton * button = objc_getAssociatedObject(self, _cmd);
    if (!button) {
        button = [UIView createBtnRect:CGRectZero title:@"取消订单" font:kFZ_Second image:nil tag:kTAG_BTN type:@7 target:nil aSelector:nil];
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

-(void)setTextField:(BN_TextField *)textField{
    objc_setAssociatedObject(self, @selector(textField), textField, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(BN_TextField *)textField{
    BN_TextField * textField = objc_getAssociatedObject(self, _cmd);
    if (!textField) {
        textField = [UIView createTextFieldRect:CGRectZero text:@"" placeholder:nil font:kFZ_Second textAlignment:NSTextAlignmentLeft keyboardType:UIKeyboardTypeDefault];
        textField.tag = kTAG_TEXTFIELD;

        objc_setAssociatedObject(self, _cmd, textField, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
    }
    return textField;
}

-(void)setTextView:(BN_TextView *)textView{
    objc_setAssociatedObject(self, @selector(textView), textView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(BN_TextView *)textView{
    BN_TextView * tv = objc_getAssociatedObject(self, _cmd);
    if (!tv) {
        tv = [UIView createTextViewRect:CGRectZero text:@"" placeholder:nil font:kFZ_Third textAlignment:NSTextAlignmentLeft keyType:UIKeyboardTypeDefault];
        
        objc_setAssociatedObject(self, _cmd, tv, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
    }
    return tv;
}

- (void)setRadioView:(BN_RadioView *)radioView{
    objc_setAssociatedObject(self, @selector(radioView), radioView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(BN_RadioView *)radioView{
    BN_RadioView * view = objc_getAssociatedObject(self, _cmd);
    if (!view) {
        NSDictionary * dic = @{
                               kRadio_imageN    :   kIMG_selected_NO,
                               kRadio_imageH    :   kIMG_selected_YES,
                               };
        
        view = [[BN_RadioView alloc]initWithFrame:CGRectZero attDict:dic isSelected:NO];
        view.tag  = kTAG_VIEW_RADIO;
        objc_setAssociatedObject(self, _cmd, view, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
    }
    return view;
}

//-(UITextField *)textField{
//    UITextField * textField = objc_getAssociatedObject(self, _cmd);
//    if (!textField) {
//        textField = ({
//            UITextField * textField = [[UITextField alloc]initWithFrame:CGRectZero];
//            textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
//            textField.keyboardAppearance = UIKeyboardAppearanceDefault;
//
//            //        textField.returnKeyType = UIReturnKeyDone;
//            //        textField.clearButtonMode = UITextFieldViewModeAlways;
//
//            textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
//            textField.autocorrectionType = UITextAutocorrectionTypeNo;
//            textField.clearButtonMode = UITextFieldViewModeWhileEditing;//清楚键
//            //        textField.layer.borderWidth = 0.5;  // 给图层添加一个有色边框
//            //        textField.layer.borderColor = [UtilityHelper colorWithHexString:@"d2d2d2"].CGColor;
//            textField.backgroundColor = UIColor.whiteColor;
//
//            textField;
//        });
//        objc_setAssociatedObject(self, _cmd, textField, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//
//    }
//    return textField;
//}
//
//-(UITextView *)textView{
//    UITextView * tv = objc_getAssociatedObject(self, _cmd);
//    if (!tv) {
//        tv = ({
//            UITextView *textView = [[UITextView alloc] initWithFrame:CGRectZero];
//
//            textView.font = [UIFont systemFontOfSize:17];
//            textView.textAlignment = NSTextAlignmentLeft;
//
//            textView.keyboardAppearance = UIKeyboardAppearanceDefault;
//            textView.returnKeyType = UIReturnKeyDone;
//
//            textView.autocorrectionType = UITextAutocorrectionTypeNo;
//            textView.autocapitalizationType = UITextAutocapitalizationTypeNone;
//
//            //            textView.layer.borderWidth = 0.5;
//            //            textView.layer.borderColor = UIColor.lineColor.CGColor;
//            //            [textView scrollRectToVisible:rect animated:YES];
//            textView;
//        });
//        objc_setAssociatedObject(self, _cmd, tv, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//
//    }
//    return tv;
//}


@end
