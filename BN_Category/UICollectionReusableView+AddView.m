
//
//  UICollectionReusableView+AddView.m
//  HuiZhuBang
//
//  Created by BIN on 2018/8/24.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//

#import "UICollectionReusableView+AddView.h"

#import <objc/runtime.h>
#import "UICollectionView+Helper.h"
#import "BN_Globle.h"

@implementation UICollectionReusableView (AddView)

@dynamic label,labelSub,imgView;

+ (instancetype)viewWithCollectionView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath kind:(NSString *)kind{
    NSString * identifier = [UICollectionView viewIdentifierByClassName:NSStringFromClass([self class]) kind:kind];
    UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:identifier forIndexPath:indexPath];
    
    NSString * titleHeader = [NSString stringWithFormat:@"HeaderView_%@",@(indexPath.section)];
    NSString * titleFooter = [NSString stringWithFormat:@"FooterView_%@",@(indexPath.section)];
    view.label.text = [kind isEqualToString:UICollectionElementKindSectionHeader]  ? titleHeader: titleFooter;
    view.backgroundColor = [kind isEqualToString:UICollectionElementKindSectionHeader] ? UIColor.greenColor : UIColor.yellowColor;
    view.backgroundColor = UIColor.whiteColor;
    return view;
}

//+ (instancetype)viewWithCollectionView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath kind:(NSString *)kind{
//
//    NSString * identifier = [UICollectionView viewIdentifierByClassName:NSStringFromClass([self class]) kind:kind];
//    UICollectionReusableView *view = nil;
//    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
//        view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:identifier forIndexPath:indexPath];
//
//    }
//    else if([kind isEqualToString:UICollectionElementKindSectionFooter]){
//        view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:identifier forIndexPath:indexPath];
//
//    }
//
//    view.label.text = [kind isEqualToString:UICollectionElementKindSectionHeader]  ? @"headerView": @"footerView";
//    view.backgroundColor = [kind isEqualToString:UICollectionElementKindSectionHeader]  ? UIColor.greenColor : UIColor.yellowColor;
//
//    return view;
//}

-(CGFloat)width{
    return CGRectGetWidth(self.frame);
    
}

-(CGFloat)height{
    return CGRectGetHeight(self.frame);
    
}

-(UIImageView *)imgView{
    UIImageView * view = objc_getAssociatedObject(self, _cmd);
    if (view == nil) {
        view = ({
            UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectZero];
            imgView.userInteractionEnabled = YES;
            imgView.contentMode = UIViewContentModeScaleAspectFit;
            //            imgView.backgroundColor = UIColor.orangeColor;
            imgView.tag = kTAG_IMGVIEW;
            imgView;
        });
        objc_setAssociatedObject(self, _cmd, view, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
    }
    return view;
}

-(UILabel *)label{
    UILabel * lab = objc_getAssociatedObject(self, _cmd);
    if (lab == nil) {
        lab = ({
            UILabel * label = [[UILabel alloc] initWithFrame:CGRectZero];
            label.tag = kTAG_LABEL + 4;
            label.font = [UIFont systemFontOfSize:17];
            label.textAlignment = NSTextAlignmentRight;
            
            label.numberOfLines = 0;
            label.userInteractionEnabled = YES;
            //        label.backgroundColor = UIColor.greenColor;
            label;
        });
        objc_setAssociatedObject(self, _cmd, lab, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return lab;
}

-(UILabel *)labelSub{
    UILabel * lab = objc_getAssociatedObject(self, _cmd);
    if (lab == nil) {
        lab = ({
            UILabel * label = [[UILabel alloc] initWithFrame:CGRectZero];
            label.tag = kTAG_LABEL;
            label.font = [UIFont systemFontOfSize:17];
            label.textAlignment = NSTextAlignmentLeft;
            
            label.numberOfLines = 0;
            label.userInteractionEnabled = YES;
            //        label.backgroundColor = UIColor.greenColor;
            label;
        });
        objc_setAssociatedObject(self, _cmd, lab, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return lab;
}

@end

