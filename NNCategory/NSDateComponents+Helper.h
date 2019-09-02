//
//  NSDateComponents+Helper.h
//  ProductTemplet
//
//  Created by Bin Shang on 2019/8/20.
//  Copyright © 2019 BN. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDateComponents (Helper)

+ (NSDateComponents *)dateWithYear:(NSInteger)year
                             month:(NSInteger)month
                               day:(NSInteger)day
                              hour:(NSInteger)hour
                            minute:(NSInteger)minute
                            second:(NSInteger)second;

@end

NS_ASSUME_NONNULL_END
