//
//  NSURL+Helper.m
//  NNCategory
//
//  Created by BIN on 2018/11/22.
//

#import "NSURL+Helper.h"
#import "NSURLComponents+Helper.h"

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
    
    UISaveVideoAtPathToSavedPhotosAlbum(self.path,
                                        self,
                                        @selector(videoAtPath:didFinishSavingWithError:contextInfo:),
                                        (__bridge_retained void *)[block copy]);

}

- (void)video:(NSString *)videoPath didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    void(^block)(NSError *) = CFBridgingRelease(contextInfo);
    if (block) {
        block(error);
    }
}

@end

