
//
//  UITableViewHeaderFooterView+AddView.m
//  
//
//  Created by BIN on 2018/8/24.
//  Copyright © 2018年 SHANG. All rights reserved.
//

#import "UITableViewHeaderFooterView+AddView.h"

#import "BNGloble.h"
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
    NSString *identifier = NSStringFromClass(self.class);
    return [self viewWithTableView:tableView identifier:identifier];
}

#pragma mark -- layz

-(UILabel *)labelLeft{
    UILabel * view = objc_getAssociatedObject(self, _cmd);
    if (!view) {
        view = [UIView createLabelRect:CGRectZero text:@"" font:16 tag:kTAG_LABEL type:@2];
        view.textAlignment = NSTextAlignmentRight;
//        view = ({
//            UILabel * view = [[UILabel alloc] initWithFrame:CGRectZero];
//            view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
//
//            view.font = [UIFont systemFontOfSize:17];
//            view.textColor = UIColor.grayColor;
//            view.textAlignment = NSTextAlignmentCenter;
//
//            view.numberOfLines = 0;
//            view.userInteractionEnabled = YES;
//            //            view.backgroundColor = UIColor.greenColor;
//            view.tag = kTAG_LABEL;
//            view;
//          });
        objc_setAssociatedObject(self, _cmd, view, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return view;
}

- (void)setLabelLeft:(UILabel *)labelLeft{
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
//
//            view.font = [UIFont systemFontOfSize:15];
//            view.textColor = UIColor.grayColor;
//            view.textAlignment = NSTextAlignmentCenter;
//
//            view.numberOfLines = 0;
//            view.userInteractionEnabled = YES;
//            //            view.backgroundColor = UIColor.greenColor;
//            view.tag = kTAG_LABEL+1;
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
//
//            view.font = [UIFont systemFontOfSize:15];
//            view.textColor = UIColor.grayColor;
//            view.textAlignment = NSTextAlignmentCenter;
//
//            view.numberOfLines = 0;
//            view.userInteractionEnabled = YES;
//            //            view.backgroundColor = UIColor.greenColor;
//            view.tag = kTAG_LABEL+2;
//            view;
//        });
        objc_setAssociatedObject(self, _cmd, view, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return view;
}

- (void)setLabelLeftSub:(UILabel *)labelLeftSub{
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
//
//            view.font = [UIFont systemFontOfSize:15];
//            view.textColor = UIColor.grayColor;
//            view.textAlignment = NSTextAlignmentCenter;
//
//            view.numberOfLines = 0;
//            view.userInteractionEnabled = YES;
//            //            view.backgroundColor = UIColor.greenColor;
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

-(UIImageView *)viewIndicator{
    UIImageView * imgV = objc_getAssociatedObject(self, _cmd);
    if (!imgV) {
        imgV = ({
            UIImageView *view = [[UIImageView alloc] initWithFrame:CGRectZero];
            view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
            view.contentMode = UIViewContentModeScaleAspectFit;
            view.userInteractionEnabled = YES;
//            imgView.backgroundColor = UIColor.orangeColor;
            imgV.tag = kTAG_IMGVIEW+2;

            view;
        });
        objc_setAssociatedObject(self, _cmd, imgV, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return imgV;
}

- (void)setViewIndicator:(UIImageView *)viewIndicator{
    objc_setAssociatedObject(self, @selector(viewIndicator), viewIndicator, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(UIImageView *)imgViewLeft{
    UIImageView * view = objc_getAssociatedObject(self, _cmd);
    if (!view) {
        view = ({
            UIImageView *view = [[UIImageView alloc] initWithFrame:CGRectZero];
            view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
            view.contentMode = UIViewContentModeScaleAspectFit;
            view.userInteractionEnabled = YES;
            //            imgView.backgroundColor = UIColor.orangeColor;
            view.tag = kTAG_IMGVIEW;

            view;
        });
        objc_setAssociatedObject(self, _cmd, view, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return view;
}

- (void)setImgViewLeft:(UIImageView *)imgViewLeft{
    objc_setAssociatedObject(self, @selector(imgViewLeft), imgViewLeft, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(UIImageView *)imgViewRight{
    UIImageView * imgV = objc_getAssociatedObject(self, _cmd);
    if (!imgV) {
        imgV = ({
            UIImageView *view = [[UIImageView alloc] initWithFrame:CGRectZero];
            view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
            view.contentMode = UIViewContentModeScaleAspectFit;
            view.userInteractionEnabled = YES;
            //            imgView.backgroundColor = UIColor.orangeColor;
            view.frame = CGRectMake(self.maxX - kX_GAP - kSizeArrow.width, (self.maxY - kSizeArrow.height)/2.0, kSizeArrow.width, kSizeArrow.height);

            imgV.tag = kTAG_IMGVIEW + 1;
            view.image = [UIImage imageNamed:kIMG_arrowRight];
            
            view.hidden = YES;
            view;
        });
        objc_setAssociatedObject(self, _cmd, imgV, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return imgV;
}

- (void)setImgViewRight:(UIImageView *)imgViewRight{
    objc_setAssociatedObject(self, @selector(imgViewRight), imgViewRight, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(UIButton *)btn{
    UIButton * view = objc_getAssociatedObject(self, _cmd);
    if (!view) {
        view = [UIView createBtnRect:CGRectZero title:@"按钮" font:16 image:nil tag:kTAG_BTN type:@7];
//        view = ({
//            UIButton * view = [UIButton buttonWithType:UIButtonTypeCustom];
//            [view setTitle:@"btn" forState:UIControlStateNormal];
//            view.titleLabel.font = [UIFont systemFontOfSize:17];
//            view.titleLabel.adjustsFontSizeToFitWidth = YES;
//
//            view.imageView.contentMode = UIViewContentModeScaleAspectFit;
//
//            view;
//        });
        objc_setAssociatedObject(self, _cmd, view, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
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


@implementation BNFoldSectionModel

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
