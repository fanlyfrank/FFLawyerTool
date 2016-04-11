//
//  FFCaculater.m
//  FFLawyerTool
//
//  Created by fanly frank on 4/4/16.
//  Copyright © 2016 fanly frank. All rights reserved.
//

#import "FFCaculater.h"
#import "FFBaseInputModel.h"
#import "FFBaseOutputModel.h"
#import "FFLoanInterestRateFactory.h"
#import "FFLoanInterestRateModel.h"

@implementation FFCaculater

- (void)caculateDeferredUtionExpenses:(FFBaseInputModel *)inputModel
                              success:(void(^)(FFBaseOutputModel *result))success
                              failure:(void(^)(NSError *error))failure {
    
    NSAssert(inputModel, @"input model can't be nil!");
    NSAssert(inputModel.princeple, @"input model's princeple can't be nil!");
    NSAssert(inputModel.startDate, @"input model's startDate can't be nil!");
    NSAssert(inputModel.endDate, @"input model's endDate can't be nil!");
    NSAssert([inputModel.startDate compare:inputModel.endDate] == NSOrderedDescending,
             @"start date can't later at end date");
    
    FFBaseOutputModel *result = [FFBaseOutputModel new];

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMdd"];
    NSDateFormatter *briefFormatter = [[NSDateFormatter alloc] init];
    [briefFormatter setDateFormat:@"yy.MM.dd"];
    
    NSDate *topInflectionPoint = [formatter dateFromString:@"20140801"];
    
    NSDate *startDate = inputModel.startDate;
    NSDate *endDate = inputModel.endDate;
    
   // NSArray *deferredPeriods = [self getDeferredPeriodsWithStart:startDate end:endDate];
    
    
    if ([startDate isEqualToDate:topInflectionPoint] ||
        [startDate laterDate:topInflectionPoint]) {
        
        NSTimeInterval interval = [endDate timeIntervalSinceDate:startDate];
        NSTimeInterval intervalOfDay = interval / (24 * 3600);
        intervalOfDay ++;
        
        result.totalResult = [NSNumber numberWithDouble:[inputModel.princeple doubleValue] *
                              intervalOfDay *
                              0.000175];
        
        result.parts = @[@{@"period": [NSString stringWithFormat:@"%@~%@共%.0f天",
                                       [briefFormatter stringFromDate:startDate],
                                       [briefFormatter stringFromDate:endDate],
                                       intervalOfDay], @"result":
                                      [NSString stringWithFormat:@"%.2f",
                                       [result.totalResult doubleValue]]}];
        success(result);
    }
    
    else {
        
        result.totalResult = @250;
        result.parts = @[@{@"period": [NSString stringWithFormat:@"%@~%@共%.0f天",
                                       [briefFormatter stringFromDate:startDate],
                                       [briefFormatter stringFromDate:endDate],
                                       3.f], @"result":
                               [NSString stringWithFormat:@"%.2f",
                                [result.totalResult doubleValue]]}];
        
    }

}

- (NSArray *)getDeferredPeriodsWithStart:(NSDate *)start end:(NSDate *)end {
    
    NSArray *dateAndRateinfllectionArray = [[FFLoanInterestRateFactory sharedFactory] getLoanInterestRageArray];
    
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:2];
    
    NSLog(@"add date is: %@", start);
    [result addObject:start];
    
    for (FFLoanInterestRateModel *model in dateAndRateinfllectionArray) {
        
        if ([model.startDate compare:start] == NSOrderedDescending &&
            [model.startDate compare:end] == NSOrderedAscending) {
            
            NSLog(@"add date is: %@", model.startDate);
            [result addObject:model.startDate];
        }
        
        else {
            break;
        }
        
    }
    
    NSLog(@"add date is: %@", end);
    [result addObject:end];
    
    return result;
}

@end
