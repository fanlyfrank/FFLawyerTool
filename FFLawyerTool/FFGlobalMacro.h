//
//  FFGlobalMacro.h
//  FFLawyerTool
//
//  Created by fanly frank on 4/15/16.
//  Copyright © 2016 fanly frank. All rights reserved.
//

#ifndef FFGlobalMacro_h
#define FFGlobalMacro_h

#pragma mark -- global color setting

#define FFRGBColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]// RGB色

#define FFRandomColor FFRGBColor(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))// 随机色

#define UIColorFromRGB(rgbValue) UIColorFromRGBWithAlpha(rgbValue, 1.0f)

#define UIColorFromRGBWithAlpha(rgbValue, alpha1) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:alpha1]//十六进制转RGB色

#define FFMainColor FFRGBColor(74, 144, 226)
#endif /* FFGlobalMacro_h */
