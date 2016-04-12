//
//  HttpClient.h
//  iPenYou
//
//  Created by fanly on 14-7-21.
//  Copyright (c) 2015 dwd. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@interface HttpClient : AFHTTPSessionManager

+ (instancetype)sharedClient;

- (NSURLSessionDataTask *)getApi:(NSString *)api
                          params:(NSDictionary *) params
                        progress:(void (^)(NSProgress *downloadProgress))progress
                         success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                         failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

- (NSURLSessionDataTask *)postApi:(NSString *)api
                           params:(NSDictionary *)params
                         progress:(void (^)(NSProgress *downloadProgress))progress
                          success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                          failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

@end
