//
//  NSURLRequest+Helper.h
//  ProductTemplet
//
//  Created by Bin Shang on 2019/5/17.
//  Copyright © 2019 BN. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSURLRequest (Helper)

+ (NSMutableURLRequest *)request:(NSString *)urlStr httpMethod:(NSString *)httpMethod httpBody:(NSData * _Nullable)httpBody;

@end

NS_ASSUME_NONNULL_END
