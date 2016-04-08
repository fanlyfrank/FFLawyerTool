//
//  FFloanInterestRateFactory.m
//  FFLawyerTool
//
//  Created by fanly frank on 4/8/16.
//  Copyright © 2016 fanly frank. All rights reserved.
//

#import "FFLoanInterestRateFactory.h"
#import "FFLoanInterestRateModel.h"

@implementation FFLoanInterestRateFactory

+ (instancetype)sharedFactory {
    
    static id loanInterestRateFactory;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        loanInterestRateFactory = [[self alloc] init];
    });
    
    return loanInterestRateFactory;
}

- (NSArray *)getLoanInterestRageArray {
    
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:35];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy.MM.dd"];
    
    FFLoanInterestRateModel *model4 = [[FFLoanInterestRateModel alloc] init];
    model4.startDate = [formatter dateFromString:@"2011.07.07"];
    model4.rateLevel1 = [NSNumber numberWithDouble:0.0610];
    model4.rateLevel2 = [NSNumber numberWithDouble:0.0656];
    model4.rateLevel3 = [NSNumber numberWithDouble:0.0665];
    model4.rateLevel4 = [NSNumber numberWithDouble:0.0690];
    model4.rateLevel5 = [NSNumber numberWithDouble:0.0705];
    [result addObject:model4];
    
    FFLoanInterestRateModel *model3 = [[FFLoanInterestRateModel alloc] init];
    model3.startDate = [formatter dateFromString:@"2012.06.08"];
    model3.rateLevel1 = [NSNumber numberWithDouble:0.0585];
    model3.rateLevel2 = [NSNumber numberWithDouble:0.0631];
    model3.rateLevel3 = [NSNumber numberWithDouble:0.0640];
    model3.rateLevel4 = [NSNumber numberWithDouble:0.0665];
    model3.rateLevel5 = [NSNumber numberWithDouble:0.0680];
    [result addObject:model3];
    
    FFLoanInterestRateModel *model2 = [[FFLoanInterestRateModel alloc] init];
    model2.startDate = [formatter dateFromString:@"2012.07.06"];
    model2.rateLevel1 = [NSNumber numberWithDouble:0.0560];
    model2.rateLevel2 = [NSNumber numberWithDouble:0.0600];
    model2.rateLevel3 = [NSNumber numberWithDouble:0.0615];
    model2.rateLevel4 = [NSNumber numberWithDouble:0.0640];
    model2.rateLevel5 = [NSNumber numberWithDouble:0.0655];
    [result addObject:model2];
    
    FFLoanInterestRateModel *model1 = [[FFLoanInterestRateModel alloc] init];
    model1.startDate = [formatter dateFromString:@"2014.08.01"];
    model1.rateLevel1 = [NSNumber numberWithDouble:0.0000175];
    [result addObject:model1];
    
    return result;
}

@end
