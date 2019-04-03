
//
//  UITableViewCell+AddView.m
//  BNSeparatorView
//
//  Created by BIN on 2018/8/23.
//  Copyright © 2018年 BIN. All rights reserved.
//

#import "UITableViewCell+AddView.h"

#import <objc/runtime.h>
#import "BNGloble.h"

#import "UIView+Helper.h"
#import "NSObject+Helper.h"
#import "UIImage+Helper.h"

#import "BNTextField.h"

@implementation UITableViewCell (AddView)

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

-(UILabel *)labelRight{
    UILabel * view = objc_getAssociatedObject(self, _cmd);
    if (!view) {
        view = [UIView createLabelRect:CGRectZero text:@"" font:16 tag:kTAG_LABEL+4 type:@2];
        view.textAlignment = NSTextAlignmentRight;
//        view = ({
//            UILabel * view = [[UILabel alloc] initWithFrame:CGRectZero];
//            view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
//            view.font = [UIFont systemFontOfSize:17];
//            view.textAlignment = NSTextAlignmentLeft;
//            view.numberOfLines = 0;
//            view.userInteractionEnabled = true;
//            //        label.backgroundColor = UIColor.greenColor;
//            view.tag = kTAG_LABEL + 4;
//            view;
//        });
        objc_setAssociatedObject(self, _cmd, view, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return view;
}

-(void)setLabelRight:(UILabel *)labelRight{
    objc_setAssociatedObject(self, @selector(labelRight), labelRight, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(UILabel *)labelLeft{
    UILabel * view = objc_getAssociatedObject(self, _cmd);
    if (!view) {
        view = [UIView createLabelRect:CGRectZero text:@"" font:16 tag:kTAG_LABEL type:@2];
        view.textAlignment = NSTextAlignmentLeft;
//        view = ({
//            UILabel * view = [[UILabel alloc] initWithFrame:CGRectZero];
//            view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
//            view.font = [UIFont systemFontOfSize:17];
//            view.textAlignment = NSTextAlignmentLeft;
//            view.numberOfLines = 0;
//            view.userInteractionEnabled = true;
//            //        label.backgroundColor = UIColor.greenColor;
//            view.tag = kTAG_LABEL;
//            view;
//        });
        objc_setAssociatedObject(self, _cmd, view, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return view;
}

-(void)setLabelLeft:(UILabel *)labelLeft{
    objc_setAssociatedObject(self, @selector(labelLeft), labelLeft, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(UILabel *)labelLeftMark{
    UILabel * view = objc_getAssociatedObject(self, _cmd);
    if (!view) {
        view = [UIView createLabelRect:CGRectZero text:@"" font:16 tag:kTAG_LABEL+1 type:@2];
        view.textAlignment = NSTextAlignmentLeft;
//        view = ({
//            UILabel * view = [[UILabel alloc] initWithFrame:CGRectZero];
//            view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
//            view.font = [UIFont systemFontOfSize:17];
//            view.textAlignment = NSTextAlignmentLeft;
//            view.numberOfLines = 0;
//            view.userInteractionEnabled = true;
//            //        label.backgroundColor = UIColor.greenColor;
//            view.tag = kTAG_LABEL + 1;
//            view;
//        });
        objc_setAssociatedObject(self, _cmd, view, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return view;
}

- (void)setLabelLeftMark:(UILabel *)labelLeftMark{
    objc_setAssociatedObject(self, @selector(labelLeftMark), labelLeftMark, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(UILabel *)labelLeftSub{
    UILabel * view = objc_getAssociatedObject(self, _cmd);
    if (!view) {
        view = [UIView createLabelRect:CGRectZero text:@"" font:16 tag:kTAG_LABEL+2 type:@2];
        view.textAlignment = NSTextAlignmentLeft;
//        view = ({
//            UILabel * view = [[UILabel alloc] initWithFrame:CGRectZero];
//            view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
//            view.font = [UIFont systemFontOfSize:17];
//            view.textAlignment = NSTextAlignmentLeft;
//            view.numberOfLines = 0;
//            view.userInteractionEnabled = true;
//            //        label.backgroundColor = UIColor.greenColor;
//            view.tag = kTAG_LABEL+2;
//            view;
//        });
        objc_setAssociatedObject(self, _cmd, view, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return view;
}

-(void)setLabelLeftSub:(UILabel *)labelLeftSub{
    objc_setAssociatedObject(self, @selector(labelLeftSub), labelLeftSub, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(UILabel *)labelLeftSubMark{
    UILabel * view = objc_getAssociatedObject(self, _cmd);
    if (!view) {
        view = [UIView createLabelRect:CGRectZero text:@"" font:16 tag:kTAG_LABEL+3 type:@2];
        view.textAlignment = NSTextAlignmentLeft;
//        view = ({
//            UILabel * view = [[UILabel alloc] initWithFrame:CGRectZero];
//            view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
//            view.font = [UIFont systemFontOfSize:17];
//            view.textAlignment = NSTextAlignmentLeft;
//            view.numberOfLines = 0;
//            view.userInteractionEnabled = true;
//            //        label.backgroundColor = UIColor.greenColor;
//            view.tag = kTAG_LABEL+3;
//            view;
//        });
        objc_setAssociatedObject(self, _cmd, view, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return view;
}

-(void)setLabelLeftSubMark:(UILabel *)labelLeftSubMark{
    objc_setAssociatedObject(self, @selector(labelLeftSubMark), labelLeftSubMark, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(UIImageView *)imgViewLeft{
    UIImageView * view = objc_getAssociatedObject(self, _cmd);
    if (!view) {
        view = ({
            UIImageView *view = [[UIImageView alloc] initWithFrame:CGRectZero];
            view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
            view.contentMode = UIViewContentModeScaleAspectFit;
            view.userInteractionEnabled = YES;
            
            view;
        });
        objc_setAssociatedObject(self, _cmd, view, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
    }
    return view;
}

-(void)setImgViewLeft:(UIImageView *)imgViewLeft{
    objc_setAssociatedObject(self, @selector(imgViewLeft), imgViewLeft, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(UIImageView *)imgViewRight{
    UIImageView * view = objc_getAssociatedObject(self, _cmd);
    if (!view) {
        view = ({
            UIImageView *view = [[UIImageView alloc] initWithFrame:CGRectZero];
            view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
            view.contentMode = UIViewContentModeScaleAspectFit;
            view.userInteractionEnabled = YES;
            //            imgView.backgroundColor = UIColor.orangeColor;
            view.frame = CGRectMake(self.contentView.maxX - kX_GAP - kSizeArrow.width, (self.contentView.maxY - kSizeArrow.height)/2.0, kSizeArrow.width, kSizeArrow.height);
            view.image = [UIImage imageNamed:kIMG_arrowRight];
            
            view.hidden = YES;
            view;
        });
        objc_setAssociatedObject(self, _cmd, view, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return view;
}

-(void)setImgViewRight:(UIImageView *)imgViewRight{
    objc_setAssociatedObject(self, @selector(imgViewRight), imgViewRight, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(UIButton *)btn{
    UIButton * view = objc_getAssociatedObject(self, _cmd);
    if (!view) {
        view = [UIView createBtnRect:CGRectZero title:@"取消订单" font:16 image:nil tag:kTAG_BTN type:@7];
//        view = ({
//            UIButton * view = [UIButton buttonWithType:UIButtonTypeCustom];
//            [view setTitle:@"按钮标题" forState:UIControlStateNormal];
//            view.titleLabel.font = [UIFont systemFontOfSize:kFZ_Second];
//            view.titleLabel.adjustsFontSizeToFitWidth = YES;
//            view.imageView.contentMode = UIViewContentModeScaleAspectFit;
//            view.tag = kTAG_BTN;
//            view;
//        });
        objc_setAssociatedObject(self, _cmd, view, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
    }
    return view;
}

-(void)setBtn:(UIButton *)btn{
    objc_setAssociatedObject(self, @selector(btn), btn, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(UIButton *)radioView{
    id view =  objc_getAssociatedObject(self, _cmd);
    if (!view) {
        view = ({
            UIButton * view = [UIButton buttonWithType:UIButtonTypeCustom];
            //            [view setTitle:@"按钮标题" forState:UIControlStateNormal];
            view.titleLabel.font = [UIFont systemFontOfSize:kFZ_Second];
            view.titleLabel.adjustsFontSizeToFitWidth = YES;
            view.imageView.contentMode = UIViewContentModeScaleAspectFit;
            view.tag = kTAG_BTN;
            view;
        });
        
        [view setBackgroundImage:UIImageColor(UIColor.redColor) forState:UIControlStateNormal];
        [view setBackgroundImage:UIImageColor(UIColor.lightGrayColor) forState:UIControlStateSelected];
        
        [view setBackgroundImage:UIImageNamed(kIMG_selected_NO) forState:UIControlStateNormal];
        [view setBackgroundImage:UIImageNamed(kIMG_selected_YES) forState:UIControlStateSelected];
        
        objc_setAssociatedObject(self, _cmd, view, OBJC_ASSOCIATION_RETAIN_NONATOMIC);

    }
    return view;
}

- (void)setRadioView:(UIButton *)radioView{
    objc_setAssociatedObject(self, @selector(radioView), radioView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(BNTextField *)textField{
    BNTextField * view = objc_getAssociatedObject(self, _cmd);
    if (!view) {
        view = [UIView createTextFieldRect:CGRectZero text:@"" placeholder:nil font:kFZ_Second textAlignment:NSTextAlignmentLeft keyboardType:UIKeyboardTypeDefault];
        view.tag = kTAG_TEXTFIELD;

        objc_setAssociatedObject(self, _cmd, view, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return view;
}

-(void)setTextField:(BNTextField *)textField{
    objc_setAssociatedObject(self, @selector(textField), textField, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(UITextView *)textView{
    UITextView * view = objc_getAssociatedObject(self, _cmd);
    if (!view) {
        view = ({
            UITextView *view = [[UITextView alloc] initWithFrame:CGRectZero];
            view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
            view.font = [UIFont systemFontOfSize:kFZ_Third];
            view.textAlignment = NSTextAlignmentLeft;
            
            view.keyboardAppearance = UIKeyboardAppearanceDefault;
            view.returnKeyType = UIReturnKeyDone;
            
            view.autocorrectionType = UITextAutocorrectionTypeNo;
            view.autocapitalizationType = UITextAutocapitalizationTypeNone;
            
            view.layer.borderWidth = kW_LayerBorder;
            view.layer.borderColor = UIColor.lineColor.CGColor;
//            [view scrollRectToVisible:rect animated:YES];
            view;
        });
        objc_setAssociatedObject(self, _cmd, view, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
    }
    return view;
}

- (void)setTextView:(UITextView *)textView{
    objc_setAssociatedObject(self, @selector(textView), textView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

//-(UITextField *)textField{
//    UITextField * view = objc_getAssociatedObject(self, _cmd);
//    if (!view) {
//        view = ({
//            UITextField * view = [[UITextField alloc]initWithFrame:CGRectZero];
//            view.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
//            view.keyboardAppearance = UIKeyboardAppearanceDefault;
//
//            //        view.returnKeyType = UIReturnKeyDone;
//            //        view.clearButtonMode = UITextFieldViewModeAlways;
//
//            view.autocapitalizationType = UITextAutocapitalizationTypeNone;
//            view.autocorrectionType = UITextAutocorrectionTypeNo;
//            view.clearButtonMode = UITextFieldViewModeWhileEditing;//清楚键
//            //        view.layer.borderWidth = 0.5;  // 给图层添加一个有色边框
//            //        view.layer.borderColor = [UtilityHelper colorWithHexString:@"d2d2d2"].CGColor;
//            view.backgroundColor = UIColor.whiteColor;
//
//            view;
//        });
//        objc_setAssociatedObject(self, _cmd, view, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//
//    }
//    return view;
//}


@end
