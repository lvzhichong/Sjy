//
//  TsyUserItem.m
//  Tsy
//
//  Created by LV-Mac on 16/7/18.
//  Copyright © 2016年 LV-Mac. All rights reserved.
//

#import "TsyUserLearnInfoItem.h"

@implementation TsyUserLearnInfoItem

/**
 *  初始化
 *
 *  @param bt   视频开始时间
 *  @param studytimecount  用户学习当前课程总时间
 *
 *  @return self
 */
- (instancetype)initWithbt:(NSString *)bt studytimecount:(NSString *)studytimecount {
    if (self = [super init]) {
        self.bt = bt;
        self.studytimecount = studytimecount;
    }
    
    return self;
}

@end
