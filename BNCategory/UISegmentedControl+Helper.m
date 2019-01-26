//
//  UISegmentedControl+Helper.m
//  
//
//  Created by BIN on 2018/6/29.
//  Copyright © 2018年 SHANG. All rights reserved.
//

#import "UISegmentedControl+Helper.h"
#import <objc/runtime.h>

@implementation UISegmentedControl (Helper)

//-(void)setSegmentItems:(NSArray *)segmentItems{
//    //    DDLog(@"%@_%@",@(segmentItems.count),@(self.numberOfSegments));
//    if (segmentItems.count == 0) {
//        return;
//    }
//    CGFloat width = CGRectGetWidth(self.bounds)/segmentItems.count;
//    if (segmentItems.count <= self.numberOfSegments) {
//        for (NSInteger i = 0; i < self.numberOfSegments; i++) {
//            if (i < segmentItems.count) {
//                [self setTitle:segmentItems[i] forSegmentAtIndex:i];
//                [self setWidth:width forSegmentAtIndex:i];
//
//            } else {
//                [self removeSegmentAtIndex:i animated:NO];
//            }
//        }
//
//    } else {
//        for (NSInteger i = 0; i < segmentItems.count; i++) {
//            if (i < self.numberOfSegments) {
//                [self setTitle:segmentItems[i] forSegmentAtIndex:i];
//                [self setWidth:width forSegmentAtIndex:i];
//
//            } else {
//                [self insertSegmentWithTitle:segmentItems[i] atIndex:i animated:NO];
//            }
//        }
//    }
//    self.selectedSegmentIndex = 0;
//}

-(void)setItemList:(NSArray *)itemList{
    objc_setAssociatedObject(self, @selector(itemList), itemList, OBJC_ASSOCIATION_RETAIN_NONATOMIC);

    //    DDLog(@"%@_%@",@(segmentItems.count),@(self.numberOfSegments));
    if (itemList.count == 0) {
        return;
    }

    if (itemList.count <= self.numberOfSegments) {
        for (NSInteger i = 0; i < self.numberOfSegments; i++) {
            if (i < itemList.count) {
                [self setTitle:itemList[i] forSegmentAtIndex:i];
                
            } else {
                [self removeSegmentAtIndex:i animated:NO];
            }
        }
        
    } else {
        for (NSInteger i = 0; i < itemList.count; i++) {
            if (i < self.numberOfSegments) {
                [self setTitle:itemList[i] forSegmentAtIndex:i];
                
            } else {
                [self insertSegmentWithTitle:itemList[i] atIndex:i animated:NO];
            }
        }
    }
    self.selectedSegmentIndex = 0;
}

-(NSArray *)itemList{
    return objc_getAssociatedObject(self, _cmd);
}


@end
