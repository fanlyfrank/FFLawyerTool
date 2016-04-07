//
//  MBProgressHUD+Addition.h
//  weibo
//
//  Created by mj on 13-3-7.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (Addition)
+(MBProgressHUD*)showToastWithTitle:(NSString *)title success:(BOOL)sucess superContainer:(UIView *) view;
//  显示详细信息，可以换行
+(MBProgressHUD*)showToastWithDetail:(NSString *)detail success:(BOOL)sucess superContainer:(UIView *) view;
+(MBProgressHUD*)showToastWithTitle:(NSString *)title success:(BOOL)sucess superContainer:(UIView *) view withDuration:(NSTimeInterval) duration;
// y 表示相对中间位置数值方向上的偏移量，向下为正
+(MBProgressHUD*)showToastWithTitle:(NSString *)title success:(BOOL)sucess superContainer:(UIView *) view withDuration:(NSTimeInterval) duration andYOffset:(NSInteger)offsetY;

+(MBProgressHUD*)showProgressWithTitle:(NSString *)title superContainer:(UIView *) view;

+(void)hideProgess:(UIView *)superContainer;
@end
