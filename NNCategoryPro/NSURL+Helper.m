//
//  NSURL+Helper.m
//  NNCategory
//
//  Created by BIN on 2018/11/22.
//

#import "NSURL+Helper.h"

@implementation NSURL (Helper)

- (NSDictionary *)queryParameters{
    NSURLComponents *urlComponents = [[NSURLComponents alloc]initWithURL:self resolvingAgainstBaseURL:false];
    if (!urlComponents || !urlComponents.queryItems) {
        return @{};
    }
    
    return urlComponents.queryParameters;
}

- (nullable NSURL *)appendingQueryParameters:(NSDictionary<NSString *, NSString *> *)parameters {
    NSURLComponents *urlComponents = [[NSURLComponents alloc]initWithURL:self resolvingAgainstBaseURL:false];
    if (!urlComponents) {
        return nil;
    }
    
    return [urlComponents appendingQueryParameters:parameters];
}

- (nullable NSString *)queryValue:(NSString *)key {
    NSURLComponents *urlComponents = [[NSURLComponents alloc]initWithURL:self resolvingAgainstBaseURL:false];
    if (!urlComponents) {
        return nil;
    }
    return [urlComponents queryValue:key];
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


//@implementation NSURLComponents (Helper)
//
//- (NSDictionary *)queryParameters{
//    __block NSMutableDictionary *mdic = [NSMutableDictionary dictionary];
//    [self.queryItems enumerateObjectsUsingBlock:^(NSURLQueryItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        mdic[obj.name] = obj.value;
//    }];
//    return mdic;
//}
//
//- (NSURL *)appendingQueryParameters:(NSDictionary<NSString *, NSString *> *)parameters {
//    __block NSMutableArray *marr = [NSMutableArray arrayWithArray:self.queryItems];
//    [parameters enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, NSString * _Nonnull obj, BOOL * _Nonnull stop) {
//        NSURLQueryItem *item = [[NSURLQueryItem alloc]initWithName:key value:obj];
//        [marr addObject:item];
//    }];
//    self.queryItems = marr.copy;
//    return self.URL;
//}
//
//- (nullable NSString *)queryValue:(NSString *)key {
//    __block NSString *result;
//    [self.queryItems enumerateObjectsUsingBlock:^(NSURLQueryItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        if ([obj.name isEqualToString:key]) {
//            result = obj.value;
//            *stop = true;
//        }
//    }];
//    return result;
//}


@end
