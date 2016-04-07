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

@implementation FFCaculater

- (void)caculateDeferredUtionExpenses:(FFBaseInputModel *)inputModel
                              success:(void(^)(FFBaseOutputModel *result))success
                              failure:(void(^)(NSError *error))failure {
    FFBaseOutputModel *result = [FFBaseOutputModel new];
    
    result.totalResult = @520;
    result.parts = @[@{@"period":@"4.1到4.5共4天", @"result":@"110"},
                     @{@"period":@"4.6到4.8共3天", @"result":@"100"},
                     @{@"period":@"4.9到4.10共2天", @"result":@"40"}];
    success(result);

}
@end
