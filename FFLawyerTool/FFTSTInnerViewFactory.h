//
//  FFTSTInnerViewFactory.h
//  FFLawyerTool
//
//  Created by fanly frank on 4/6/16.
//  Copyright © 2016 fanly frank. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FFTSTInnerView;

typedef NS_ENUM(NSInteger, FFTSTInnerViewType) {
    FFTSTInnerViewTypeDeferredUtion,
};

@interface FFTSTInnerViewFactory : NSObject

+ (instancetype)sharedFactory;

- (FFTSTInnerView *)creatInnerViewByType:(FFTSTInnerViewType)type;

@end
