//
//  Video.h
//  polyvSDK
//
//  Created by seanwong on 8/16/15.
//  Copyright (c) 2015 easefun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Video : NSObject

// 用户SessionID
@property (nonatomic, copy) NSString *sessionId;

// 用户ID
@property (nonatomic, copy) NSString *userId;

// 课程ID
@property (nonatomic, copy) NSString *courseId;

// 课程名称
@property (nonatomic, copy) NSString *title;

// 课程最小学习时间（分钟）
@property (nonatomic, copy) NSString *minLearnTime;

// 学员学习状况描述
@property (nonatomic, copy) NSString *desc;

// 视频ID
@property (nonatomic,copy) NSString *vid;

// 头像地址
@property (nonatomic,copy) NSString *imgUrl;

// 当前学员该课程总时间（分钟）
@property (nonatomic, copy) NSString *learnTime;

// 返回时间
@property (nonatomic, copy) NSString *bt;

// 返回Id
@property (nonatomic, copy) NSString *returnId;

@property (nonatomic,copy) NSString *piclink;
@property (nonatomic,copy) NSString *duration;
@property long long filesize;
@property NSArray* allfilesize;
@property int level;
@property int df;
@property int seed;
@property int status;
@property float percent;
@property long rate;

- (id)initWithVid:(NSString*)_vid;

- (id)initWithUserId:(NSString *)_userId sessionId:(NSString *)_sessionId courseId:(NSString *)_courseId title:(NSString *)_title minLearnTime:(NSString *)_minLearnTime desc:(NSString *)_desc vid:(NSString *)_vid learnTime:(NSString *)_learnTime returnId:(NSString *)_returnId;
@end
