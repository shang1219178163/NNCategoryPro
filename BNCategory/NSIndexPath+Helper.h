//
//  NSIndexPath+Helper.h
//  BNCategory
//
//  Created by BIN on 2018/11/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSIndexPath (Helper)

@property (nonatomic, strong, readonly) NSIndexPath * previousRow;
@property (nonatomic, strong, readonly) NSIndexPath * nextRow;
@property (nonatomic, strong, readonly) NSIndexPath * previousItem;
@property (nonatomic, strong, readonly) NSIndexPath * nextItem;
@property (nonatomic, strong, readonly) NSIndexPath * nextSection;
@property (nonatomic, strong, readonly) NSIndexPath * previousSection;

FOUNDATION_EXPORT NSIndexPath *NSIndexPathFromString(NSString *string);
FOUNDATION_EXPORT NSIndexPath *NSIndexPathFromIndex(NSInteger section, NSInteger row);
FOUNDATION_EXPORT NSArray *NSIndexPathsFromIdxInfo(NSInteger section, NSArray *rowList);

@end

NS_ASSUME_NONNULL_END
