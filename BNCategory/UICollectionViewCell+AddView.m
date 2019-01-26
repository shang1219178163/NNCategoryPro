//
//  UICollectionViewCell+AddView.m
//  
//
//  Created by BIN on 2018/8/24.
//  Copyright © 2018年 SHANG. All rights reserved.
//

#import "UICollectionViewCell+AddView.h"

#import <objc/runtime.h>
#import "BNGloble.h"

@implementation UICollectionViewCell (AddView)

+ (instancetype)viewWithCollectionView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath{
    NSString * identifier = NSStringFromClass(self.class);
    UICollectionViewCell *view = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    return view;
}

+ (instancetype)viewWithCollectionView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath identifier:(NSString *)identifier{
    UICollectionViewCell *view = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    return view;
}

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
            view.font = [UIFont systemFontOfSize:17];
            view.textAlignment = NSTextAlignmentLeft;
            view.numberOfLines = 0;
            view.userInteractionEnabled = true;
            //        label.backgroundColor = UIColor.greenColor;
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
            view.font = [UIFont systemFontOfSize:17];
            view.textAlignment = NSTextAlignmentLeft;

            view.numberOfLines = 0;
            view.userInteractionEnabled = YES;
            //        label.backgroundColor = UIColor.greenColor;
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

