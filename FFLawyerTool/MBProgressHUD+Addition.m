//
//  MBProgressHUD+Addition.m
//  weibo
//
//  Created by mj on 13-3-7.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#define kDuration 0.6

#import "MBProgressHUD+Addition.h"

@implementation MBProgressHUD (Addition)


+(MBProgressHUD*)showToastWithDetail:(NSString *)detail success:(BOOL)sucess superContainer:(UIView *) view{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.detailsLabelText = detail;
    hud.labelText = @"";
    NSString *img = @"";
    if(sucess){
        img = @"common_successed.png";
    }else{
        img = @"common_fail.png";
    }
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:img]];
    hud.customView = imageView;
    hud.mode = MBProgressHUDModeCustomView;
    hud.removeFromSuperViewOnHide = YES;
    //hide只是把该组件进行了隐藏
    [hud hide:YES afterDelay:2];
    return hud;
}

+(MBProgressHUD*)showToastWithTitle:(NSString *)title success:(BOOL)sucess superContainer:(UIView *) view{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.detailsLabelText = title;
    NSString *img = @"";
    if(sucess){
        img = @"common_successed.png";
    }else{
        img = @"common_fail.png";
    }
   UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:img]];
    hud.customView = imageView;
    hud.mode = MBProgressHUDModeCustomView;
    hud.removeFromSuperViewOnHide = YES;
    //hide只是把该组件进行了隐藏
    [hud hide:YES afterDelay:2];
    return hud;
}

+(MBProgressHUD*)showToastWithTitle:(NSString *)title success:(BOOL)sucess superContainer:(UIView *) view withDuration:(NSTimeInterval) duration{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.detailsLabelText = title;
    NSString *img = @"";
    if(sucess){
        img = @"common_successed.png";
    }else{
        img = @"common_fail.png";
    }
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:img]];
    hud.customView = imageView;
    hud.mode = MBProgressHUDModeCustomView;
    hud.removeFromSuperViewOnHide = YES;
    //hide只是把该组件进行了隐藏
    [hud hide:YES afterDelay:duration];
    return hud;
}

+(MBProgressHUD *)showToastWithTitle:(NSString *)title success:(BOOL)sucess superContainer:(UIView *) view withDuration:(NSTimeInterval) duration andYOffset:(NSInteger)offsetY{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.detailsLabelText = title;
    hud.yOffset = offsetY;
    NSString *img = @"";
    if(sucess){
        img = @"common_successed.png";
    }else{
        img = @"common_fail.png";
    }    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:img]];
    hud.customView = imageView;
    hud.mode = MBProgressHUDModeCustomView;
    hud.removeFromSuperViewOnHide = YES;
    //hide只是把该组件进行了隐藏
    [hud hide:YES afterDelay:duration];
    return hud;
}

+(MBProgressHUD*)showProgressWithTitle:(NSString *)title superContainer:(UIView *) view{
    MBProgressHUD *progress = [MBProgressHUD showHUDAddedTo:view animated:YES];
    progress.dimBackground = YES;
    progress.detailsLabelText = title;
    return progress;
}

+(void)hideProgess:(UIView *)superContainer{
    [MBProgressHUD hideHUDForView:superContainer animated:YES];
}


@end
