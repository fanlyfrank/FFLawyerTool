//
//  FFFineInterestInputView.h
//  FFLawyerTool
//
//  Created by fanly frank on 4/12/16.
//  Copyright © 2016 fanly frank. All rights reserved.
//

#import "FFDelayPerformanceInputView.h"

@interface FFFineInterestInputView : FFDelayPerformanceInputView

@property UITextField *minRateTextField;

@property UITextField *maxRateTextField;

- (void)switchMinRateTextFieldToActive;
- (void)switchMinRateTextFieldToDisactive;

- (void)switchMaxRateTextFieldToActive;
- (void)switchMaxRateTextFieldToDisactive;

@end
