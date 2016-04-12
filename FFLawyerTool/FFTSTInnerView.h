//
//  FFTSTInnerView.h
//  FFLawyerTool
//
//  Created by fanly frank on 4/6/16.
//  Copyright © 2016 fanly frank. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FFTSTInnerView : UIView

@property (strong, nonatomic) UITextField *principleTextField;
@property (strong, nonatomic) UIButton *startCalculateBtn;

@property (assign, nonatomic) UIEdgeInsets padding;
@property (assign, nonatomic) UIEdgeInsets minPadding;

- (void)commonInit;
- (void)addConstraintsToSubviews;
@end
