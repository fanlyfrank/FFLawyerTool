//
//  FFloanInterestRateFactory.h
//  FFLawyerTool
//
//  Created by fanly frank on 4/8/16.
//  Copyright © 2016 fanly frank. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FFLoanInterestRateFactory : NSObject

+ (instancetype)sharedFactory;

- (NSArray *)getLoanInterestRageArray;

@end
