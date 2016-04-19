//
//  FFCaculateResultHistoryModel.h
//  FFLawyerTool
//
//  Created by fanly frank on 4/18/16.
//  Copyright © 2016 fanly frank. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FFBaseOutputModel;
@interface FFCaculateResultHistoryModel : NSObject

@property (strong, nonatomic) NSNumber *result_id;
@property (strong, nonatomic) NSString *user_id;
@property (copy, nonatomic) NSString *alias;
@property (strong, nonatomic) NSNumber *status;
@property (copy, nonatomic) NSString *create_time;
@property (copy, nonatomic) NSString *file_path;
@property (strong, nonatomic) FFBaseOutputModel *details;

@end
