//
//  BaseOutputModel.h
//  FFLawyerTool
//
//  Created by fanly frank on 4/4/16.
//  Copyright © 2016 fanly frank. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FFBaseOutputModel : NSObject

@property (copy, nonatomic) NSString *startDate;
@property (copy, nonatomic) NSString *endDate;
@property (strong, nonatomic) NSNumber *totalResult;

@property (strong, nonatomic) NSArray *parts;

@end
