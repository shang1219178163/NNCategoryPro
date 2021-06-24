//
//  NSURLRequest+Helper.h
//  NNCategory
//
//  Created by Bin Shang on 2019/5/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

FOUNDATION_EXPORT NSString * const kHttpMethodGET ;
FOUNDATION_EXPORT NSString * const kHttpMethodPOST ;
FOUNDATION_EXPORT NSString * const kHttpMethodPUT ;
FOUNDATION_EXPORT NSString * const kHttpMethodDELETE ;

@interface NSURLRequest (Helper)

+(instancetype)requestGetURL:(NSString *)url;

+(instancetype)requestPostURL:(NSString *)url body:(NSData *_Nullable)body;

/**
 method
 */
+(instancetype)requestURL:(NSString *)url
                   method:(NSString *)method
                     body:(NSData *_Nullable)body
              cachePolicy:(NSURLRequestCachePolicy)cachePolicy
          timeoutInterval:(NSTimeInterval)timeoutInterval;

/**
 *  生成单文件上传的 multipart/form-data 请求
 *
 *  @param URL     负责上传的 url
 *  @param fileURL 要上传的本地文件 url
 *  @param name    服务器脚本字段名
 *
 *  @return multipart/form-data POST 请求，保存到服务器的文件名与本地的文件名一致
 */
+ (instancetype)requestWithURL:(NSURL *)URL fileURL:(NSURL *)fileURL name:(NSString *)name;

/**
 *  生成单文件上传的 multipart/form-data 请求
 *
 *  @param URL      负责上传的 url
 *  @param fileURL  要上传的本地文件 url
 *  @param fileName 要保存在服务器上的文件名
 *  @param name     服务器脚本字段名
 *
 *  @return multipart/form-data POST 请求
 */
+ (instancetype)requestWithURL:(NSURL *)URL
                       fileURL:(NSURL *)fileURL
                      fileName:(NSString *)fileName
                          name:(NSString *)name;

/**
 *  生成多文件上传的 multipart/form-data 请求
 *
 *  @param URL      负责上传的 url
 *  @param fileURLs 要上传的本地文件 url 数组
 *  @param name     服务器脚本字段名
 *
 *  @return multipart/form-data POST 请求，保存到服务器的文件名与本地的文件名一致
 */
+ (instancetype)requestWithURL:(NSURL *)URL fileURLs:(NSArray *)fileURLs name:(NSString *)name;

/**
 *  生成多文件上传的 multipart/form-data 请求
 *
 *  @param URL       负责上传的 url
 *  @param fileURLs  要上传的本地文件 url 数组
 *  @param fileNames 要保存在服务器上的文件名数组
 *  @param name      服务器脚本字段名
 *
 *  @return multipart/form-data POST 请求
 */
+ (instancetype)requestWithURL:(NSURL *)URL
                      fileURLs:(NSArray *)fileURLs
                     fileNames:(NSArray *)fileNames
                          name:(NSString *)name;
@end



@interface NSURLSession (Helper)
/// 同步请求
+ (NSURLSessionDataTask *)sendSynRequest:(id)params handler:(void (^)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error))handler;
/// 异步请求
+ (NSURLSessionDataTask *)sendAsynRequest:(id)params handler:(void (^)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error))handler;
/// 同步上传
+ (NSURLSessionUploadTask *)sendSynUploadRequest:(NSURLRequest *)request fromFile:(id)fromFile handler:(void (^)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error))handler;
/// 异步上传
+ (NSURLSessionUploadTask *)sendAsyUploadRequest:(NSURLRequest *)request fromData:(id)fromFile handler:(void (^)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error))handler;
/// 同步下载
+ (NSURLSessionDownloadTask *)sendSynDownloadRequest:(id)params handler:(void (^)(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error))handler;
/// 异步下载
+ (NSURLSessionDownloadTask *)sendAsynDownloadRequest:(id)params handler:(void (^)(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error))handler;

@end
NS_ASSUME_NONNULL_END
