//
//  TsyUserLearnInfoItem.h
//  Tsy
//
//  Created by LV-Mac on 16/7/18.
//  Copyright © 2016年 LV-Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TsyUserLearnInfoItem : NSObject

/**
 *  视频开始时间
 */
@property (nonatomic, copy) NSString *bt;

/**
 *  用户学习当前课程总时间
 */
@property (nonatomic, copy) NSString *studytimecount;

/**
 *  初始化
 *
 *  @param bt   视频开始时间
 *  @param studytimecount  用户学习当前课程总时间
 *
 *  @return self
 */
- (instancetype)initWithbt:(NSString *)bt studytimecount:(NSString *)studytimecount;

@end
