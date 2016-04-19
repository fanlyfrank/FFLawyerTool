//
//  FFFineInterestInputView.m
//  FFLawyerTool
//
//  Created by fanly frank on 4/12/16.
//  Copyright © 2016 fanly frank. All rights reserved.
//

#import <Masonry/Masonry.h>
#import "FFGlobalMacro.h"
#import "FFFineInterestInputView.h"

@implementation FFFineInterestInputView

- (void)commonInit {
    
    [super commonInit];
    
    _minRateTextField = [[UITextField alloc] init];
    self.minRateTextField.tag = 1;
    self.minRateTextField.userInteractionEnabled = NO;
    self.minRateTextField.textColor = FFMainColor;
    self.minRateTextField.background = [UIImage imageNamed:@"input_disactive_bg"];
    self.minRateTextField.textAlignment = NSTextAlignmentCenter;
    self.minRateTextField.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    self.minRateTextField.attributedPlaceholder =
    [[NSAttributedString alloc]
     initWithString:@"暂不可用"
     attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    self.minRateTextField.keyboardType = UIKeyboardTypeDecimalPad;
    self.minRateTextField.tintColor = FFMainColor;
    
    _maxRateTextField = [[UITextField alloc] init];
    self.maxRateTextField.tag = 2;
    self.maxRateTextField.userInteractionEnabled = NO;
    self.maxRateTextField.textColor = FFMainColor;
    self.maxRateTextField.background = [UIImage imageNamed:@"input_disactive_bg"];
    self.maxRateTextField.textAlignment = NSTextAlignmentCenter;
    self.maxRateTextField.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    self.maxRateTextField.attributedPlaceholder =
    [[NSAttributedString alloc]
     initWithString:@"暂不可用"
     attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    self.maxRateTextField.keyboardType = UIKeyboardTypeDecimalPad;
    self.maxRateTextField.tintColor = FFMainColor;
    
    [self addSubview:self.minRateTextField];
    [self addSubview:self.maxRateTextField];
}

- (void)addConstraintsToSubviews {
    
    [self.principleTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).with.offset(self.padding.top);
        make.centerX.equalTo(self.mas_centerX);
        make.left.equalTo(self.mas_left).with.offset(self.padding.left);
        make.right.equalTo(self.mas_right).with.offset(-self.padding.right);
        make.height.equalTo(@44);
    }];
    
    [self.minRateTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.principleTextField.mas_bottom).with.offset(self.padding.top);
        make.centerX.equalTo(self.principleTextField.mas_centerX);
        make.width.equalTo(self.principleTextField.mas_width);
        make.height.equalTo(self.principleTextField.mas_height);
    }];
    
    [self.maxRateTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.minRateTextField.mas_bottom).with.offset(self.padding.top);
        make.centerX.equalTo(self.minRateTextField.mas_centerX);
        make.width.equalTo(self.minRateTextField.mas_width);
        make.height.equalTo(self.principleTextField.mas_height);
    }];
    
    [self.startDateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.maxRateTextField.mas_bottom).with.offset(self.padding.top);
        make.centerX.equalTo(self.maxRateTextField.mas_centerX);
        make.width.equalTo(self.maxRateTextField.mas_width);
        make.height.equalTo(self.principleTextField.mas_height);
    }];
    
    [self.startDateTipsBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.startDateBtn.mas_trailing).with.offset(self.minPadding.left);
        make.centerY.equalTo(self.startDateBtn.mas_centerY);
        make.width.equalTo(@44);
        make.height.equalTo(self.principleTextField.mas_height);
    }];
    
    [self.endDateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.startDateBtn.mas_bottom).with.offset(self.padding.top);
        make.centerX.equalTo(self.startDateBtn.mas_centerX);
        make.width.equalTo(self.startDateBtn.mas_width);
        make.height.equalTo(self.principleTextField.mas_height);
    }];
    
    [self.endDateTipsBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.endDateBtn.mas_trailing).with.offset(self.minPadding.left);
        make.centerY.equalTo(self.endDateBtn.mas_centerY);
        make.width.equalTo(@44);
        make.height.equalTo(self.principleTextField.mas_height);
    }];
    
    [self.startCalculateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.endDateBtn.mas_bottom).with.offset(self.padding.top);
        make.centerX.equalTo(self.endDateBtn.mas_centerX);
        make.width.equalTo(self.endDateBtn.mas_width);
        make.height.equalTo(self.principleTextField.mas_height);
        make.bottom.equalTo(self.mas_bottom).with.offset(self.padding.bottom);
    }];

}

- (void)switchMinRateTextFieldToActive {
    self.minRateTextField.userInteractionEnabled = YES;
    self.minRateTextField.attributedPlaceholder =
    [[NSAttributedString alloc]
     initWithString:@"输入1996.4.30前的利率"
     attributes:@{NSForegroundColorAttributeName:FFMainColor}];
    self.minRateTextField.background = nil;
    self.minRateTextField.background = [UIImage imageNamed:@"input_active_bg"];
}

- (void)switchMinRateTextFieldToDisactive {
    self.minRateTextField.userInteractionEnabled = NO;
    self.minRateTextField.text = nil;
    self.minRateTextField.attributedPlaceholder =
    [[NSAttributedString alloc]
     initWithString:@"暂不可用"
     attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    
    self.minRateTextField.background = [UIImage imageNamed:@"input_disactive_bg"];
}

- (void)switchMaxRateTextFieldToActive {
    self.maxRateTextField.userInteractionEnabled = YES;
    self.maxRateTextField.attributedPlaceholder =
    [[NSAttributedString alloc]
     initWithString:@"输入2014.1.1后的利率"
     attributes:@{NSForegroundColorAttributeName:FFMainColor}];
    self.maxRateTextField.background = nil;
    self.maxRateTextField.background = [UIImage imageNamed:@"input_active_bg"];
}

- (void)switchMaxRateTextFieldToDisactive {
    self.maxRateTextField.userInteractionEnabled = NO;
    self.maxRateTextField.text = nil;
    self.maxRateTextField.attributedPlaceholder =
    [[NSAttributedString alloc]
     initWithString:@"暂不可用"
     attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    
    self.maxRateTextField.background = [UIImage imageNamed:@"input_disactive_bg"];
}
@end
