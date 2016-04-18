//
//  FFCaculateResultDetialViewController.m
//  FFLawyerTool
//
//  Created by fanly frank on 4/4/16.
//  Copyright © 2016 fanly frank. All rights reserved.
//

#import "FFCaculateResultDetialViewController.h"
#import "FFOutputPartModel.h"
#import "FFResultDetialCell.h"
#import "FFGlobalMacro.h"

@interface FFCaculateResultDetialViewController ()

@property (assign, nonatomic) CGFloat headerHeight;

@end

@implementation FFCaculateResultDetialViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.tableView.tableFooterView =
    [[UIView alloc] initWithFrame:
     CGRectMake(0, 0, 0, self.tabBarController.tabBar.frame.size.height)];
    
    self.clearsSelectionOnViewWillAppear = NO;
    
    self.navigationItem.rightBarButtonItem =
    [[UIBarButtonItem alloc] initWithTitle:@"导出结果"
                                     style:UIBarButtonItemStylePlain
                                    target:self
                                    action:@selector(export)];
    [self.tableView registerClass:[FFResultDetialCell class]
           forCellReuseIdentifier:NSStringFromClass([FFResultDetialCell class])];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([FFResultDetialCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([FFResultDetialCell class])];
    self.tableView.estimatedRowHeight = 90;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.resultNeedDisplay.parts.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FFOutputPartModel *lineData = self.resultNeedDisplay.parts[indexPath.row];
    
    FFResultDetialCell *cell =
    [tableView dequeueReusableCellWithIdentifier:
     NSStringFromClass([FFResultDetialCell class])];
    
    cell.diffDaysL.text = [NSString stringWithFormat:@"%@~%@", lineData.startDate, lineData.endDate];
    cell.amountL.text = [NSString stringWithFormat:@"%@天", lineData.diffDays];
    cell.rateL.text = [NSString stringWithFormat:@"%.4f%%", [lineData.rate doubleValue] * 100];
    
    cell.totalResultL.text = [NSString stringWithFormat:@"金额：%0.2f", [lineData.amount doubleValue]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    CGSize size = [@"holder" sizeWithAttributes:@{NSFontAttributeName:[UIFont preferredFontForTextStyle:UIFontTextStyleBody]}];
    return size.height + 20;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *result = [[UIView alloc] init];
    result.backgroundColor = FFWarningColor;
    
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    titleLabel.textColor = [UIColor whiteColor];
    
    titleLabel.text =
    [NSString stringWithFormat:@"总额：%0.2f",
     [self.resultNeedDisplay.totalResult doubleValue]];
    
    CGSize size = [titleLabel.text sizeWithAttributes:@{NSFontAttributeName:titleLabel.font}];
    
    CGRect frame = CGRectMake(12, 10, size.width, size.height);
    
    titleLabel.frame = frame;
    
    [result addSubview:titleLabel];
    
    result.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, self.headerHeight);
    
    return result;
}

- (void)export {
    UIAlertController *resultAlert =
    [UIAlertController alertControllerWithTitle:@"导出结果提示"
                                        message:@"还未实现功能，是现实时这里会显示导出进度！"
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"我知道了！" style:UIAlertActionStyleCancel handler:nil];
    
    [resultAlert addAction:cancle];
    
    [self presentViewController:resultAlert animated:YES completion:nil];
}

@end
