//
//  TsyUserItem.m
//  Tsy
//
//  Created by LV-Mac on 16/7/18.
//  Copyright © 2016年 LV-Mac. All rights reserved.
//

#import "TsyUserItem.h"

@implementation TsyUserItem

/**
 *  初始化
 *
 *  @param flag 识别标志 1 成功， 0 失败
 *  @param bt   视频开始时间
 *  @param img  图片地址
 *
 *  @return self
 */
- (instancetype)initWithFlag:(NSString *)flag bt:(NSString *)bt img:(NSString *)img {
    if (self = [super init]) {
        self.flag = flag;
        self.bt = bt;
        self.img = img;
    }
    
    return self;
}

@end
