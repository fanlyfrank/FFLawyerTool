//
//  FFCaculater.h
//  FFLawyerTool
//
//  Created by fanly frank on 4/4/16.
//  Copyright © 2016 fanly frank. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FFBaseInputModel;
@class FFBaseOutputModel;

@interface FFCaculater : NSObject

- (void)caculateDeferredUtionExpenses:(FFBaseInputModel *)inputModel
                              success:(void(^)(FFBaseOutputModel *result))success
                              failure:(void(^)(NSError *error))failure;
@end
