//
//  FFDelayPerformanceModel.h
//  FFLawyerTool
//
//  Created by fanly frank on 4/12/16.
//  Copyright © 2016 fanly frank. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FFDelayPerformanceInputModel.h"
#import "FFBaseInputModel.h"

@interface FFDelayPerformanceInputModel : FFBaseInputModel

@property (strong, nonatomic) NSDate *startDate;
@property (strong, nonatomic) NSDate *endDate;

@end
