//
//  UITableViewCell+Helper.m
//  
//
//  Created by BIN on 2018/1/9.
//  Copyright © 2018年 SHANG. All rights reserved.
//

#import "UITableViewCell+Helper.h"

#import <objc/runtime.h>
#import <NNGloble/NNGloble.h>

@implementation UITableViewCell (Helper)

CGFloat CellHeightFromParams(NSMutableDictionary *dic, NSIndexPath *indexPath, CGFloat height){
    NSString *cachKey = [NSString stringWithFormat:@"%@,%@",@(indexPath.section),@(indexPath.row)];
    if (dic[cachKey]) {
        return [dic[cachKey] floatValue];
        
    } else {
        [dic setObject:@(height) forKey:cachKey];
        
    }
    return height;
}


@end
