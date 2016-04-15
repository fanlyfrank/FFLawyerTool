//
//  FFTSTInnerViewFactory.m
//  FFLawyerTool
//
//  Created by fanly frank on 4/6/16.
//  Copyright © 2016 fanly frank. All rights reserved.
//

#import "FFTSTInnerViewFactory.h"
#import "FFTSTInnerView.h"
#import "FFDelayPerformanceInputView.h"
#import "FFFineInterestInputView.h"
#import "FFCountableInputView.h"

@implementation FFTSTInnerViewFactory

+ (instancetype)sharedFactory {
    
    static id innerViewFactory;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        innerViewFactory = [[self alloc] init];
    });
    
    return innerViewFactory;
}


- (FFTSTInnerView *)creatInnerViewByType:(FFTSTInnerViewType)type {
    
    FFTSTInnerView *result;
    
    switch (type) {
    
        case FFTSTInnerViewTypeDeferredUtion:
            result = [[FFDelayPerformanceInputView alloc ] init];
            break;
           
        case FFTSTInnerViewTypeFineInterest:
            result = [[FFFineInterestInputView alloc] init];
            break;
            
        case FFTSTInnerViewTypeMaintenamce:
            result = [[FFCountableInputView alloc] init];
            break;
            
        default:
            break;
    
    }
    
    return result;
}
@end
