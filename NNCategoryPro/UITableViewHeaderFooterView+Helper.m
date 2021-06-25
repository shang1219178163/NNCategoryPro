
//
//  UITableViewHeaderFooterView+Helper.m
//  
//
//  Created by BIN on 2018/8/24.
//  Copyright © 2018年 SHANG. All rights reserved.
//

#import "UITableViewHeaderFooterView+Helper.h"
#import <objc/runtime.h>

#import <NNGloble/NNGloble.h>
#import "UIView+AddView.h"
#import "UIView+Helper.h"
#import "UIButton+Helper.h"
#import "UILabel+Helper.h"
#import "UIScreen+Helper.h"
#import "UIColor+Helper.h"
#import "UIImage+Helper.h"


@implementation UITableViewHeaderFooterView (Helper)

+(instancetype)dequeueReusableHeaderFooterView:(UITableView *)tableView identifier:(NSString *)identifier{
    UITableViewHeaderFooterView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:identifier];
    if (!view) {
        view = [[self alloc] initWithReuseIdentifier:identifier];
    }
    return view;
}

+(instancetype)dequeueReusableHeaderFooterView:(UITableView *)tableView{
    NSString *identifier = NSStringFromClass(self.class);
    return [self dequeueReusableHeaderFooterView:tableView identifier:identifier];
}

@end


@implementation UITableViewHeaderFooterView (AddView)

@dynamic imgViewLeft, imgViewRight, indicatorView, labelLeft,
labelLeftSub, labelLeftMark, labelLeftSubMark, btn;

#pragma mark --layz

-(UILabel *)labelLeft{
    id obj = objc_getAssociatedObject(self, _cmd);
    if (obj) {
        return obj;
    }
    
    UILabel *view = [UILabel createRect:CGRectZero type:NNLabelTypeFitWidth];
    view.textAlignment = NSTextAlignmentRight;
//    view = ({
//        UILabel * view = [[UILabel alloc] initWithFrame:CGRectZero];
//        view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
//
//        view.font = [UIFont systemFontOfSize:17];
//        view.textColor = UIColor.grayColor;
//        view.textAlignment = NSTextAlignmentCenter;
//
//        view.numberOfLines = 0;
//        view.userInteractionEnabled = YES;
//        view.backgroundColor = UIColor.greenColor;
//        view.tag = kTAG_LABEL;
//        view;
//      });
    objc_setAssociatedObject(self, _cmd, view, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    return view;
}

- (void)setLabelLeft:(UILabel *)labelLeft{
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
//
//        view.font = [UIFont systemFontOfSize:15];
//        view.textColor = UIColor.grayColor;
//        view.textAlignment = NSTextAlignmentCenter;
//
//        view.numberOfLines = 0;
//        view.userInteractionEnabled = YES;
//        //            view.backgroundColor = UIColor.greenColor;
//        view.tag = kTAG_LABEL+1;
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
//
//        view.font = [UIFont systemFontOfSize:15];
//        view.textColor = UIColor.grayColor;
//        view.textAlignment = NSTextAlignmentCenter;
//
//        view.numberOfLines = 0;
//        view.userInteractionEnabled = YES;
//        //            view.backgroundColor = UIColor.greenColor;
//        view.tag = kTAG_LABEL+2;
//        view;
//    });
    objc_setAssociatedObject(self, _cmd, view, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    return view;
}

- (void)setLabelLeftSub:(UILabel *)labelLeftSub{
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
//
//        view.font = [UIFont systemFontOfSize:15];
//        view.textColor = UIColor.grayColor;
//        view.textAlignment = NSTextAlignmentCenter;
//
//        view.numberOfLines = 0;
//        view.userInteractionEnabled = YES;
//        //            view.backgroundColor = UIColor.greenColor;
//        view.tag = kTAG_LABEL+3;
//        view;
//    });
    objc_setAssociatedObject(self, _cmd, view, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    return view;
}

-(void)setLabelLeftSubMark:(UILabel *)labelLeftSubMark{
    objc_setAssociatedObject(self, @selector(labelLeftSubMark), labelLeftSubMark, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(UIImageView *)indicatorView{
    id obj = objc_getAssociatedObject(self, _cmd);
    if (obj) {
        return obj;
    }
    
    UIImageView *imgV = ({
        UIImageView *view = [[UIImageView alloc] initWithFrame:CGRectZero];
        view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        view.contentMode = UIViewContentModeScaleAspectFit;
        view.userInteractionEnabled = YES;
        view.tag = kTAG_IMGVIEW+2;

        view;
    });
    objc_setAssociatedObject(self, _cmd, imgV, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    return imgV;
}

- (void)setIndicatorView:(UIImageView *)indicatorView{
    objc_setAssociatedObject(self, @selector(indicatorView), indicatorView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
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
        view.tag = kTAG_IMGVIEW;

        view;
    });
    objc_setAssociatedObject(self, _cmd, view, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    return view;
}

- (void)setImgViewLeft:(UIImageView *)imgViewLeft{
    objc_setAssociatedObject(self, @selector(imgViewLeft), imgViewLeft, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(UIImageView *)imgViewRight{
    id obj = objc_getAssociatedObject(self, _cmd);
    if (obj) {
        return obj;
    }
    
    UIImageView *imgV = ({
        UIImageView *view = [[UIImageView alloc] initWithFrame:CGRectZero];
        view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        view.contentMode = UIViewContentModeScaleAspectFit;
        view.userInteractionEnabled = YES;
        //            imgView.backgroundColor = UIColor.orangeColor;
        view.frame = CGRectMake(self.maxX - kX_GAP - kSizeArrow.width, (self.maxY - kSizeArrow.height)/2.0, kSizeArrow.width, kSizeArrow.height);

        view.tag = kTAG_IMGVIEW + 1;
        view.image = UIImage.img_arrowRight_gray;
        
        view.hidden = YES;
        view;
    });
    objc_setAssociatedObject(self, _cmd, imgV, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    return imgV;
}

- (void)setImgViewRight:(UIImageView *)imgViewRight{
    objc_setAssociatedObject(self, @selector(imgViewRight), imgViewRight, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(UIButton *)btn{
    id obj = objc_getAssociatedObject(self, _cmd);
    if (obj) {
        return obj;
    }
    
    UIButton *view = [UIButton createRect:CGRectZero title:@"按钮" type:NNButtonTypeTitleRedAndOutline];
//    view = ({
//        UIButton * view = [UIButton buttonWithType:UIButtonTypeCustom];
//        [view setTitle:@"btn" forState:UIControlStateNormal];
//        view.titleLabel.font = [UIFont systemFontOfSize:17];
//        view.titleLabel.adjustsFontSizeToFitWidth = YES;
//
//        view.imageView.contentMode = UIViewContentModeScaleAspectFit;
//
//        view;
//    });
    objc_setAssociatedObject(self, _cmd, view, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    return view;
} 

- (void)setBtn:(UIButton *)btn{
    objc_setAssociatedObject(self, @selector(btn), btn, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(void (^)(UITableViewHeaderFooterView *, NSInteger))blockView{
    return objc_getAssociatedObject(self, _cmd);
}

-(void)setBlockView:(void (^)(UITableViewHeaderFooterView *, NSInteger))blockView{
    objc_setAssociatedObject(self, @selector(blockView), blockView, OBJC_ASSOCIATION_COPY_NONATOMIC);
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


