//
//  NSIndexPath+Helper.h
//  NNCategory
//
//  Created by BIN on 2018/11/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSIndexPath (Helper)

@property (nonatomic, strong, readonly) NSIndexPath *previousRow;
@property (nonatomic, strong, readonly) NSIndexPath *nextRow;
@property (nonatomic, strong, readonly) NSIndexPath *previousItem;
@property (nonatomic, strong, readonly) NSIndexPath *nextItem;
@property (nonatomic, strong, readonly) NSIndexPath *nextSection;
@property (nonatomic, strong, readonly) NSIndexPath *previousSection;

/// 字符串->NSIndexPath(string 两部分数字必须用逗号隔开)
FOUNDATION_EXPORT NSIndexPath *NSIndexPathFromString(NSString *string);
/// NSIndexPath快速生成
FOUNDATION_EXPORT NSIndexPath *NSIndexPathFromIndex(NSInteger section, NSInteger row);

@end

NS_ASSUME_NONNULL_END
