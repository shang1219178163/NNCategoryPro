//
//  NSIndexPath+Helper.m
//  BNCategory
//
//  Created by BIN on 2018/11/22.
//

#import "NSIndexPath+Helper.h"

@implementation NSIndexPath (Helper)

- (NSIndexPath *)previousRow{
    return [NSIndexPath indexPathForRow:self.row - 1
                              inSection:self.section];
}

- (NSIndexPath *)nextRow{
    return [NSIndexPath indexPathForRow:self.row + 1
                              inSection:self.section];
}

- (NSIndexPath *)previousItem{
    return [NSIndexPath indexPathForItem:self.item - 1
                               inSection:self.section];
}


- (NSIndexPath *)nextItem{
    return [NSIndexPath indexPathForItem:self.item + 1
                               inSection:self.section];
}


- (NSIndexPath *)nextSection{
    return [NSIndexPath indexPathForRow:self.row
                              inSection:self.section + 1];
}

- (NSIndexPath *)previousSection{
    return [NSIndexPath indexPathForRow:self.row
                              inSection:self.section - 1];
}

/**
 字符串->NSIndexPath(string 两部分数字必须用逗号隔开)
 */
NSIndexPath *NSIndexPathFromString(NSString *string) {
    if ([string containsString:@"{"]) string = [string stringByReplacingOccurrencesOfString:@"{" withString:@""];
    if ([string containsString:@"}"]) string = [string stringByReplacingOccurrencesOfString:@"}" withString:@""];
    NSArray * list = [string componentsSeparatedByString:@","];
    return [NSIndexPath indexPathForRow:[list.firstObject integerValue] inSection:[list.lastObject integerValue]];
}

/**
 NSIndexPath快速生成
 */
NSIndexPath *NSIndexPathFromIndex(NSInteger section, NSInteger row) {
    return [NSIndexPath indexPathForRow:row inSection:section];
}

/**
 返回索引数组
 */
NSArray *NSIndexPathsFromIdxInfo(NSInteger section, NSArray *rowList) {
    NSMutableArray *marr = [NSMutableArray array];
    for (NSNumber *row in rowList) {
        [marr addObject:[NSIndexPath indexPathForRow:row.integerValue inSection:section]];
        
    }
    return marr.copy;
}

@end
