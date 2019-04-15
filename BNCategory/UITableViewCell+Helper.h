//
//  UITableViewCell+Helper.h
//  
//
//  Created by BIN on 2018/1/9.
//  Copyright © 2018年 SHANG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableViewCell (Helper)

/// cell高度缓存
FOUNDATION_EXPORT CGFloat CellHeightFromParams(NSMutableDictionary *dic, NSIndexPath * indexPath, CGFloat height);

@end

