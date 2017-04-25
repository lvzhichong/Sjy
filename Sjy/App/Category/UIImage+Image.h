//
//  UIImage+Image.h
//  Nancool
//
//  Created by apple on 15-3-4.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Image)
// instancetype默认会识别当前是哪个类或者对象调用，就会转换成对应的类的对象
// UIImage *

// 加载最原始的图片，没有渲染
+ (instancetype)imageWithOriginalName:(NSString *)imageName;

+ (instancetype)imageWithStretchableName:(NSString *)imageName;

// 旋转UIImage
+ (instancetype)normalizedImage:(UIImage *)aImage;

/**
 *  旋转UIImage
 *
 *  @param aImage 图片
 *  @param angle  旋转多少
 *
 *  @return 图片
 */
+ (UIImage *)fixOrientation:(UIImage *)aImage angle:(CGFloat)angle;

@end
