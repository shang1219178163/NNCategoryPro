//
//  NSURL+Helper.h
//  NNCategory
//
//  Created by BIN on 2018/11/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSURL (Helper)

@property (nonatomic, strong, readonly) NSDictionary *paramDic;

- (NSString *)valueForParamKey:(NSString *)paramKey;

///保存视频到相册
- (void)saveVideoToPhotosAlbum:(void(^)(NSError *error))block;

@end

NS_ASSUME_NONNULL_END
