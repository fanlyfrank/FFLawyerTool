//
//  FFCaculaterResultHandler.h
//  FFLawyerTool
//
//  Created by fanly frank on 4/18/16.
//  Copyright © 2016 fanly frank. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FFCaculateResultHistoryModel;

#define FFResultTableCreatedKey @"is_result_table_created"
#define FFResultTablePaht @"/Documents/data.sqlite"
#define FFDBErrorDomain @"ff db error"
@interface FFCaculaterResultHandler : NSObject

- (void)addResult:(FFCaculateResultHistoryModel *)result
          success:(void(^)())success
          failure:(void(^)(NSError *error))failure;

- (void)updateResult:(FFCaculateResultHistoryModel *)result
             success:(void(^)())success
             failure:(void(^)(NSError *error))failure;

- (void)getResultById:(NSNumber *)resultId
              success:(void(^)(FFCaculateResultHistoryModel *result))success
              failure:(void(^)(NSError *error))failure;

- (void)getResultsByUserId:(NSString *)userId
                   success:(void(^)(NSArray *results))success
                   failure:(void(^)(NSError *error))failure;

- (void)deleteResult:(NSNumber *)resultId
              byUser:(NSString *)userId
             success:(void(^)())success
             failure:(void(^)(NSError *error))failure;

@end
