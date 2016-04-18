//
//  HttpClient.m
//  EduChat
//
//  Created by fanly on 14-7-21.
//  Copyright (c) 2014年 DWD. All rights reserved.
//

#import "HttpClient.h"
#import "MBProgressHUD+Addition.h"
#import "AppDelegate.h"

static NSString *const kSuccessStatusCode = @"1";

@interface HttpClient()

@property (strong, nonatomic) AFHTTPRequestSerializer *requestSerializerHTTPType;
@property (strong, nonatomic) AFHTTPRequestSerializer *requestSerializerJSONType;

@end

@implementation HttpClient

static HttpClient *_sharedClient;


+ (instancetype)sharedClient
{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{

        //网络超时, 默认超时时间为40s
        //SessionConfiguration必须在session（httpclient）之前进行设置
        NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
        sessionConfiguration.timeoutIntervalForRequest = 40.0;
        
        _sharedClient = [[HttpClient alloc] initWithBaseURL:[NSURL URLWithString:/*@"http://192.168.5.24:8080"*/@"http://fanlyfrank-lawyertool.daoapp.io/LawyerTool/"]
                                       sessionConfiguration:sessionConfiguration];
        // 接收时的contenttype
        _sharedClient.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",
                                                                   @"application/json", nil];
        _sharedClient.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringCacheData;
        _sharedClient.requestSerializerHTTPType = [[AFHTTPRequestSerializer alloc] init];
        _sharedClient.requestSerializerJSONType = [[AFJSONRequestSerializer alloc] init];
   
        [[AFNetworkReachabilityManager sharedManager]
         setReachabilityStatusChangeBlock:
         ^(AFNetworkReachabilityStatus status) {
             
             UIWindow *mainWindow = [UIApplication sharedApplication].keyWindow;
             NSString *showMsg;
             BOOL showSuccess;
             
             switch (status) {

                
                case AFNetworkReachabilityStatusUnknown:
                     showMsg = @"未知网络！";
                     showSuccess = NO;
                     break;
                    
                case AFNetworkReachabilityStatusNotReachable:
                     showMsg = @"无法连接网络！";
                     showSuccess = NO;
                     break;
                    
                case AFNetworkReachabilityStatusReachableViaWiFi:
                     showMsg = @"已连接WIFI！";
                     showSuccess = YES;
                     break;
                
                        
                case AFNetworkReachabilityStatusReachableViaWWAN:
                     showMsg = @"正在使用移动网络！";
                     showSuccess = YES;
                     break;
    
                default:
                     showMsg = @"网络连接异常！";
                     showSuccess = NO;
                     break;
             }
             
             [MBProgressHUD showToastWithTitle:showMsg success:showSuccess superContainer:mainWindow];
        }];
        
        [[AFNetworkReachabilityManager sharedManager] startMonitoring];

    });
    
    return _sharedClient;
}

- (NSURLSessionDataTask *)getApi:(NSString *)api
                          params:(NSDictionary *) params
                        progress:(void (^)(NSProgress *downloadProgress))progress
                         success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                         failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {

    NSParameterAssert(api);
    NSLog(@"api: ---%@",api);
    NSLog(@"params: ---%@",params);
    self.requestSerializer = self.requestSerializerHTTPType;
    NSURLSessionDataTask *task;
    
    task = [self GET:api parameters:params
            
    progress:^(NSProgress *downloadProgress){
        if (progress) {
            progress(downloadProgress);
        }
    }
    
    success:^(NSURLSessionDataTask *task, id responseObject) {
   
        NSString *result = responseObject[@"result"];
        
        if ([kSuccessStatusCode isEqual:result]) {
            
            if (success) {
                success(task, responseObject);
            }
            
        } else {
            if (failure) {
                NSString *message = responseObject[@"errordesc"];
                NSDictionary *userInfo = @{NSLocalizedDescriptionKey:@"Network request error",
                                           NSLocalizedFailureReasonErrorKey:message};
                NSError *error = [NSError errorWithDomain:@"domain error" code:[responseObject[@"errorcode"] intValue] userInfo:userInfo];
                NSLog(@"error : %@",error);
                failure(task, error);
            }
        }
        
    }
    
    failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure) {
            [self showErrorHUD:error];
            failure(task, error);
              NSLog(@"error : %@",error);
        }
    }];
    
    return task;

}

- (NSURLSessionDataTask *)postApi:(NSString *)api
                           params:(NSDictionary *)params
                         progress:(void (^)(NSProgress *downloadProgress))progress
                          success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                          failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    NSParameterAssert(api);
    NSLog(@"api: ---%@",api);
    NSLog(@"params: ---%@",params);
    self.requestSerializer = self.requestSerializerJSONType;
    NSURLSessionDataTask *task;
    
    task = [self POST:api parameters:params
        
        progress:^(NSProgress *downloadProgress){
            
            if (progress) {
                progress(downloadProgress);
            }
                 
        }
            
        success:^(NSURLSessionDataTask *task, id responseObject) {
     
        NSString *result = responseObject[@"result"];
        
        if ([kSuccessStatusCode isEqual:result]) {
            
            if (success) {
                success(task, responseObject);
                NSLog(@"responseObject : ---%@",responseObject);
            }
            
        } else {
            
            if (failure) {
                NSString *message = responseObject[@"errordesc"];
                if (!message) {message = @"";}
                NSDictionary *userInfo = @{NSLocalizedDescriptionKey:@"Network request error",
                                           NSLocalizedFailureReasonErrorKey:message};
                NSError *error = [NSError errorWithDomain:@"domain error" code:[responseObject[@"errorcode"] intValue] userInfo:userInfo];
                
                failure(task, error);
                NSLog(@"error : ---%@",error);
            }
        }
        
    }
    
    failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure) {
            failure(task, error);
            [self showErrorHUD:error];
            NSLog(@"error : ---%@",error);
        }
    }];
    
    return task;

}

/**
 *  请求错误时，根据错误显示HUD
 *
 *  @param error 请求错误
 */
- (void)showErrorHUD:(NSError *)error {
    NSLog(@"*************\n");
    NSLog(@"-----\n");
    NSLog(@"*************\n");
    NSLog(@"code: %ld", error.code);
    switch (error.code) {
        case -1001: { //-1001为请求超时
            UIWindow *mainWindow = [UIApplication sharedApplication].keyWindow;
            [MBProgressHUD showToastWithTitle:@"请求超时" success:NO superContainer:mainWindow];
            break;
        }
            
        default:
            break;
    }
}



@end
