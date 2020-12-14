//
//  NSURL+Helper.h
//  NNCategory
//
//  Created by BIN on 2018/11/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSURL (Helper)

///获取参数键值对
@property (nonatomic, strong, readonly) NSDictionary<NSString *, id> *queryParameters;
///追加参数键值对
- (nullable NSURL *)appendingQueryParameters:(NSDictionary<NSString *, NSString *> *)parameters;
///查询特定参数值
- (nullable NSString *)queryValue:(NSString *)key;

///保存视频到相册
- (void)saveVideoToPhotosAlbum:(void(^)(NSError *error))block;

@end


//@interface NSURLComponents (Helper)
//
/////获取参数键值对
//- (NSDictionary *)queryParameters;
/////追加参数键值对
//- (NSURL *)appendingQueryParameters:(NSDictionary<NSString *, NSString *> *)parameters;
/////查询特定参数值
//- (nullable NSString *)queryValue:(NSString *)key;
//    
//@end


NS_ASSUME_NONNULL_END
