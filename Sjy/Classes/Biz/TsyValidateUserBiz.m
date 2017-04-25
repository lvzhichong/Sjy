//
//  TsyValidateUserBiz.m
//  Tsy
//
//  Created by LV-Mac on 16/7/18.
//  Copyright © 2016年 LV-Mac. All rights reserved.
//

#import "TsyValidateUserBiz.h"

#import "MJExtension.h"

#import "TsyHTTPManager.h"

#import "TsyUserItem.h"
#import "TsyUserLearnInfoItem.h"

@implementation TsyValidateUserBiz

// 上传图片，并验证用户
+ (void)ValidateUserWithParameters:(id)parameters success:(void (^)(NSArray *array))success failure:(void (^)(NSError *error))failure {
    // 调用接口时参数
    NSLog(@"参数：%@", parameters);
    // 调用
    [TsyHTTPManager POST:@"http://aq.sijiyun.net.cn/usercenter/ReceiveCheckImgMobile.ashx" parameters:parameters success:^(id responseObject) {
        // 成功
        NSLog(@"上传图片，并验证用户：%@", responseObject);
        // 识别标志
        NSString *flag = responseObject[@"flag"];
        // 视频开始时间
        NSString *bt = responseObject[@"bt"];
        // 图片路径
        NSString *img = responseObject[@"img"];
        
        TsyUserItem *item = [[TsyUserItem alloc] initWithFlag:flag bt:bt img:img];
        
        NSArray *itemArray = [NSArray arrayWithObject:item];
        
        if (success) {
            success(itemArray);
        }
    } failure:^(NSError *error) {
        // 失败
        if (failure) {
            failure(error);
        }
    }];
}


// 上传用户学习时间
+ (void)UploadUserLearnTimeWithParameters:(id)parameters success:(void (^)(NSArray *array))success failure:(void (^)(NSError *error))failure {
    // 调用接口时参数
    NSLog(@"参数：%@", parameters);
    // 调用
    [TsyHTTPManager GET:@"http://aq.sijiyun.net.cn/usercenter/RecordStudytimeMobile.ashx" parameters:parameters success:^(id responseObject) {
        // 成功
        NSLog(@"上传用户学习时间：%@", responseObject);
        // 获取返回数据
        // 开始学习时间
        NSString *bt = responseObject[@"bt"];
        // 用户学习当前课程总时间
        NSString *studytimecount = responseObject[@"studytimecount"];
        
        TsyUserLearnInfoItem *item = [[TsyUserLearnInfoItem alloc] initWithbt:bt studytimecount:studytimecount];
        
        NSArray *itemArray = [NSArray arrayWithObject:item];
        
        if (success) {
            success(itemArray);
        }
    } failure:^(NSError *error) {
        // 失败
        if (failure) {
            failure(error);
        }
    }];
}

@end
