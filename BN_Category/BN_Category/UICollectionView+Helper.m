
//
//  UICollectionView+Helper.m
//  BN_ExcelView
//
//  Created by hsf on 2018/4/12.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "UICollectionView+Helper.h"
#import <objc/runtime.h>

@implementation UICollectionView (Helper)

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
        if ([key isEqualToString:UICollectionElementSectionItem]) {
            [self bn_registerListClass:dictClass[key]];
            
        }else{
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
        NSString * identifier = [[self class] viewIdentifierByClassName:className kind:kind];
        [self registerClass:NSClassFromString(className) forSupplementaryViewOfKind:kind withReuseIdentifier:identifier];
//        NSLog(@"%@,%@,%@",NSClassFromString(className),kind,identifier);
    }
    
}
                                 

@end
