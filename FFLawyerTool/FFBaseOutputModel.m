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

@end
