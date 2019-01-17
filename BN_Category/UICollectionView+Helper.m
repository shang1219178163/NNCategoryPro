
//
//  UICollectionView+Helper.m
//  BN_ExcelView
//
//  Created by BIN on 2018/4/12.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "UICollectionView+Helper.h"
#import <objc/runtime.h>
#import "BN_Globle.h"
#import "UICollectionViewLayout+AddView.h"

NSString * const UICollectionElementKindSectionItem = @"UICollectionElementKindSectionItem";

@implementation UICollectionView (Helper)

+(UICollectionViewLayout *)layoutDefault{
    id obj = objc_getAssociatedObject(self, _cmd);
    if (!obj) {
        obj = ({
            CGFloat width = UIScreen.mainScreen.bounds.size.width;
            CGFloat spacing = 5.0;
            CGSize itemSize = CGSizeMake((width - 5*spacing)/4.0, (width - 5*spacing)/4.0);
            CGSize headerSize = CGSizeMake(width, 40);
            CGSize footerSize = CGSizeMake(width, 20);
            UICollectionViewFlowLayout *layout = [UICollectionViewLayout createItemSize:itemSize spacing:spacing headerSize:headerSize footerSize:footerSize];
            layout;
        });
        objc_setAssociatedObject(self, @selector(layoutDefault), obj, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
    }
    return obj;
}

-(void)setLayoutDefault:(UICollectionViewLayout *)layoutDefault{
    objc_setAssociatedObject(self, @selector(layoutDefault), layoutDefault, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSArray *)listClass{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setListClass:(NSArray *)listClass{
    objc_setAssociatedObject(self, @selector(listClass), listClass, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    [self bn_registerListClass:listClass];
}

- (NSDictionary *)dictClass{
    return objc_getAssociatedObject(self, _cmd);

}

- (void)setDictClass:(NSDictionary *)dictClass{
    objc_setAssociatedObject(self, @selector(dictClass), dictClass, OBJC_ASSOCIATION_COPY_NONATOMIC);

    for (NSString * key in dictClass.allKeys) {
        if ([key isEqualToString:UICollectionElementKindSectionItem]) {
            [self bn_registerListClass:dictClass[key]];
            
        } else {
            [self bn_registerListClassReusable:dictClass[key] kind:key];

        }
    }
}

+ (NSString *)cellIdentifierByClassName:(NSString *)className{
    return className;
}

+ (NSString *)viewIdentifierByClassName:(NSString *)className kind:(NSString *)kind{
    
    NSString * extra = [kind isEqualToString:UICollectionElementKindSectionHeader] ? @"Header" : @"Footer";
    NSString * identifier = [className stringByAppendingString:extra];
    
    return identifier;
}


- (void)bn_registerListClass:(NSArray *)listClass{
    for (NSString * className in listClass) {
        [self registerClass:NSClassFromString(className) forCellWithReuseIdentifier:className];

    }
    
}

- (void)bn_registerListClassReusable:(NSArray *)listClass kind:(NSString *)kind{
    for (NSString * className in listClass) {
        NSString * identifier = [self.class viewIdentifierByClassName:className kind:kind];
        [self registerClass:NSClassFromString(className) forSupplementaryViewOfKind:kind withReuseIdentifier:identifier];
//        NSLog(@"%@,%@,%@",NSClassFromString(className),kind,identifier);
    }
    
}

#pragma mark - -funtions

/**
 默认布局配置(自上而下,自左而右)
 */
- (UICollectionViewFlowLayout *)createItemHeight:(CGFloat)itemHeight spacing:(CGFloat)spacing headerHeight:(CGFloat)headerHeight footerHeight:(CGFloat)footerHeight{
    
    CGFloat width = CGRectGetWidth(self.bounds);
    CGSize itemSize = CGSizeMake((width - 5*spacing)/4.0, itemHeight);
    CGSize headerSize = CGSizeMake(width, headerHeight);
    CGSize footerSize = CGSizeMake(width, footerHeight);
    UICollectionViewFlowLayout *layout = [UICollectionViewLayout createItemSize:itemSize spacing:spacing headerSize:headerSize footerSize:footerSize];
    return layout;
}

@end
