//
//  NSURLSession+Helper.h
//  BNCategory
//
//  Created by BIN on 2018/11/28.
//



NS_ASSUME_NONNULL_BEGIN

@interface NSURLSession (Helper)

+ (NSURLSessionDataTask *)sendSynRequest:(id)params handler:(void (^)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error))handler;

+ (NSURLSessionDataTask *)sendAsynRequest:(id)params handler:(void (^)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error))handler;

+ (NSURLSessionUploadTask *)sendSynUploadRequest:(nonnull NSURLRequest *)request fromFile:(id)fromFile handler:(void (^)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error))handler;

+ (NSURLSessionUploadTask *)sendAsyUploadRequest:(nonnull NSURLRequest *)request fromData:(id)fromFile handler:(void (^)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error))handler;

+ (NSURLSessionDownloadTask *)sendSynDownloadRequest:(id)params handler:(void (^)(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error))handler;

+ (NSURLSessionDownloadTask *)sendAsynDownloadRequest:(id)params handler:(void (^)(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error))handler;

@end

NS_ASSUME_NONNULL_END
