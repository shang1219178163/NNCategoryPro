//
//  NSException+Helper.h
//  BN_Category
//
//  Created by BIN on 2018/11/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSException (Helper)

@property (nonatomic, strong, readonly) NSArray *backtrace;


@end

NS_ASSUME_NONNULL_END
