//
//  NSURLRequest+Helper.m
//  NNCategory
//
//  Created by Bin Shang on 2019/5/22.
//

#import "NSURLRequest+Helper.h"

NSString * const kHttpMethodGET = @"GET";
NSString * const kHttpMethodPOST = @"POST";
NSString * const kHttpMethodPUT = @"PUT";
NSString * const kHttpMethodDELETE = @"DELETE";

@implementation NSURLRequest (Helper)

+(instancetype)requestGetURL:(NSString *)url{
    NSMutableURLRequest *request = [NSMutableURLRequest requestURL:url
                                                            method:kHttpMethodGET
                                                              body:nil
                                                       cachePolicy:NSURLRequestReloadIgnoringCacheData
                                                   timeoutInterval:6];
    return request;
}

+(instancetype)requestPostURL:(NSString *)url body:(NSData *_Nullable)body{
    NSMutableURLRequest *request = [NSMutableURLRequest requestURL:url
                                                            method:kHttpMethodPOST
                                                              body:body
                                                       cachePolicy:NSURLRequestReloadIgnoringCacheData
                                                   timeoutInterval:6];
    return request;
}

+(instancetype)requestURL:(NSString *)url
                   method:(NSString *)method
                     body:(NSData *_Nullable)body
              cachePolicy:(NSURLRequestCachePolicy)cachePolicy
          timeoutInterval:(NSTimeInterval)timeoutInterval{
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]
                                                           cachePolicy:cachePolicy
                                                       timeoutInterval:timeoutInterval];
    request.HTTPMethod = method;
    request.HTTPBody = body;
    return request;
}

+ (instancetype)requestWithURL:(NSURL *)URL fileURL:(NSURL *)fileURL name:(NSString *)name {
    return [self requestWithURL:URL fileURLs:@[fileURL] name:name];
}

+ (instancetype)requestWithURL:(NSURL *)URL
                       fileURL:(NSURL *)fileURL
                      fileName:(NSString *)fileName
                          name:(NSString *)name {
    return [self requestWithURL:URL fileURLs:@[fileURL] fileNames:@[fileName] name:name];
}

+ (instancetype)requestWithURL:(NSURL *)URL fileURLs:(NSArray *)fileURLs name:(NSString *)name {
    NSMutableArray *fileNames = [NSMutableArray arrayWithCapacity:fileURLs.count];
    [fileURLs enumerateObjectsUsingBlock:^(NSURL *fileURL, NSUInteger idx, BOOL *stop) {
        [fileNames addObject:fileURL.path.lastPathComponent];
    }];
    
    return [self requestWithURL:URL fileURLs:fileURLs fileNames:fileNames name:name];
}

+ (instancetype)requestWithURL:(NSURL *)URL
                      fileURLs:(NSArray *)fileURLs
                     fileNames:(NSArray *)fileNames
                          name:(NSString *)name {
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    request.HTTPMethod = @"POST";
    
    NSMutableData *data = [NSMutableData data];
    NSString *boundary = multipartFormBoundary();
    
    if (fileURLs.count > 1) {
        name = [name stringByAppendingString:@"[]"];
    }
    
    [fileURLs enumerateObjectsUsingBlock:^(NSURL *fileURL, NSUInteger idx, BOOL *stop) {
        NSString *bodyStr = [NSString stringWithFormat:@"\n--%@\n", boundary];
        [data appendData:[bodyStr dataUsingEncoding:NSUTF8StringEncoding]];
        
        NSString *fileName = fileNames[idx];
        bodyStr = [NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\" \n", name, fileName];
        [data appendData:[bodyStr dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[@"Content-Type: application/octet-stream\n\n" dataUsingEncoding:NSUTF8StringEncoding]];
        
        [data appendData:[NSData dataWithContentsOfURL:fileURL]];
        
        [data appendData:[@"\n" dataUsingEncoding:NSUTF8StringEncoding]];
    }];
    
    NSString *tailStr = [NSString stringWithFormat:@"--%@--\n", boundary];
    [data appendData:[tailStr dataUsingEncoding:NSUTF8StringEncoding]];
    
    request.HTTPBody = data;
    
    NSString *headerString = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
    [request setValue:headerString forHTTPHeaderField:@"Content-Type"];
    
    return request;
}

static NSString * multipartFormBoundary() {
    return [NSString stringWithFormat:@"Boundary+%08X%08X", arc4random(), arc4random()];
}


@end



@implementation NSURLSession (Helper)

+ (NSURLSessionDataTask *)sendSynRequest:(id)params handler:(void (^)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error))handler{
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    
    NSURLSessionDataTask *dataTask = nil;
    if ([params isKindOfClass:[NSURLRequest class]]) {
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
    else {
        NSParameterAssert([params isKindOfClass:[NSURLRequest class]] || [params isKindOfClass:[NSURL class]]);

    }
    [dataTask resume];
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    return dataTask;
}

+ (NSURLSessionDataTask *)sendAsynRequest:(id)params handler:(void (^)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error))handler{
    NSURLSessionDataTask *dataTask = nil;
    if ([params isKindOfClass:[NSURLRequest class]]) {
        dataTask = [NSURLSession.sharedSession dataTaskWithRequest:params completionHandler:handler];
    }
    else if([params isKindOfClass:[NSURL class]]) {
        dataTask = [NSURLSession.sharedSession dataTaskWithURL:params completionHandler:handler];
    }
    else{
        NSParameterAssert([params isKindOfClass:[NSURLRequest class]] || [params isKindOfClass:[NSURL class]]);

    }
    [dataTask resume];
    return dataTask;
}

+ (NSURLSessionUploadTask *)sendSynUploadRequest:(NSURLRequest *)request fromFile:(id)fromFile handler:(void (^)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error))handler{
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
    else {
        NSParameterAssert([fromFile isKindOfClass:[NSURL class]] || [fromFile isKindOfClass:[NSData class]]);

    }
    [dataTask resume];
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    return dataTask;
}

+ (NSURLSessionUploadTask *)sendAsyUploadRequest:(NSURLRequest *)request fromData:(id)fromFile handler:(void (^)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error))handler{
    NSURLSessionUploadTask *dataTask = nil;
    if ([fromFile isKindOfClass:[NSURL class]]) {
        dataTask = [NSURLSession.sharedSession uploadTaskWithRequest:request fromFile:fromFile completionHandler:handler];
    }
    else if([fromFile isKindOfClass:[NSData class]]) {
        dataTask = [NSURLSession.sharedSession uploadTaskWithRequest:request fromData:fromFile completionHandler:handler];
    }
    else{
        NSParameterAssert([fromFile isKindOfClass:[NSURL class]] || [fromFile isKindOfClass:[NSData class]]);

    }
    [dataTask resume];
    return dataTask;
}

+ (NSURLSessionDownloadTask *)sendSynDownloadRequest:(id)params handler:(void (^)(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error))handler{
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    
    NSURLSessionDownloadTask *dataTask = nil;
    if ([params isKindOfClass:[NSURLRequest class]]) {
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
        NSParameterAssert([params isKindOfClass:[NSURLRequest class]] || [params isKindOfClass:[NSURL class]] || [params isKindOfClass:[NSData class]]);

    }
    [dataTask resume];
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    return dataTask;
}

+ (NSURLSessionDownloadTask *)sendAsynDownloadRequest:(id)params handler:(void (^)(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error))handler{
    NSURLSessionDownloadTask *dataTask = nil;
    if ([params isKindOfClass:[NSURLRequest class]]) {
        dataTask = [NSURLSession.sharedSession downloadTaskWithRequest:params completionHandler:handler];
    }
    else if([params isKindOfClass:[NSURL class]]){
        dataTask = [NSURLSession.sharedSession downloadTaskWithURL:params completionHandler:handler];
    }
    else if([params isKindOfClass:[NSData class]]){
        dataTask = [NSURLSession.sharedSession downloadTaskWithResumeData:params completionHandler:handler];
    }
    else{
        NSParameterAssert([params isKindOfClass:[NSURLRequest class]] || [params isKindOfClass:[NSURL class]] || [params isKindOfClass:[NSData class]]);

    }
    [dataTask resume];
    return dataTask;
}

@end
