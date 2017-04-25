//
//  UIImage+FxImage.m
//  LawAPP
//
//  Created by lv on 2015-9-15.
//  Copyright (c) 2015年 lv. All rights reserved.
//

#import "UIImage+FxImage.h"

@implementation UIImage (FxImage)

// 初始化Image不渲染
+ (instancetype)imageWithOriginalName:(NSString *)originalName {
    UIImage *image = [UIImage imageNamed:originalName];
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

@end
