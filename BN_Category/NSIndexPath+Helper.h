//
//  NSIndexPath+Helper.h
//  BN_Category
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
    
@end

NS_ASSUME_NONNULL_END
