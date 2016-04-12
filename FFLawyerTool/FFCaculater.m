//
//  FFCaculater.m
//  FFLawyerTool
//
//  Created by fanly frank on 4/4/16.
//  Copyright © 2016 fanly frank. All rights reserved.
//

#import <YYModel/YYModel.h>

#import "FFCaculater.h"
#import "FFDelayPerformanceInputModel.h"
#import "FFFineInterestInputModel.h"
#import "FFBaseOutputModel.h"
#import "FFLoanInterestRateFactory.h"
#import "FFLoanInterestRateModel.h"
#import "HttpClient.h"

@interface FFCaculater ()

@property (strong, nonatomic) HttpClient *httpClient;

@end

@implementation FFCaculater

+ (instancetype)sharedCaculater {
    
    static id caculater;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        caculater = [[self alloc] init];
    });
    
    return caculater;
}

- (instancetype)init {
    
    self = [super init];
    
    if (self) {
        _httpClient = [HttpClient sharedClient];
    }
    
    return self;
}

- (void)caculateDeferredUtionExpenses:(FFDelayPerformanceInputModel *)inputModel
                              success:(void(^)(FFBaseOutputModel *result))success
                              failure:(void(^)(NSError *error))failure {
    
    NSAssert(inputModel, @"input model can't be nil!");
    NSAssert(inputModel.princeple, @"input model's princeple can't be nil!");
    NSAssert(inputModel.startDate, @"input model's startDate can't be nil!");
    NSAssert(inputModel.endDate, @"input model's endDate can't be nil!");
    
    //FFBaseOutputModel *result = [FFBaseOutputModel new];

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy.MM.dd"];
    
    
    NSString *startDate = [formatter stringFromDate:inputModel.startDate];
    NSString *endDate = [formatter stringFromDate:inputModel.endDate];
    
    NSDictionary *params = @{@"startDate":startDate, @"endDate":endDate, @"princeple":inputModel.princeple};
    [self.httpClient getApi:@"caculate/delayPerformance" params:params progress:^(NSProgress *downloadProgress) {
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if (success) {
            NSDictionary *dic = responseObject[@"obj"];
            FFBaseOutputModel *result = [FFBaseOutputModel yy_modelWithDictionary:dic];
            success(result);
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        if (failure) {
            failure(error);
        }
    }];

}

- (void)caculateFineInterest:(FFFineInterestInputModel *)inputModel
                     success:(void(^)(FFBaseOutputModel *result))success
                     failure:(void(^)(NSError *error))failure {
    
    NSAssert(inputModel, @"input model can't be nil!");
    NSAssert(inputModel.princeple, @"input model's princeple can't be nil!");
    NSAssert(inputModel.startDate, @"input model's startDate can't be nil!");
    NSAssert(inputModel.endDate, @"input model's endDate can't be nil!");
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy.MM.dd"];
    
    
    NSString *startDate = [formatter stringFromDate:inputModel.startDate];
    NSString *endDate = [formatter stringFromDate:inputModel.endDate];
    
    NSNumber *maxRate = inputModel.maxRate;
    NSNumber *minRate = inputModel.minRate;
    if (!maxRate) {
        maxRate = @0;
    }
    if (!minRate) {
        minRate = @0;
    }
    
    NSDictionary *params = @{@"startDate":startDate, @"endDate":endDate, @"princeple":inputModel.princeple, @"maxRate":maxRate, @"minRate":minRate};
    
    [self.httpClient getApi:@"caculate/fineInterest" params:params progress:^(NSProgress *downloadProgress) {
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if (success) {
            NSDictionary *dic = responseObject[@"obj"];
            FFBaseOutputModel *result = [FFBaseOutputModel yy_modelWithDictionary:dic];
            success(result);
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        if (failure) {
            failure(error);
        }
        
    }];
}
@end
