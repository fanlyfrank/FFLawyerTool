//
//  FFOutputPartModel.m
//  FFLawyerTool
//
//  Created by fanly frank on 4/12/16.
//  Copyright © 2016 fanly frank. All rights reserved.
//

#import "FFOutputPartModel.h"

@implementation FFOutputPartModel

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.amount forKey:@"amount"];
    [aCoder encodeObject:self.diffDays forKey:@"diffDays"];
    [aCoder encodeObject:self.rate forKey:@"rate"];
    
    [aCoder encodeObject:self.startDate forKey:@"startDate"];
    [aCoder encodeObject:self.endDate forKey:@"endDate"];
}

- (id)initWihtCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.amount = [aDecoder decodeObjectForKey:@"amount"];
        self.diffDays = [aDecoder decodeObjectForKey:@"diffDays"];
        self.rate = [aDecoder decodeObjectForKey:@"rate"];
        
        self.startDate = [aDecoder decodeObjectForKey:@"startDate"];
        self.endDate = [aDecoder decodeObjectForKey:@"endDate"];
    }
    return self;
}
@end
