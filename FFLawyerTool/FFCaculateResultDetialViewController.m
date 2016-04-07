//
//  FFCaculateResultDetialViewController.m
//  FFLawyerTool
//
//  Created by fanly frank on 4/4/16.
//  Copyright © 2016 fanly frank. All rights reserved.
//

#import "FFCaculateResultDetialViewController.h"

@interface FFCaculateResultDetialViewController ()

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
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.resultNeedDisplay.parts.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *lineData = self.resultNeedDisplay.parts[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"resultCell" forIndexPath:indexPath];
    
    cell.textLabel.text =
    [NSString stringWithFormat:@"期间：%@", lineData[@"period"]];
    cell.detailTextLabel.textColor = [UIColor redColor];
    cell.detailTextLabel.text =
    [NSString stringWithFormat:@"金额：%@", lineData[@"result"]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 64;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *result = [[UIView alloc] init];
    result.backgroundColor = [UIColor grayColor];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, [UIScreen mainScreen].bounds.size.width, 20)];
    
    titleLabel.text =
    [NSString stringWithFormat:@"总额：%@",
     self.resultNeedDisplay.totalResult];
    
    [result addSubview:titleLabel];
    
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
