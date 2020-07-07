//
//  NSURL+Helper.m
//  NNCategory
//
//  Created by BIN on 2018/11/22.
//

#import "NSURL+Helper.h"

@implementation NSURL (Helper)

/**
 *  @brief  url参数转字典
 *
 *  @return 参数转字典结果
 */
- (NSDictionary *)paramDic{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    NSArray *queryComponents = [self.query componentsSeparatedByString:@"&"];
    for (NSString *queryComponent in queryComponents) {
        NSString *key = [queryComponent componentsSeparatedByString:@"="].firstObject;
        NSString *value = [queryComponent substringFromIndex:(key.length + 1)];
        [dic setObject:value forKey:key];
    }
    return dic;
}

- (NSString *)valueForParamKey:(NSString *)paramKey{
    return [self.paramDic objectForKey:paramKey];
}

- (void)saveVideoToPhotosAlbum:(void(^)(NSError *error))block{
    if (!self.path || [self.path isEqualToString:@""]) {
        NSParameterAssert(!self.path || [self.path isEqualToString:@""]);
        return;
    }
    
    void *context = CFBridgingRetain([block copy]);
    UISaveVideoAtPathToSavedPhotosAlbum(self.path, UIImage.class, @selector(videoAtPath:didFinishSavingWithError:contextInfo:), context);
}

- (void)video:(NSString *)videoPath didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    void(^block)(NSError *) = CFBridgingRelease(contextInfo);
    if (block) {
        block(error);
    }
}

@end
