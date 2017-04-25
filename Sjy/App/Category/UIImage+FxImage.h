//
//  UIImage+FxImage.h
//  LawAPP
//
//  Created by lv on 2015-9-15.
//  Copyright (c) 2015年 lv. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (FxImage)

// 初始化Image不渲染
+ (instancetype)imageWithOriginalName:(NSString *)originalName;

@end
