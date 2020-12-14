//
//  NSURLComponents+Helper.h
//  ProductTemplet
//
//  Created by Bin Shang on 2020/12/14.
//  Copyright © 2020 BN. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSURLComponents (Helper)

///获取参数键值对
- (NSDictionary *)queryParameters;
///追加参数键值对
- (NSURL *)appendingQueryParameters:(NSDictionary<NSString *, NSString *> *)parameters;
///查询特定参数值
- (nullable NSString *)queryValue:(NSString *)key;
    
@end

NS_ASSUME_NONNULL_END
