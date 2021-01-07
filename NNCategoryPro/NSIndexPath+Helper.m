//
//  NSIndexPath+Helper.m
//  NNCategory
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

NSIndexPath *NSIndexPathFromString(NSString *string) {
    if ([string containsString:@"{"]) string = [string stringByReplacingOccurrencesOfString:@"{" withString:@""];
    if ([string containsString:@"}"]) string = [string stringByReplacingOccurrencesOfString:@"}" withString:@""];
    NSArray *list = [string componentsSeparatedByString:@","];
    return [NSIndexPath indexPathForRow:[list.firstObject integerValue] inSection:[list.lastObject integerValue]];
}
 
@end
