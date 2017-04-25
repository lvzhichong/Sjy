//
//  TsyUserItem.h
//  Tsy
//
//  Created by LV-Mac on 16/7/18.
//  Copyright © 2016年 LV-Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TsyUserItem : NSObject

/**
 *  识别标志
 */
@property (nonatomic, copy) NSString *flag;

/**
 *  视频开始时间
 */
@property (nonatomic, copy) NSString *bt;

/**
 *  视频开始播放时间
 */
@property (nonatomic, copy) NSString *start;

/**
 *  头像路径
 */
@property (nonatomic, copy) NSString *img;

/**
 *  初始化
 *
 *  @param flag 识别标志 1 成功， 0 失败
 *  @param bt   视频开始时间
 *  @param img  图片地址
 *
 *  @return self
 */
- (instancetype)initWithFlag:(NSString *)flag bt:(NSString *)bt img:(NSString *)img;

@end
