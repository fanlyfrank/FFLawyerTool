//
//  FFCaculater.h
//  FFLawyerTool
//
//  Created by fanly frank on 4/4/16.
//  Copyright © 2016 fanly frank. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FFDelayPerformanceInputModel;
@class FFFineInterestInputModel;
@class FFBaseOutputModel;

@interface FFCaculater : NSObject

+ (instancetype)sharedCaculater;

- (void)caculateDeferredUtionExpenses:(FFDelayPerformanceInputModel *)inputModel
                              success:(void(^)(FFBaseOutputModel *result))success
                              failure:(void(^)(NSError *error))failure;

- (void)caculateFineInterest:(FFFineInterestInputModel *)inputModel
                     success:(void(^)(FFBaseOutputModel *result))success
                     failure:(void(^)(NSError *error))failure;
@end
