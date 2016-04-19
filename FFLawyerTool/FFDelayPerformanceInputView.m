//
//  FFDelayPerformanceInputView.m
//  FFLawyerTool
//
//  Created by fanly frank on 4/12/16.
//  Copyright © 2016 fanly frank. All rights reserved.
//
#import <Masonry/Masonry.h>
#import "FFDelayPerformanceInputView.h"
#import "FFGlobalMacro.h"

@implementation FFDelayPerformanceInputView

- (void)commonInit {
    
    [super commonInit];
    
    _startDateBtn = [[UIButton alloc] init];
    [self.startDateBtn setBackgroundImage:[UIImage imageNamed:@"btn_bg"] forState:UIControlStateNormal];
    [self.startDateBtn setTitle:@"起始时间" forState:UIControlStateNormal];
    self.startDateBtn.titleLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    
    _startDateTipsBtn = [[UIButton alloc] init];
    self.startDateTipsBtn.tag = 0;
    [self.startDateTipsBtn setBackgroundImage:[UIImage imageNamed:@"help"] forState:UIControlStateNormal];
    self.startDateTipsBtn.titleLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleCaption1];
    
    _endDateBtn = [[UIButton alloc] init];
    self.endDateBtn.tag = 1;
    [self.endDateBtn setBackgroundImage:[UIImage imageNamed:@"btn_bg"] forState:UIControlStateNormal];
    [self.endDateBtn setTitle:@"结束时间" forState:UIControlStateNormal];
    self.endDateBtn.titleLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    
    _endDateTipsBtn = [[UIButton alloc] init];
    self.endDateTipsBtn.tag = 1;
    [self.endDateTipsBtn setBackgroundImage:[UIImage imageNamed:@"help"] forState:UIControlStateNormal];
    self.endDateTipsBtn.titleLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleCaption1];
    
    [self addSubview:self.startDateBtn];
    [self addSubview:self.startDateTipsBtn];
    [self addSubview:self.endDateBtn];
    [self addSubview:self.endDateTipsBtn];
    
}

- (void)addConstraintsToSubviews {
    
    [super addConstraintsToSubviews];
    
    [self.startDateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.principleTextField.mas_bottom).with.offset(self.padding.top);
        make.centerX.equalTo(self.principleTextField.mas_centerX);
        make.width.equalTo(self.principleTextField.mas_width);
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
@end
