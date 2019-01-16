
//
//  UICollectionReusableView+AddView.m
//  
//
//  Created by BIN on 2018/8/24.
//  Copyright © 2018年 SHANG. All rights reserved.
//

#import "UICollectionReusableView+AddView.h"

#import <objc/runtime.h>
#import "BN_Globle.h"

@implementation UICollectionReusableView (AddView)

+ (instancetype)viewWithCollectionView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath kind:(NSString *)kind{
    
    NSString *kindSuf = [kind componentsSeparatedByString:@"KindSection"].lastObject;
    NSString *identifier = [NSStringFromClass(self.class) stringByAppendingString:kindSuf];
    UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:identifier forIndexPath:indexPath];
    
    view.label.text = [kindSuf stringByAppendingFormat:@"%@",@(indexPath.section)];
    view.backgroundColor = [kind isEqualToString:UICollectionElementKindSectionHeader] ? UIColor.greenColor : UIColor.yellowColor;
    view.backgroundColor = UIColor.whiteColor;
    return view;
}

//+ (instancetype)viewWithCollectionView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath kind:(NSString *)kind{
//    NSString * identifier = [UICollectionView viewIdentifierByClassName:NSStringFromClass(self.class) kind:kind];
//    UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:identifier forIndexPath:indexPath];
//
//    NSString * titleHeader = [NSString stringWithFormat:@"HeaderView_%@",@(indexPath.section)];
//    NSString * titleFooter = [NSString stringWithFormat:@"FooterView_%@",@(indexPath.section)];
//    view.label.text = [kind isEqualToString:UICollectionElementKindSectionHeader]  ? titleHeader: titleFooter;
//    view.backgroundColor = [kind isEqualToString:UICollectionElementKindSectionHeader] ? UIColor.greenColor : UIColor.yellowColor;
//    view.backgroundColor = UIColor.whiteColor;
//    return view;
//}

-(UIImageView *)imgView{
    UIImageView * view = objc_getAssociatedObject(self, _cmd);
    if (!view) {
        view = ({
            UIImageView *view = [[UIImageView alloc] initWithFrame:CGRectZero];
            view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
            view.contentMode = UIViewContentModeScaleAspectFit;
            view.userInteractionEnabled = YES;
            view.tag = kTAG_IMGVIEW;
            view;
        });
        objc_setAssociatedObject(self, _cmd, view, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
    }
    return view;
}

- (void)setImgView:(UIImageView *)imgView{
    objc_setAssociatedObject(self, @selector(imgView), imgView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(UILabel *)label{
    UILabel * view = objc_getAssociatedObject(self, _cmd);
    if (!view) {
        view = ({
            UILabel * view = [[UILabel alloc] initWithFrame:CGRectZero];
            view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
            
            view.font = [UIFont systemFontOfSize:15];
            view.textColor = UIColor.grayColor;
            view.textAlignment = NSTextAlignmentCenter;
            
            view.numberOfLines = 0;
            view.userInteractionEnabled = YES;
            view.backgroundColor = UIColor.greenColor;
            view.tag = kTAG_LABEL;
            view;
        });
        objc_setAssociatedObject(self, _cmd, view, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return view;
}

- (void)setLabel:(UILabel *)label{
    objc_setAssociatedObject(self, @selector(label), label, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(UILabel *)labelSub{
    UILabel * view = objc_getAssociatedObject(self, _cmd);
    if (!view) {
        view = ({
            UILabel * view = [[UILabel alloc] initWithFrame:CGRectZero];
            view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
            
            view.font = [UIFont systemFontOfSize:15];
            view.textColor = UIColor.grayColor;
            view.textAlignment = NSTextAlignmentCenter;
            
            view.numberOfLines = 0;
            view.userInteractionEnabled = YES;
            view.backgroundColor = UIColor.greenColor;
            view.tag = kTAG_LABEL + 1;
            view;
        });
        objc_setAssociatedObject(self, _cmd, view, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return view;
}

- (void)setLabelSub:(UILabel *)labelSub{
    objc_setAssociatedObject(self, @selector(labelSub), labelSub, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end

