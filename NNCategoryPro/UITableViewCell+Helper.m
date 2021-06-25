//
//  UITableViewCell+Helper.m
//  
//
//  Created by BIN on 2018/1/9.
//  Copyright © 2018年 SHANG. All rights reserved.
//

#import "UITableViewCell+Helper.h"
#import <objc/runtime.h>
#import <NNGloble/NNGloble.h>

#import "NSObject+Helper.h"
#import "UIImage+Helper.h"

#import "UIView+Helper.h"
#import "UILabel+Helper.h"
#import "UIImageView+Helper.h"
#import "UIButton+Helper.h"
#import "UITextField+Helper.h"

@implementation UITableViewCell (Helper)

+(instancetype)cellWithTableView:(UITableView *)tableView identifier:(NSString *)identifier style:(UITableViewCellStyle)style{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(!cell){
        cell = [[self alloc]initWithStyle:style reuseIdentifier:identifier];
    }
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    cell.separatorInset = UIEdgeInsetsZero;
//    cell.layoutMargins = UIEdgeInsetsZero;
    cell.backgroundColor = UIColor.whiteColor;
    return cell;
}

+(instancetype)cellWithTableView:(UITableView *)tableView identifier:(NSString *)identifier{
    return [self cellWithTableView:tableView identifier:NSStringFromClass(self.class) style:UITableViewCellStyleDefault];
}

+(instancetype)cellWithTableView:(UITableView *)tableView{
    return [self cellWithTableView:tableView identifier:NSStringFromClass(self.class)];
}

@end


@implementation UITableViewCell (AddView)

#pragma mark - -layz

- (CGSize)imgViewLeftSize{
    return [objc_getAssociatedObject(self, _cmd) CGSizeValue];
}

- (void)setImgViewLeftSize:(CGSize)imgViewLeftSize{
    objc_setAssociatedObject(self, @selector(imgViewLeftSize), @(imgViewLeftSize), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(UILabel *)labelRight{
    id obj = objc_getAssociatedObject(self, _cmd);
    if (obj) {
        return obj;
    }
    
    UILabel *view = [UILabel createRect:CGRectZero type:NNLabelTypeFitWidth];
    view.textAlignment = NSTextAlignmentRight;
//    view = ({
//        UILabel * view = [[UILabel alloc] initWithFrame:CGRectZero];
//        view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
//        view.font = [UIFont systemFontOfSize:17];
//        view.textAlignment = NSTextAlignmentLeft;
//        view.numberOfLines = 0;
//        view.userInteractionEnabled = true;
//        view.backgroundColor = UIColor.greenColor;
//        view.tag = kTAG_LABEL + 4;
//        view;
//    });
    objc_setAssociatedObject(self, _cmd, view, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    return view;
}

-(void)setLabelRight:(UILabel *)labelRight{
    objc_setAssociatedObject(self, @selector(labelRight), labelRight, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(UILabel *)labelLeft{
    id obj = objc_getAssociatedObject(self, _cmd);
    if (obj) {
        return obj;
    }
    
    UILabel *view = [UILabel createRect:CGRectZero type:NNLabelTypeFitWidth];
    view.textAlignment = NSTextAlignmentLeft;
//    view = ({
//        UILabel * view = [[UILabel alloc] initWithFrame:CGRectZero];
//        view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
//        view.font = [UIFont systemFontOfSize:17];
//        view.textAlignment = NSTextAlignmentLeft;
//        view.numberOfLines = 0;
//        view.userInteractionEnabled = true;
//        view.backgroundColor = UIColor.greenColor;
//        view.tag = kTAG_LABEL;
//        view;
//    });
    objc_setAssociatedObject(self, _cmd, view, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    return view;
}

-(void)setLabelLeft:(UILabel *)labelLeft{
    objc_setAssociatedObject(self, @selector(labelLeft), labelLeft, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(UILabel *)labelLeftMark{
    id obj = objc_getAssociatedObject(self, _cmd);
    if (obj) {
        return obj;
    }
    
    UILabel *view = [UILabel createRect:CGRectZero type:NNLabelTypeFitWidth];
    view.textAlignment = NSTextAlignmentLeft;
//    view = ({
//        UILabel * view = [[UILabel alloc] initWithFrame:CGRectZero];
//        view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
//        view.font = [UIFont systemFontOfSize:17];
//        view.textAlignment = NSTextAlignmentLeft;
//        view.numberOfLines = 0;
//        view.userInteractionEnabled = true;
//        view.backgroundColor = UIColor.greenColor;
//        view.tag = kTAG_LABEL + 1;
//        view;
//    });
    objc_setAssociatedObject(self, _cmd, view, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    return view;
}

- (void)setLabelLeftMark:(UILabel *)labelLeftMark{
    objc_setAssociatedObject(self, @selector(labelLeftMark), labelLeftMark, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(UILabel *)labelLeftSub{
    id obj = objc_getAssociatedObject(self, _cmd);
    if (obj) {
        return obj;
    }
    
    UILabel *view = [UILabel createRect:CGRectZero type:NNLabelTypeFitWidth];
    view.textAlignment = NSTextAlignmentLeft;
//    view = ({
//        UILabel * view = [[UILabel alloc] initWithFrame:CGRectZero];
//        view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
//        view.font = [UIFont systemFontOfSize:17];
//        view.textAlignment = NSTextAlignmentLeft;
//        view.numberOfLines = 0;
//        view.userInteractionEnabled = true;
//        view.backgroundColor = UIColor.greenColor;
//        view.tag = kTAG_LABEL+2;
//        view;
//    });
    objc_setAssociatedObject(self, _cmd, view, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    return view;
}

-(void)setLabelLeftSub:(UILabel *)labelLeftSub{
    objc_setAssociatedObject(self, @selector(labelLeftSub), labelLeftSub, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(UILabel *)labelLeftSubMark{
    id obj = objc_getAssociatedObject(self, _cmd);
    if (obj) {
        return obj;
    }
    
    UILabel *view = [UILabel createRect:CGRectZero type:NNLabelTypeFitWidth];
    view.textAlignment = NSTextAlignmentLeft;
//    view = ({
//        UILabel * view = [[UILabel alloc] initWithFrame:CGRectZero];
//        view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
//        view.font = [UIFont systemFontOfSize:17];
//        view.textAlignment = NSTextAlignmentLeft;
//        view.numberOfLines = 0;
//        view.userInteractionEnabled = true;
//        view.backgroundColor = UIColor.greenColor;
//        view.tag = kTAG_LABEL+3;
//        view;
//    });
    objc_setAssociatedObject(self, _cmd, view, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    return view;
}

-(void)setLabelLeftSubMark:(UILabel *)labelLeftSubMark{
    objc_setAssociatedObject(self, @selector(labelLeftSubMark), labelLeftSubMark, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(UIImageView *)imgViewLeft{
    id obj = objc_getAssociatedObject(self, _cmd);
    if (obj) {
        return obj;
    }
    
    UIImageView *view = ({
        UIImageView *view = [[UIImageView alloc] initWithFrame:CGRectZero];
        view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        view.contentMode = UIViewContentModeScaleAspectFit;
        view.userInteractionEnabled = YES;
        
        view;
    });
    objc_setAssociatedObject(self, _cmd, view, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    return view;
}

-(void)setImgViewLeft:(UIImageView *)imgViewLeft{
    objc_setAssociatedObject(self, @selector(imgViewLeft), imgViewLeft, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(UIImageView *)imgViewRight{
    id obj = objc_getAssociatedObject(self, _cmd);
    if (obj) {
        return obj;
    }
    
    UIImageView *view = ({
        UIImageView *view = [[UIImageView alloc] initWithFrame:CGRectZero];
        view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        view.contentMode = UIViewContentModeScaleAspectFit;
        view.userInteractionEnabled = YES;
        
        view.frame = CGRectMake(self.contentView.maxX - kX_GAP - kSizeArrow.width,
                                (self.contentView.maxY - kSizeArrow.height)/2.0,
                                kSizeArrow.width,
                                kSizeArrow.height);
        view.image = UIImage.img_arrowRight_gray;
        
        view.hidden = YES;
        view;
    });
    objc_setAssociatedObject(self, _cmd, view, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    return view;
}

-(void)setImgViewRight:(UIImageView *)imgViewRight{
    objc_setAssociatedObject(self, @selector(imgViewRight), imgViewRight, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(UIButton *)btn{
    id obj = objc_getAssociatedObject(self, _cmd);
    if (obj) {
        return obj;
    }
    
    UIButton *view = [UIButton createRect:CGRectZero title:@"取消订单" type:NNButtonTypeTitleRedAndOutline];
//    view = ({
//        UIButton * view = [UIButton buttonWithType:UIButtonTypeCustom];
//        [view setTitle:@"按钮标题" forState:UIControlStateNormal];
//        view.titleLabel.font = [UIFont systemFontOfSize:kFontSize16];
//        view.titleLabel.adjustsFontSizeToFitWidth = YES;
//        view.imageView.contentMode = UIViewContentModeScaleAspectFit;
//        view.tag = kTAG_BTN;
//        view;
//    });
    objc_setAssociatedObject(self, _cmd, view, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    return view;
}

-(void)setBtn:(UIButton *)btn{
    objc_setAssociatedObject(self, @selector(btn), btn, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(UIButton *)radioView{
    id obj = objc_getAssociatedObject(self, _cmd);
    if (obj) {
        return obj;
    }
    
    UIButton *view = ({
        UIButton *sender = [UIButton buttonWithType:UIButtonTypeCustom];
//        [sender setTitle:@"按钮标题" forState:UIControlStateNormal];
        sender.titleLabel.font = [UIFont systemFontOfSize:kFontSize16];
        sender.titleLabel.adjustsFontSizeToFitWidth = YES;
        sender.imageView.contentMode = UIViewContentModeScaleAspectFit;
        sender.tag = kTAG_BTN;
        sender;
    });
    
    [view setBackgroundImage:UIImageColor(UIColor.redColor) forState:UIControlStateNormal];
    [view setBackgroundImage:UIImageColor(UIColor.lightGrayColor) forState:UIControlStateSelected];
    
    [view setBackgroundImage:UIImage.btn_selected_NO forState:UIControlStateNormal];
    [view setBackgroundImage:UIImage.btn_selected_YES forState:UIControlStateSelected];
    
    objc_setAssociatedObject(self, _cmd, view, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    return view;
}

- (void)setRadioView:(UIButton *)radioView{
    objc_setAssociatedObject(self, @selector(radioView), radioView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(NNTextField *)textField{
    id obj = objc_getAssociatedObject(self, _cmd);
    if (obj) {
        return obj;
    }
    
    NNTextField *view = [NNTextField createRect:CGRectZero];
    view.font = [UIFont systemFontOfSize:kFontSize16];
    view.tag = kTAG_TEXTFIELD;

    objc_setAssociatedObject(self, _cmd, view, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    return view;
}

-(void)setTextField:(NNTextField *)textField{
    objc_setAssociatedObject(self, @selector(textField), textField, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(UITextView *)textView{
    id obj = objc_getAssociatedObject(self, _cmd);
    if (obj) {
        return obj;
    }
    
    UITextView *view = ({
        UITextView *view = [[UITextView alloc] initWithFrame:CGRectZero];
        view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        view.font = [UIFont systemFontOfSize:kFontSize16];
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
    return view;
}

- (void)setTextView:(UITextView *)textView{
    objc_setAssociatedObject(self, @selector(textView), textView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

//-(UITextField *)textField{
//    UITextView *obj = objc_getAssociatedObject(self, _cmd);
//    if (obj) {
//        return obj;
//    }
//
//    UITextField *view = ({
//        UITextField * view = [[UITextField alloc]initWithFrame:CGRectZero];
//        view.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
//        view.keyboardAppearance = UIKeyboardAppearanceDefault;
//
//        view.returnKeyType = UIReturnKeyDone;
//        view.clearButtonMode = UITextFieldViewModeAlways;
//
//        view.autocapitalizationType = UITextAutocapitalizationTypeNone;
//        view.autocorrectionType = UITextAutocorrectionTypeNo;
//        view.clearButtonMode = UITextFieldViewModeWhileEditing;//清楚键
//        view.layer.borderWidth = 0.5;  // 给图层添加一个有色边框
//        view.layer.borderColor = [UtilityHelper colorWithHexString:@"d2d2d2"].CGColor;
//        view.backgroundColor = UIColor.whiteColor;
//
//        view;
//    });
//    objc_setAssociatedObject(self, _cmd, view, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//    return view;
//}


@end
