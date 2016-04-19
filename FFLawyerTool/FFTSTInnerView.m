//
//  FFTSTInnerView.m
//  FFLawyerTool
//
//  Created by fanly frank on 4/6/16.
//  Copyright © 2016 fanly frank. All rights reserved.
//

#import <Masonry/Masonry.h>
#import "FFTSTInnerView.h"
#import "FFGlobalMacro.h"

@implementation FFTSTInnerView

- (instancetype)init {
    
    self =  [super init];
    
    if (self) {
        [self commonInit];
        [self addConstraintsToSubviews];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        [self commonInit];
        [self addConstraintsToSubviews];
    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        [self commonInit];
        [self addConstraintsToSubviews];
    }
    
    return self;
}

- (void)commonInit {
    
    _padding = UIEdgeInsetsMake(20, 60, 20, 60);
    _minPadding = UIEdgeInsetsMake(10, 10, 10, 10);
    
    _principleTextField = [[UITextField alloc] init];
    self.principleTextField.tag = 0;
    self.principleTextField.background = [UIImage imageNamed:@"input_active_bg"];
    self.principleTextField.textAlignment = NSTextAlignmentCenter;
    self.principleTextField.textColor = FFMainColor;
    self.principleTextField.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    self.principleTextField.attributedPlaceholder =
    [[NSAttributedString alloc]
     initWithString:@"输入本金"
     attributes:@{NSForegroundColorAttributeName: FFMainColor}];
    self.principleTextField.tintColor = FFMainColor;
    self.principleTextField.keyboardType = UIKeyboardTypeDecimalPad;
    
    _startCalculateBtn = [[UIButton alloc] init];
    //self.startCalculateBtn.backgroundColor = FFMainColor;
    [self.startCalculateBtn setBackgroundImage:[UIImage imageNamed:@"btn_bg"] forState:UIControlStateNormal];
    [self.startCalculateBtn setTitle:@"开始计算" forState:UIControlStateNormal];
    self.startCalculateBtn.titleLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    
    [self addSubview:self.principleTextField];
    [self addSubview:self.startCalculateBtn];
}

- (void)addConstraintsToSubviews {
    
    [self.principleTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).with.offset(self.padding.top);
        make.centerX.equalTo(self.mas_centerX);
        make.left.equalTo(self.mas_left).with.offset(self.padding.left);
        make.right.equalTo(self.mas_right).with.offset(-self.padding.right);
        make.height.equalTo(@44);
    }];
    
}

@end
