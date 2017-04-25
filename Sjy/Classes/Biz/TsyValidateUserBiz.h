//
//  TsyValidateUserBiz.h
//  Tsy
//
//  Created by LV-Mac on 16/7/18.
//  Copyright © 2016年 LV-Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TsyValidateUserBiz : NSObject

// 上传图片，并验证用户
+ (void)ValidateUserWithParameters:(id)parameters success:(void (^)(NSArray *array))success failure:(void (^)(NSError *error))failure;

// 上传用户学习时间
+ (void)UploadUserLearnTimeWithParameters:(id)parameters success:(void (^)(NSArray *array))success failure:(void (^)(NSError *error))failure;

@end
