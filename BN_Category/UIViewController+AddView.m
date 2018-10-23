
//
//  UIViewController+AddView.m
//  BN_SeparatorView
//
//  Created by BIN on 2018/8/23.
//  Copyright © 2018年 BIN. All rights reserved.
//

#import "UIViewController+AddView.h"

#import <objc/runtime.h>

#import "UICollectionView+Helper.h"

@implementation UIViewController (AddView)

-(id)obj{
    return objc_getAssociatedObject(self, _cmd);
}

-(void)setObj:(id)obj{
    objc_setAssociatedObject(self, @selector(obj), obj, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(id)objOne{
    return objc_getAssociatedObject(self, _cmd);
}

-(void)setObjOne:(id)objOne{
    objc_setAssociatedObject(self, @selector(objOne), objOne, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(NSDictionary *)dictClass{
    return objc_getAssociatedObject(self, _cmd);
}

-(void)setDictClass:(NSDictionary *)dictClass{
    objc_setAssociatedObject(self, @selector(dictClass), dictClass, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

//-(NSMutableArray *)dataList{
//    NSMutableArray * list = objc_getAssociatedObject(self, _cmd);
//    if (list == nil) {
//        list = [NSMutableArray array];
//        objc_setAssociatedObject(self, _cmd, list, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//
//    }
//    return list;
//}

-(NSMutableArray *)dataList{
    return objc_getAssociatedObject(self, _cmd);
}

-(void)setDataList:(NSMutableArray *)dataList{
    objc_setAssociatedObject(self, @selector(dataList), dataList, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(NSString *)controllerName{
    NSString * className = objc_getAssociatedObject(self, _cmd);
    if (className == nil) {
        className = NSStringFromClass([self class]);
        if ([className containsString:@"Controller"]) {
            NSRange range = NSMakeRange(0, 0);
            if ([className rangeOfString:@"ViewController"].location != NSNotFound) {
                range = [className rangeOfString:@"ViewController"];
            }
            else if ([className rangeOfString:@"Controller"].location != NSNotFound){
                range = [className rangeOfString:@"Controller"];
            }
            className = [className substringToIndex:range.location];
        }
        objc_setAssociatedObject(self, _cmd, className, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return className;
}

-(UIViewController *)frontController{
    UIViewController *controller = objc_getAssociatedObject(self, _cmd);
    if (controller == nil) {
        NSInteger count = self.navigationController.viewControllers.count;
        if (count >= 2) {
            controller = self.navigationController.viewControllers[count - 2];

        }
        else{
            controller = [self.navigationController.viewControllers lastObject];
            
        }
        objc_setAssociatedObject(self, _cmd, controller, OBJC_ASSOCIATION_RETAIN_NONATOMIC);

    }
    return controller;
    
}

#pragma mark- layz

- (UITableView *)tableView {
    UITableView* table = objc_getAssociatedObject(self, _cmd);
    if (table == nil) {
        table = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
//        [table registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        table.layer.borderColor = UIColor.grayColor.CGColor;
        table.layer.borderWidth = 1;
        
        if ([self conformsToProtocol:@protocol(UITableViewDataSource)]) {
            table.dataSource = self;
            
        }
        if ([self conformsToProtocol:@protocol(UITableViewDelegate)]) {
            table.delegate = self;
        }
        
        objc_setAssociatedObject(self, _cmd, table, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return table;
}

//-(NSMutableArray *)dataList{
//    NSMutableArray* list = objc_getAssociatedObject(self, _cmd);
//    if (list == nil) {
//        list = [NSMutableArray array];
//        
//        objc_setAssociatedObject(self, _cmd, list, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//        
//    }
//    return list;
//}

-(void)setPageIndex:(NSInteger)pageIndex{
    objc_setAssociatedObject(self, @selector(pageIndex), @(pageIndex), OBJC_ASSOCIATION_ASSIGN);
    
}

-(NSInteger)pageIndex{
    return [objc_getAssociatedObject(self, _cmd) integerValue];
    
}


- (UICollectionView *)collectionView{
    UICollectionView* ctv = objc_getAssociatedObject(self, _cmd);
    if (ctv == nil) {
        ctv = ({
            UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
            //item水平间距
            layout.minimumLineSpacing = 10;
            //item垂直间距
            layout.minimumInteritemSpacing = 10;
            //item的尺寸
            layout.itemSize = CGSizeMake(90, 100);
            //item的UIEdgeInsets
            layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
            //滑动方向,默认垂直
            //            layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
            //sectionView 尺寸
            layout.headerReferenceSize = CGSizeMake(CGRectGetWidth(self.view.bounds), 40);
            layout.footerReferenceSize = CGSizeMake(CGRectGetWidth(self.view.bounds), 20);
            
            ctv = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
            ctv.backgroundColor = UIColor.whiteColor;
            ctv.scrollsToTop = NO;
            ctv.showsVerticalScrollIndicator = NO;
            ctv.showsHorizontalScrollIndicator = NO;
            ctv.dictClass = self.dictClass;
            
            ctv;
        });
        objc_setAssociatedObject(self, _cmd, ctv, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
    }
    return ctv;
}

//-(NSDictionary *)dictClass{
//    NSDictionary * dic = objc_getAssociatedObject(self, _cmd);
//    if (dic == nil) {
//        dic = [NSDictionary dictionary];
//        objc_setAssociatedObject(self, _cmd, dic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//
//    }
//    return dic;
//}

-(NSMutableDictionary *)heightMdict{
    return objc_getAssociatedObject(self, _cmd);
    
}

-(void)setHeightMdic:(NSMutableDictionary *)heightMdic{
    objc_setAssociatedObject(self, @selector(heightMdic), heightMdic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}

@end

