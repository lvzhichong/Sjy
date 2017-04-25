//
//  Video.m
//  polyvSDK
//
//  Created by seanwong on 8/16/15.
//  Copyright (c) 2015 easefun. All rights reserved.
//

#import "Video.h"
#import "PolyvSettings.h"
@implementation Video

// 用户SessionId
@synthesize sessionId;
// 用户ID
@synthesize userId;
// 课程ID
@synthesize courseId;
// 课程名称
@synthesize title;
// 课程最小学习时间（分钟）
@synthesize minLearnTime;
// 学员学习状况描述
@synthesize desc;
// 视频ID
@synthesize vid;
// 当前学员该课程总时间（分钟）
@synthesize learnTime;
// 头像地址
@synthesize imgUrl;
// 返回Id
@synthesize returnId;

@synthesize piclink;
@synthesize duration;
@synthesize filesize;
@synthesize allfilesize;
@synthesize level;
@synthesize df;
@synthesize seed;
@synthesize percent;
@synthesize rate;
@synthesize status;


- (id)initWithVid:(NSString*)_vid {
    if (self = [super init]) {
        NSDictionary*item = [PolyvSettings loadVideoJson:_vid];
        //self.title = [item objectForKey:@"title"];
        self.duration = [item objectForKey:@"duration"];
        self.desc = [item objectForKey:@"duration"];
        self.piclink = [item objectForKey:@"first_image"];
        self.df = [[item objectForKey:@"df_num"] intValue];
        self.seed = [[item objectForKey:@"seed"] intValue];
        self.allfilesize = [item objectForKey:@"filesize"];
    }
    return self;
}

- (id)initWithUserId:(NSString *)_userId sessionId:(NSString *)_sessionId courseId:(NSString *)_courseId title:(NSString *)_title minLearnTime:(NSString *)_minLearnTime desc:(NSString *)_desc vid:(NSString *)_vid learnTime:(NSString *)_learnTime returnId:(NSString *)_returnId {
    if (self = [super init]) {
        NSDictionary*item = [PolyvSettings loadVideoJson:_vid];
        
        self.duration = [item objectForKey:@"duration"];
        self.desc = [item objectForKey:@"duration"];
        self.piclink = [item objectForKey:@"first_image"];
        self.df = [[item objectForKey:@"df_num"] intValue];
        self.seed = [[item objectForKey:@"seed"] intValue];
        self.allfilesize = [item objectForKey:@"filesize"];
        
        // 填充数据
        self.sessionId = _sessionId;
        self.userId = _userId;
        self.courseId = _courseId;
        self.title = _title;
        self.minLearnTime = _minLearnTime;
        self.learnTime = _learnTime;
        self.returnId = _returnId;
    }
    return self;
}

@end
