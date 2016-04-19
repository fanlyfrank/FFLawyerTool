//
//  BaseOutputModel.m
//  FFLawyerTool
//
//  Created by fanly frank on 4/4/16.
//  Copyright © 2016 fanly frank. All rights reserved.
//

#import "FFBaseOutputModel.h"
#import "FFOutputPartModel.h"

@implementation FFBaseOutputModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"parts" : [FFOutputPartModel class]};
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.startDate forKey:@"startDate"];
    [aCoder encodeObject:self.endDate forKey:@"enDate"];
    [aCoder encodeObject:self.totalResult forKey:@"totalResult"];
    [aCoder encodeObject:self.parts forKey:@"parts"];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.startDate = [aDecoder decodeObjectForKey:@"startDate"];
        self.endDate = [aDecoder decodeObjectForKey:@"endDate"];
        self.totalResult = [aDecoder decodeObjectForKey:@"totalResult"];
        self.parts = [aDecoder decodeObjectForKey:@"parts"];
    }
    return self;
}
@end
