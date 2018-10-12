//
//  UISegmentedControl+Helper.m
//  HuiZhuBang
//
//  Created by BIN on 2018/6/29.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//

#import "UISegmentedControl+Helper.h"

@implementation UISegmentedControl (Helper)

-(void)setSegmentItems:(NSArray *)segmentItems{
    //    DDLog(@"%@_%@",@(segmentItems.count),@(self.segmentCtrl.numberOfSegments));
    
    CGFloat width = CGRectGetWidth(self.bounds)/segmentItems.count;

    if (segmentItems.count <= self.numberOfSegments) {
        for (NSInteger i = 0; i < self.numberOfSegments; i++) {
            if (i < segmentItems.count) {
                [self setTitle:segmentItems[i] forSegmentAtIndex:i];
                [self setWidth:width forSegmentAtIndex:i];

            }else{
                [self removeSegmentAtIndex:i animated:NO];
            }
        }
        
    }else{
        for (NSInteger i = 0; i < segmentItems.count; i++) {
            if (i < self.numberOfSegments) {
                [self setTitle:segmentItems[i] forSegmentAtIndex:i];
                [self setWidth:width forSegmentAtIndex:i];

            }else{
                [self insertSegmentWithTitle:segmentItems[i] atIndex:i animated:NO];
            }
        }
    }
    self.selectedSegmentIndex = 0;
}


@end
