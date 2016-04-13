//
//  ViewController.m
//  FFLawyerTool
//
//  Created by fanly frank on 4/1/16.
//  Copyright © 2016 fanly frank. All rights reserved.
//

#import <MBProgressHUD/MBProgressHUD.h>
#import <Masonry/Masonry.h>
#import <TopScrollTabView/TSTView.h>

#import "FFMainViewController.h"

#import "FFTSTInnerViewFactory.h"
#import "FFTSTInnerView.h"
#import "FFDelayPerformanceInputView.h"
#import "FFFineInterestInputView.h"

#import "FFCaculater.h"
#import "FFDelayPerformanceInputModel.h"
#import "FFFineInterestInputModel.h"
#import "FFBaseOutputModel.h"
#import "FFCaculateResultDetialViewController.h"

#import "MBProgressHUD+Addition.h"


@interface FFMainViewController () <UIScrollViewDelegate, UITextFieldDelegate, TSTViewDataSource, TSTViewDelegate>

@property (strong, nonatomic) TSTView *tstview;

@property (strong, nonatomic) NSArray *tabDatas;

@property (strong, nonatomic) UIView *datePickerToobar;

@property (strong, nonatomic) UIDatePicker *datePicker;

@property (assign, nonatomic) BOOL isDatePickerInited;

@property (assign, nonatomic) NSInteger datePickerFlag;

@property (strong, nonatomic) NSArray *caculaterInputs;

@property (strong, nonatomic) FFCaculater *caculater;

@property (strong, nonatomic) FFTSTInnerViewFactory *innerViewFactory;

@property (strong, nonatomic) NSMutableArray *innerViews;

@end

@implementation FFMainViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //init datas
    _caculater = [[FFCaculater alloc] init];
    
    _tabDatas = @[@"迟延履行金", @"罚息", @"保全费", @"执行费", @"诉讼费"];
    
    _caculaterInputs = @[[FFDelayPerformanceInputModel new],
                         [FFFineInterestInputModel new],
                         [FFBaseInputModel new],
                         [FFBaseInputModel new],
                         [FFBaseInputModel new]];
    
    //setting views
    _innerViewFactory = [FFTSTInnerViewFactory sharedFactory];
    _innerViews = [[NSMutableArray alloc] initWithArray:@[[NSNull null],
                                                          [NSNull null],
                                                          [NSNull null],
                                                          [NSNull null],
                                                          [NSNull null]]];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    CGRect frame = self.view.frame;
    frame.origin.y  = 64;
    
    _tstview = [[TSTView alloc] initWithFrame:frame];
    
    self.tstview.dataSource = self;
    self.tstview.delegate = self;
    
    //this is important for content view reuse
    [self.tstview registerReusableContentViewClass:[UIScrollView class]];
    
    [self.view addSubview:self.tstview];
    
    [self.tstview reloadData];
}

#pragma mark - scrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self dismissKeyboard];
    [self hideDatePickers];
}

#pragma mark - TSTView datasouce
- (NSInteger)numberOfTabsInTSTView:(TSTView *)tstview {
    return self.tabDatas.count;
}

- (NSString *)tstview:(TSTView *)tstview titleForTabAtIndex:(NSInteger)tabIndex {
    return self.tabDatas[tabIndex];
}

- (UIView *)tstview:(TSTView *)tstview viewForSelectedTabIndex:(NSInteger)tabIndex {
    
    UIScrollView *content = [tstview dequeueReusableContentView];
    
    if (!content) {
        content = [[UIScrollView alloc] init];
        content.delegate = self;
    }
    
    [[content subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    [self getInnerViewAt:tabIndex forContent:content];

    return content;
}

#pragma mark -- TSTView delegate
- (CGFloat)heightForTabInTSTView:(TSTView *)tstview {
    return 35;
}

- (CGFloat)heightForSelectedIndicatorInTSTView:(TSTView *)tstview {
    return 2;
}

- (CGFloat)heightForTabSeparatorInTSTView:(TSTView *)tstview {
    return 1;
}

- (UIFont *)fontForTabTitleInTSTView:(TSTView *)tstview {
    return [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
}

- (UIColor *)highlightColorForTSTView:(TSTView *)tstview {
    return [UIColor blueColor];
}

- (UIColor *)normalColorForTSTView:(TSTView *)tstview {
    return [UIColor grayColor];
}

- (UIColor *)tabViewBackgroundColorForTSTView:(TSTView *)tstview {
    return [UIColor whiteColor];
}

- (UIColor *)normalColorForSeparatorInTSTView:(TSTView *)tstview {
    return [UIColor blueColor];
}

- (void)tstview:(TSTView *)tstview didSelectedTabAtIndex:(NSInteger)tabIndex {
    [self dismissKeyboard];
    [self hideDatePickers];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    NSInteger currentIndex = [self.tstview indexForSelectedTab];
    
    NSString *text = [NSString stringWithFormat:@"%@%@", textField.text, string];
    
    FFBaseInputModel *currentInputModel = self.caculaterInputs[currentIndex];
    if (textField.tag == 0) {
        
        currentInputModel.princeple =
        [NSNumber numberWithFloat:[text doubleValue]];
        
    } else if (textField.tag == 1) {
        
        FFFineInterestInputModel *realInputModel =  (FFFineInterestInputModel *)currentInputModel;
        realInputModel.minRate =
        [NSNumber numberWithFloat:[text doubleValue]];
        
    } else if (textField.tag == 2) {
        
        FFFineInterestInputModel *realInputModel =  (FFFineInterestInputModel *)currentInputModel;
        realInputModel.maxRate =
        [NSNumber numberWithFloat:[text doubleValue]];

    }
    
    
    return YES;
}

#pragma mark - private
- (void)dismissKeyboard {
    NSInteger currentIndex = [self.tstview indexForSelectedTab];
    FFTSTInnerView *currentInnerView = self.innerViews[currentIndex];
    for (UIView *view in currentInnerView.subviews) {
        if ([view isKindOfClass:[UITextField class]]) {
            [view resignFirstResponder];
        }
    }
}

- (void)pickDate:(UIButton *)sender {
    
    [self dismissKeyboard];
    
    _datePickerFlag = sender.tag;
    
    if (self.isDatePickerInited) {
        [self showDatePickers];
    }
    
    else {
        [self initDatePickers];
        self.isDatePickerInited = YES;
        [self showDatePickers];
    }
}

- (void)cancleDatePicker:(UIButton *)sender {
    [self hideDatePickers];
}

- (void)selecteDate:(UIButton *)sender {
    
    [self hideDatePickers];
    
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"yyyy年MM月dd日"];
    NSString * dateStr = [dateformatter stringFromDate:self.datePicker.date];
    NSInteger currentIndex = [self.tstview indexForSelectedTab];
    FFTSTInnerView *currentInnerView = self.innerViews[currentIndex];
    FFBaseInputModel *currentInputModel = self.caculaterInputs[currentIndex];
    
    if ([currentInnerView isKindOfClass:[FFDelayPerformanceInputView class]]) {
        FFDelayPerformanceInputView *realInnerView = (FFDelayPerformanceInputView *)currentInnerView;
        FFDelayPerformanceInputModel *realInputMode = (FFDelayPerformanceInputModel *)currentInputModel;
        
        if (self.datePickerFlag == 0) {
            [realInnerView.startDateBtn setTitle:dateStr forState:UIControlStateNormal];
            realInputMode.startDate = self.datePicker.date;
            
            NSInteger currentIndex = [self.tstview indexForSelectedTab];
            if (currentIndex == 1) {
                FFFineInterestInputView *fineInnerView = (FFFineInterestInputView *)realInnerView;
                if ([self.datePicker.date compare:[dateformatter dateFromString:@"1996.05.01"]] == NSOrderedAscending) {
                    fineInnerView.minRateTextField.userInteractionEnabled = YES;
                    fineInnerView.minRateTextField.attributedPlaceholder = [[NSAttributedString alloc]
                                                                            initWithString:@"输入1996.4.30前的利率"
                                                                            attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
                    fineInnerView.minRateTextField.backgroundColor = [UIColor blueColor];
                }
                
                else {
                    
                    fineInnerView.minRateTextField.userInteractionEnabled = NO;
                    fineInnerView.minRateTextField.text = nil;
                    fineInnerView.minRateTextField.attributedPlaceholder = [[NSAttributedString alloc]
                                                                            initWithString:@"暂不可用"
                                                                            attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
                    fineInnerView.minRateTextField.backgroundColor = [UIColor grayColor];
                }
            }

        }
        
        else if (self.datePickerFlag == 1) {
            [realInnerView.endDateBtn setTitle:dateStr forState:UIControlStateNormal];
            realInputMode.endDate = self.datePicker.date;
            
            NSInteger currentIndex = [self.tstview indexForSelectedTab];
            if (currentIndex == 1) {
                FFFineInterestInputView *fineInnerView = (FFFineInterestInputView *)realInnerView;
                if ([self.datePicker.date compare:[dateformatter dateFromString:@"2014.01.01"]] == NSOrderedDescending) {
                    fineInnerView.maxRateTextField.userInteractionEnabled = YES;
                    fineInnerView.maxRateTextField.attributedPlaceholder = [[NSAttributedString alloc]
                                                                            initWithString:@"输入2014.1.1后的利率"
                                                                            attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
                    fineInnerView.maxRateTextField.backgroundColor = [UIColor blueColor];
                }
                
                else {
                   
                    fineInnerView.maxRateTextField.userInteractionEnabled = NO;
                    fineInnerView.maxRateTextField.text = nil;
                    fineInnerView.maxRateTextField.attributedPlaceholder = [[NSAttributedString alloc]
                                                                            initWithString:@"暂不可用"
                                                                            attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
                    fineInnerView.maxRateTextField.backgroundColor = [UIColor grayColor];
                }
            }
        }
    }
    
    
    NSLog(@"selete date is %@", self.datePicker.date);
}

- (void)initDatePickers {
    _datePickerToobar = [[UIView alloc] init];
    self.datePickerToobar.backgroundColor = [UIColor whiteColor];
    
    UIButton *cancleDatePickerBtn = [[UIButton alloc] init];
    cancleDatePickerBtn.backgroundColor = [UIColor redColor];
    [cancleDatePickerBtn setTitle:@"取消" forState:UIControlStateNormal];
    cancleDatePickerBtn.titleLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleCaption2];
    [cancleDatePickerBtn addTarget:self action:@selector(cancleDatePicker:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *selectDatePickerBtn = [[UIButton alloc] init];
    selectDatePickerBtn.backgroundColor = [UIColor grayColor];
    [selectDatePickerBtn setTitle:@"确定" forState:UIControlStateNormal];
    selectDatePickerBtn.titleLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleCaption2];
    [selectDatePickerBtn addTarget:self action:@selector(selecteDate:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.datePickerToobar addSubview:cancleDatePickerBtn];
    [self.datePickerToobar addSubview:selectDatePickerBtn];
    
    self.datePicker = [[UIDatePicker alloc] init];
    self.datePicker.datePickerMode = UIDatePickerModeDate;
    
    [self.view addSubview:self.datePickerToobar];
    [self.view addSubview:self.datePicker];
    
    
    [self.datePicker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@200);
        make.left.equalTo(self.view.mas_left).with.offset(0);
        make.right.equalTo(self.view.mas_right).with.offset(0);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(0);
    }];
    
    [self.datePickerToobar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@244);
        make.left.equalTo(self.view.mas_left).with.offset(0);
        make.right.equalTo(self.view.mas_right).with.offset(0);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(0);
    }];
    
    [cancleDatePickerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.datePickerToobar.mas_left).with.offset(10);
        make.top.equalTo(self.datePickerToobar.mas_top).with.offset(5);
        make.width.equalTo(@44);
        make.height.equalTo(@44);
    }];
    
    [selectDatePickerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.datePickerToobar.mas_right).with.offset(-10);
        make.top.equalTo(self.datePickerToobar.mas_top).with.offset(5);
        make.width.equalTo(@44);
        make.height.equalTo(@44);
    }];

}

- (void)hideDatePickers {
    self.tabBarController.tabBar.hidden = NO;
    self.datePickerToobar.hidden = YES;
    self.datePicker.hidden = YES;
}

- (void)showDatePickers {
    self.tabBarController.tabBar.hidden =YES;
    self.datePickerToobar.hidden = NO;
    NSInteger tabIndex = [self.tstview indexForSelectedTab];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy.MM.dd";
    if (tabIndex == 0) {
        self.datePicker.minimumDate = [formatter dateFromString:@"1991.04.21"];
        
    } else if (tabIndex == 1) {
        self.datePicker.minimumDate = [formatter dateFromString:@"1995.07.01"];
    }
    self.datePicker.hidden = NO;
}

- (void)dateTips:(UIButton *)sender {
    
    NSInteger currentIndex = [self.tstview indexForSelectedTab];
    NSString *tipsContent;
    
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"我明白了" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    if (currentIndex == 0 && sender.tag == 0) {
        
        tipsContent = @"起始日期：1，自生效法律；2，如果生效法律；3，如果。";
    }
    
    else if (currentIndex == 0 && sender.tag == 1) {
        tipsContent = @"终止日期：1，自生效法律；2，如果生效法律；3，如果";
    }
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"帮助" message:tipsContent preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:cancleAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)calculate:(UIButton *)sender {
    [self hideDatePickers];
    NSInteger currentIndex = [self.tstview indexForSelectedTab];
    
    
    if (currentIndex == 0) {
        
        FFTSTInnerView *currentInnerView = self.innerViews[currentIndex];
        FFDelayPerformanceInputModel *currentInputModel = self.caculaterInputs[currentIndex];
        
        if (![self checkInput:currentInnerView]) {
            return;
        }
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.detailsLabelText = @"正在计算";
        hud.removeFromSuperViewOnHide = YES;
        [self.caculater caculateDeferredUtionExpenses:currentInputModel
         
                                              success:^(FFBaseOutputModel *result) {
                                                  
                                                  [hud hide:YES];
                                                  [self showCaculateResult:result];

                                              }
         
                                              failure:^(NSError *error) {
                                                  
                                                  [hud hide:YES];
                                                  [MBProgressHUD showToastWithTitle:[error description]
                                                                            success:NO
                                                                     superContainer:self.view
                                                                       withDuration:1.5];
                                                  
                                              }];
        
    } else if (currentIndex == 1) {
        
        FFTSTInnerView *currentInnerView = self.innerViews[currentIndex];
        FFFineInterestInputModel *currentInputModel = self.caculaterInputs[currentIndex];
        
        if (![self checkInput:currentInnerView]) {
            return;
        }
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.detailsLabelText = @"正在计算";
        hud.removeFromSuperViewOnHide = YES;
        [self.caculater caculateFineInterest:currentInputModel
                                     success:^(FFBaseOutputModel *result) {
                                         
                                         [hud hide:YES];
                                         [self showCaculateResult:result];

                                     } failure:^(NSError *error) {
                                         
                                         [hud hide:YES];
                                         [MBProgressHUD showToastWithTitle:[error description]
                                                                   success:NO
                                                            superContainer:self.view
                                                              withDuration:1.5];
                                         
                                     }];
    }
    
}

- (BOOL)checkInput:(FFTSTInnerView *)currentInnerView {
    
    UITextField *currentPrincepleTextField = currentInnerView.principleTextField;
    NSString *startDateStr;
    NSString *endDateStr;
    
    if ([currentInnerView isKindOfClass:[FFDelayPerformanceInputView class]]) {
        FFDelayPerformanceInputView *realInnerView = (FFDelayPerformanceInputView *)currentInnerView;
        startDateStr = realInnerView.startDateBtn.titleLabel.text;
        endDateStr = realInnerView.endDateBtn.titleLabel.text;
    }
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy年MM月dd日"];
    
    NSNumber *currentPrinceple = [NSNumber numberWithDouble:[currentPrincepleTextField.text doubleValue]];
    NSDate *startDate = [dateFormatter dateFromString:startDateStr];
    NSDate *endDate = [dateFormatter dateFromString:endDateStr];
    
    
    if (!(currentPrinceple && [currentPrinceple doubleValue] > 0)) {
        [MBProgressHUD showToastWithTitle:@"请输入本金！" success:NO superContainer:self.view withDuration:2];
        return NO;
    }
    
    if (startDate) {
        NSInteger tabIndex = [self.tstview indexForSelectedTab];
        if (tabIndex == 1) {
            if ([startDate compare:[dateFormatter  dateFromString:@"1996年05月01日"]] == NSOrderedAscending) {
                FFFineInterestInputView *fineInterestInputView = (FFFineInterestInputView *)currentInnerView;
                if (!(fineInterestInputView.minRateTextField.text &&
                    [fineInterestInputView.minRateTextField.text doubleValue])) {
                    [MBProgressHUD showToastWithTitle:@"请输入1996年05月01日前的利率" success:NO superContainer:self.view withDuration:2];
                    return NO;
                }
            }
        }
    }
    
    
    else {
        [MBProgressHUD showToastWithTitle:@"请选择起始时间！" success:NO superContainer:self.view withDuration:2];
        return NO;
    }
    
    if (endDate) {
        NSInteger tabIndex = [self.tstview indexForSelectedTab];
        if (tabIndex == 1) {
            if ([endDate compare:[dateFormatter  dateFromString:@"2004年01月01日"]] == NSOrderedDescending) {
                FFFineInterestInputView *fineInterestInputView = (FFFineInterestInputView *)currentInnerView;
                if (!(fineInterestInputView.maxRateTextField.text &&
                      [fineInterestInputView.maxRateTextField.text doubleValue])) {
                    [MBProgressHUD showToastWithTitle:@"请输入2004年01月01日后的利率" success:NO superContainer:self.view withDuration:2];
                    return NO;
                }
            }
        }
    }
    
    else {
        [MBProgressHUD showToastWithTitle:@"请选择结束时间！" success:NO superContainer:self.view withDuration:2];
        return NO;
    }
    
    if ([startDate compare:endDate] == NSOrderedDescending ||
        [startDate compare:endDate] == NSOrderedSame) {
        [MBProgressHUD showToastWithTitle:@"起始日期在结束日期之后或相等！" success:NO superContainer:self.view withDuration:2];
        return NO;
    }
    
    return YES;
}

- (void)showCaculateResult:(FFBaseOutputModel *)result {
    UIAlertController *resultAlert =
    [UIAlertController alertControllerWithTitle:@"计算结果"
                                        message:[NSString stringWithFormat:@"%.2f", [result.totalResult doubleValue]]
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *showDetail = [UIAlertAction actionWithTitle:@"查看详情" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [resultAlert dismissViewControllerAnimated:YES completion:nil];
        
        UIStoryboard *mainBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        FFCaculateResultDetialViewController *detailVC =
        [mainBoard instantiateViewControllerWithIdentifier:
         NSStringFromClass([FFCaculateResultDetialViewController class])];
        detailVC.resultNeedDisplay = result;
        detailVC.hidesBottomBarWhenPushed = YES;
        
        [self.navigationController pushViewController:detailVC animated:YES];
    }];
    
    UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
    
    [resultAlert addAction:cancle];
    [resultAlert addAction:showDetail];
    
    [self presentViewController:resultAlert animated:YES completion:nil];
}

- (void)getInnerViewAt:(NSInteger)tabIndex forContent:(UIScrollView *)content {
    
    UIEdgeInsets padding = UIEdgeInsetsMake(20, 60, 20, 60);
    
    FFTSTInnerView *innerView;
    if (self.innerViews[tabIndex] == [NSNull null]) {
        if (tabIndex != 1) {
            innerView = [self.innerViewFactory creatInnerViewByType:FFTSTInnerViewTypeDeferredUtion];
        } else {
            innerView = [self.innerViewFactory creatInnerViewByType:FFTSTInnerViewTypeFineInterest];
        }
        
        [self.innerViews replaceObjectAtIndex:tabIndex withObject:innerView];
    }
    
    else {
        innerView = self.innerViews[tabIndex];
    }
    
    innerView.principleTextField.delegate = self;
    
    if ([innerView isKindOfClass:[FFDelayPerformanceInputView class]]) {
        
        FFDelayPerformanceInputView *realInnerView = (FFDelayPerformanceInputView *)innerView;
        
        [realInnerView.startDateBtn
         addTarget:self
         action:@selector(pickDate:)
         forControlEvents:UIControlEventTouchUpInside ];
        
        realInnerView.startDateTipsBtn.tag = 0;
        [realInnerView.startDateTipsBtn
         addTarget:self
         action:@selector(dateTips:)
         forControlEvents:UIControlEventTouchUpInside];
        
        [realInnerView.endDateBtn
         addTarget:self
         action:@selector(pickDate:)
         forControlEvents:UIControlEventTouchUpInside];
        
        realInnerView.endDateTipsBtn.tag = 1;
        [realInnerView.endDateTipsBtn
         addTarget:self
         action:@selector(dateTips:)
         forControlEvents:UIControlEventTouchUpInside];
    }
    
    if ([innerView isKindOfClass:[FFFineInterestInputView class]]) {
        
        FFFineInterestInputView *realInnerView = (FFFineInterestInputView *)innerView;
        
        realInnerView.maxRateTextField.delegate = self;
        realInnerView.minRateTextField.delegate = self;
    }
    
    [innerView.startCalculateBtn
     addTarget:self
     action:@selector(calculate:)
     forControlEvents:UIControlEventTouchUpInside];
    
    UIView *bottomBlankView = [[UIView alloc] init];
    bottomBlankView.backgroundColor = [UIColor greenColor];
    
    [content addSubview:innerView];
    [content addSubview:bottomBlankView];
    
    [innerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(content.mas_top).with.offset(0);
        make.leading.equalTo(content.mas_leading).with.offset(0);
        make.trailing.equalTo(content.mas_trailing).with.offset(0);
        make.width.equalTo([NSNumber numberWithFloat:[UIScreen mainScreen].bounds.size.width]);
    }];
    
    [bottomBlankView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(innerView.mas_bottom).with.offset(padding.top);
        make.centerX.equalTo(innerView.mas_centerX);
        make.bottom.equalTo(content.mas_bottom).with.offset(padding.bottom);
        make.width.equalTo(@0);
        CGFloat height = [UIScreen mainScreen].bounds.size.height;
        height = height - 44 * 4 - 3 * 30;
        make.height.equalTo([NSNumber numberWithFloat:height]);
    }];
    
    [self fillAtIndex:tabIndex content:innerView];
}

- (void)fillAtIndex:(NSInteger)tabIndex content:(FFTSTInnerView *)innerView {
    
    FFBaseInputModel *currentInput = self.caculaterInputs[tabIndex];
    
    if (currentInput.princeple) {
        innerView.principleTextField.text = [currentInput.princeple stringValue];
    }
    
    if ([currentInput isKindOfClass:[FFDelayPerformanceInputModel class]]) {
        FFDelayPerformanceInputModel *realInputModel = (FFDelayPerformanceInputModel *)currentInput;
        
        if (realInputModel.startDate || realInputModel.endDate) {
            
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyy年MM月dd日"];
            
            if ([innerView isKindOfClass:[FFDelayPerformanceInputView class]]) {
                FFDelayPerformanceInputView *realInnerView = (FFDelayPerformanceInputView *)innerView;
                if (realInputModel.startDate) {
                    [realInnerView.startDateBtn
                     setTitle:[formatter stringFromDate:realInputModel.startDate]
                     forState:UIControlStateNormal];
                }
                
                if (realInputModel.endDate) {
                    [realInnerView.endDateBtn
                     setTitle:[formatter stringFromDate:realInputModel.endDate]
                     forState:UIControlStateNormal];
                }
                
            }
        }

    }
}

@end
