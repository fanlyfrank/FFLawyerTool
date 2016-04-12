//
//  FFOutputPartModel.h
//  FFLawyerTool
//
//  Created by fanly frank on 4/12/16.
//  Copyright © 2016 fanly frank. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FFOutputPartModel : NSObject

@property (strong, nonatomic) NSNumber *amount;
@property (strong, nonatomic) NSNumber *rate;
@property (strong, nonatomic) NSNumber *diffDays;

@property (copy, nonatomic) NSString *startDate;
@property (copy, nonatomic) NSString *endDate;

@end
