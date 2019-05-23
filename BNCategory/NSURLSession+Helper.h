//
//  NSURLSession+Helper.h
//  BNCategory
//
//  Created by BIN on 2018/11/28.
//



NS_ASSUME_NONNULL_BEGIN

@interface NSURLSession (Helper)
/// 同步请求
+ (NSURLSessionDataTask *)sendSynRequest:(id)params handler:(void (^)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error))handler;
/// 异步请求
+ (NSURLSessionDataTask *)sendAsynRequest:(id)params handler:(void (^)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error))handler;
/// 同步上传
+ (NSURLSessionUploadTask *)sendSynUploadRequest:(nonnull NSURLRequest *)request fromFile:(id)fromFile handler:(void (^)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error))handler;
/// 异步上传
+ (NSURLSessionUploadTask *)sendAsyUploadRequest:(nonnull NSURLRequest *)request fromData:(id)fromFile handler:(void (^)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error))handler;
/// 同步下载
+ (NSURLSessionDownloadTask *)sendSynDownloadRequest:(id)params handler:(void (^)(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error))handler;
/// 异步下载
+ (NSURLSessionDownloadTask *)sendAsynDownloadRequest:(id)params handler:(void (^)(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error))handler;

@end

NS_ASSUME_NONNULL_END
