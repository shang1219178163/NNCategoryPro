//
//  NSURLSession+Helper.m
//  BNCategory
//
//  Created by BIN on 2018/11/28.
//

#import "NSURLSession+Helper.h"

@implementation NSURLSession (Helper)

+ (NSURLSessionDataTask *)sendSynRequest:(id)params handler:(void (^)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error))handler{
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    
    NSURLSessionDataTask *dataTask = nil;
    if ([params isKindOfClass:[NSMutableURLRequest class]]) {
        dataTask = [NSURLSession.sharedSession dataTaskWithRequest:params completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (handler) handler(data,response,error);
            dispatch_semaphore_signal(semaphore);
        }];
    }
    else if([params isKindOfClass:[NSURL class]]) {
        dataTask = [NSURLSession.sharedSession dataTaskWithURL:params completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (handler) handler(data,response,error);
            dispatch_semaphore_signal(semaphore);
        }];
    }
    else{
        NSLog(@"%@:%@",NSStringFromClass([self class]),@"fromFile只能是NSData或NSURL");
    }
    [dataTask resume];
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    return dataTask;
}

+ (NSURLSessionDataTask *)sendAsynRequest:(id)params handler:(void (^)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error))handler{
    NSURLSessionDataTask *dataTask = nil;
    if ([params isKindOfClass:[NSMutableURLRequest class]]) {
        dataTask = [NSURLSession.sharedSession dataTaskWithRequest:params completionHandler:handler];
    }
    else if([params isKindOfClass:[NSURL class]]) {
        dataTask = [NSURLSession.sharedSession dataTaskWithURL:params completionHandler:handler];
    }
    else{
        NSLog(@"%@:%@",NSStringFromClass([self class]),@"fromFile只能是NSData或NSURL");
    }
    [dataTask resume];
    return dataTask;
}

+ (NSURLSessionUploadTask *)sendSynUploadRequest:(nonnull NSURLRequest *)request fromFile:(id)fromFile handler:(void (^)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error))handler{
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    
    NSURLSessionUploadTask *dataTask = nil;
    if ([fromFile isKindOfClass:[NSURL class]]) {
        dataTask = [NSURLSession.sharedSession uploadTaskWithRequest:request fromFile:fromFile completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (handler) handler(data,response,error);
            dispatch_semaphore_signal(semaphore);
        }];
    }
    else if([fromFile isKindOfClass:[NSData class]]) {
        dataTask = [NSURLSession.sharedSession uploadTaskWithRequest:request fromData:fromFile completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (handler) handler(data,response,error);
            dispatch_semaphore_signal(semaphore);
        }];
    }
    else{
        NSLog(@"%@:%@",NSStringFromClass([self class]),@"fromFile只能是NSData,NSURL");
    }
    [dataTask resume];
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    return dataTask;
}

+ (NSURLSessionUploadTask *)sendAsyUploadRequest:(nonnull NSURLRequest *)request fromData:(id)fromFile handler:(void (^)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error))handler{
    NSURLSessionUploadTask *dataTask = nil;
    if ([fromFile isKindOfClass:[NSURL class]]) {
        dataTask = [NSURLSession.sharedSession uploadTaskWithRequest:request fromFile:fromFile completionHandler:handler];
    }
    else if([fromFile isKindOfClass:[NSData class]]) {
        dataTask = [NSURLSession.sharedSession uploadTaskWithRequest:request fromData:fromFile completionHandler:handler];
    }
    else{
        NSLog(@"%@:%@",NSStringFromClass([self class]),@"fromFile只能是NSData,NSURL");
    }
    [dataTask resume];
    return dataTask;
}

+ (NSURLSessionDownloadTask *)sendSynDownloadRequest:(id)params handler:(void (^)(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error))handler{
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    
    NSURLSessionDownloadTask *dataTask = nil;
    if ([params isKindOfClass:[NSMutableURLRequest class]]) {
        dataTask = [NSURLSession.sharedSession downloadTaskWithRequest:params completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (handler) handler(location,response,error);
            dispatch_semaphore_signal(semaphore);
        }];
    }
    else if([params isKindOfClass:[NSURL class]]){
        dataTask = [NSURLSession.sharedSession downloadTaskWithURL:params completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (handler) handler(location,response,error);
            dispatch_semaphore_signal(semaphore);
        }];
        
    }
    else if([params isKindOfClass:[NSData class]]){
        dataTask = [NSURLSession.sharedSession downloadTaskWithResumeData:params completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (handler) handler(location,response,error);
            dispatch_semaphore_signal(semaphore);
        }];
        
    }
    else{
        NSLog(@"%@:%@",NSStringFromClass([self class]),@"fromFile只能是NSData,NSURL,NSMutableURLRequest");
        
    }
    [dataTask resume];
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    return dataTask;
}

+ (NSURLSessionDownloadTask *)sendAsynDownloadRequest:(id)params handler:(void (^)(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error))handler{
    NSURLSessionDownloadTask *dataTask = nil;
    if ([params isKindOfClass:[NSMutableURLRequest class]]) {
        dataTask = [NSURLSession.sharedSession downloadTaskWithRequest:params completionHandler:handler];
    }
    else if([params isKindOfClass:[NSURL class]]){
        dataTask = [NSURLSession.sharedSession downloadTaskWithURL:params completionHandler:handler];
    }
    else if([params isKindOfClass:[NSData class]]){
        dataTask = [NSURLSession.sharedSession downloadTaskWithResumeData:params completionHandler:handler];
    }
    else{
        NSLog(@"%@:%@",NSStringFromClass([self class]),@"fromFile只能是NSData,NSURL,NSMutableURLRequest");
        
    }
    [dataTask resume];
    return dataTask;
}

@end
