//
//  FFMaintenamceInputView.m
//  FFLawyerTool
//
//  Created by fanly frank on 4/15/16.
//  Copyright © 2016 fanly frank. All rights reserved.
//
#import <Masonry/Masonry.h>

#import "FFCountableInputView.h"
#import "FFGlobalMacro.h"

@implementation FFCountableInputView

- (void)commonInit {
    
    [super commonInit];
    
    self.principleTextField.attributedPlaceholder =
    [[NSAttributedString alloc]
     initWithString:@"保全财产估价"
     attributes:@{NSForegroundColorAttributeName:FFMainColor}];
    
    _countTextField = [[UITextField alloc] init];
    self.countTextField.tag = 3;
    self.countTextField.background = [UIImage imageNamed:@"input_active_bg"];
    self.countTextField.textAlignment = NSTextAlignmentCenter;
    self.countTextField.textColor = [UIColor whiteColor];
    self.countTextField.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    self.countTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入财产件数" attributes:@{NSForegroundColorAttributeName:FFMainColor}];
    self.countTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.countTextField.tintColor = [UIColor whiteColor];
    
    [self addSubview:self.countTextField];
}

- (void)addConstraintsToSubviews {
    
    [super addConstraintsToSubviews];
    
    [self.countTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.principleTextField.mas_bottom).with.offset(self.padding.top);
        make.centerX.equalTo(self.principleTextField.mas_centerX);
        make.width.equalTo(self.principleTextField.mas_width);
        make.height.equalTo(self.principleTextField.mas_height);
    }];
    
    [self.startCalculateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.countTextField.mas_bottom).with.offset(self.padding.top);
        make.centerX.equalTo(self.countTextField.mas_centerX);
        make.width.equalTo(self.countTextField.mas_width);
        make.height.equalTo(self.countTextField.mas_height);
        make.bottom.equalTo(self.mas_bottom).with.offset(self.padding.bottom);
    }];
}

@end
