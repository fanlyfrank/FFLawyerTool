//
//  FFTSTInnerView.m
//  FFLawyerTool
//
//  Created by fanly frank on 4/6/16.
//  Copyright © 2016 fanly frank. All rights reserved.
//

#import <Masonry/Masonry.h>
#import "FFTSTInnerView.h"

@implementation FFTSTInnerView

- (instancetype)init {
    
    self =  [super init];
    
    if (self) {
        [self commonInit];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        [self commonInit];
    }
    
    return self;
}

- (void)commonInit {
    
    _principleTextField = [[UITextField alloc] init];
    self.principleTextField.backgroundColor = [UIColor grayColor];
    self.principleTextField.textAlignment = NSTextAlignmentCenter;
    self.principleTextField.textColor = [UIColor redColor];
    self.principleTextField.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    self.principleTextField.attributedPlaceholder =
    [[NSAttributedString alloc]
     initWithString:@"输入本金"
     attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    self.principleTextField.keyboardType = UIKeyboardTypeNumberPad;
    
    _startDateBtn = [[UIButton alloc] init];
    self.startDateBtn.backgroundColor = [UIColor blueColor];
    [self.startDateBtn setTitle:@"起始时间" forState:UIControlStateNormal];
    self.startDateBtn.titleLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    
    _startDateTipsBtn = [[UIButton alloc] init];
    self.startDateTipsBtn.tag = 0;
    self.startDateTipsBtn.backgroundColor = [UIColor blueColor];
    [self.startDateTipsBtn setTitle:@"帮助" forState:UIControlStateNormal];
    self.startDateTipsBtn.titleLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleCaption1];
    
    _endDateBtn = [[UIButton alloc] init];
    self.endDateBtn.tag = 1;
    self.endDateBtn.backgroundColor = [UIColor blueColor];
    [self.endDateBtn setTitle:@"结束时间" forState:UIControlStateNormal];
    self.endDateBtn.titleLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    
    _endDateTipsBtn = [[UIButton alloc] init];
    self.endDateTipsBtn.tag = 1;
    self.endDateTipsBtn.backgroundColor = [UIColor blueColor];
    [self.endDateTipsBtn setTitle:@"帮助" forState:UIControlStateNormal];
    self.endDateTipsBtn.titleLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleCaption1];
    
    _startCalculateBtn = [[UIButton alloc] init];
    self.startCalculateBtn.backgroundColor = [UIColor blueColor];
    [self.startCalculateBtn setTitle:@"开始计算" forState:UIControlStateNormal];
    self.startCalculateBtn.titleLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    
    UIView *bottomBlankView = [[UIView alloc] init];
    bottomBlankView.backgroundColor = [UIColor greenColor];
    
    
    UIEdgeInsets padding = UIEdgeInsetsMake(20, 60, 20, 60);
    UIEdgeInsets minPadding = UIEdgeInsetsMake(10, 10, 10, 10);
    
    [self addSubview:self.principleTextField];
    [self addSubview:self.startDateBtn];
    [self addSubview:self.startDateTipsBtn];
    [self addSubview:self.endDateBtn];
    [self addSubview:self.endDateTipsBtn];
    [self addSubview:self.startCalculateBtn];
    
    
    [self.principleTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).with.offset(padding.top);
        make.centerX.equalTo(self.mas_centerX);
        make.left.equalTo(self.mas_left).with.offset(padding.left);
        make.right.equalTo(self.mas_right).with.offset(-padding.right);
        make.height.equalTo(@44);
    }];
    
    [self.startDateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.principleTextField.mas_bottom).with.offset(padding.top);
        make.centerX.equalTo(self.principleTextField.mas_centerX);
        make.width.equalTo(self.principleTextField.mas_width);
        make.height.equalTo(self.principleTextField.mas_height);
    }];
    
    [self.startDateTipsBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.startDateBtn.mas_trailing).with.offset(minPadding.left);
        make.centerY.equalTo(self.startDateBtn.mas_centerY);
        make.width.equalTo(@44);
        make.height.equalTo(self.principleTextField.mas_height);
    }];
    
    [self.endDateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.startDateBtn.mas_bottom).with.offset(padding.top);
        make.centerX.equalTo(self.startDateBtn.mas_centerX);
        make.width.equalTo(self.startDateBtn.mas_width);
        make.height.equalTo(self.principleTextField.mas_height);
    }];
    
    [self.endDateTipsBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.endDateBtn.mas_trailing).with.offset(minPadding.left);
        make.centerY.equalTo(self.endDateBtn.mas_centerY);
        make.width.equalTo(@44);
        make.height.equalTo(self.principleTextField.mas_height);
    }];
    
    [self.startCalculateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.endDateBtn.mas_bottom).with.offset(padding.top);
        make.centerX.equalTo(self.endDateBtn.mas_centerX);
        make.width.equalTo(self.endDateBtn.mas_width);
        make.height.equalTo(self.principleTextField.mas_height);
        make.bottom.equalTo(self.mas_bottom).with.offset(padding.bottom);
    }];
    
}

@end
