//
//  FFloanInterestRateModel.h
//  FFLawyerTool
//
//  Created by fanly frank on 4/8/16.
//  Copyright © 2016 fanly frank. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FFLoanInterestRateModel : NSObject

@property (strong, nonatomic) NSDate *startDate;
@property (strong, nonatomic) NSNumber *rateLevel1;
@property (strong, nonatomic) NSNumber *rateLevel2;
@property (strong, nonatomic) NSNumber *rateLevel3;
@property (strong, nonatomic) NSNumber *rateLevel4;
@property (strong, nonatomic) NSNumber *rateLevel5;

@end
