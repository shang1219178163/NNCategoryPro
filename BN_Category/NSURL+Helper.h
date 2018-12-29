//
//  NSURL+Helper.h
//  BN_Category
//
//  Created by BIN on 2018/11/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSURL (Helper)

@property (nonatomic, strong, readonly) NSDictionary *paramDic;

- (NSString *)valueForParamKey:(NSString *)paramKey;

@end

NS_ASSUME_NONNULL_END
