//
//  UICollectionViewCell+AddView.m
//  HuiZhuBang
//
//  Created by BIN on 2018/8/24.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//

#import "UICollectionViewCell+AddView.h"

#import <objc/runtime.h>
#import "BN_Globle.h"

@implementation UICollectionViewCell (AddView)

@dynamic label,labelSub,imgView,height,width;

+ (instancetype)viewWithCollectionView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath{
    NSString * identifier = NSStringFromClass([self class]);
    UICollectionViewCell *view = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    return view;
}

+ (instancetype)viewWithCollectionView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath identifier:(NSString *)identifier{
    UICollectionViewCell *view = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    return view;
}


-(CGFloat)width{
    return CGRectGetWidth(self.contentView.frame);
    
}

-(CGFloat)height{
    return CGRectGetHeight(self.contentView.frame);
    
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

