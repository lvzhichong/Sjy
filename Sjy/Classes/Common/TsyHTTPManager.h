//
//  TsyHTTPManager.h
//  Faxin
//
//  Created by lv on 2016-4-14.
//  Copyright © 2016年 lv. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TsyHTTPManager : NSObject

/**
 *  取消所有 请求
 *
 */
+ (void)cancelAllRequest;

/**
 *  get 请求
 *
 *  @param URLString  url地址
 *  @param parameters 参数
 *  @param success    成功时回调block
 *  @param failure    失败时回调block
 */
+ (void)GET:(NSString *)URLString
 parameters:(id)parameters
    success:(void (^)(id responseObject))success
    failure:(void (^)(NSError *error))failure;

/**
 *  post 请求
 *
 *  @param URLString  url地址
 *  @param parameters 参数
 *  @param success    成功时回调block
 *  @param failure    失败时回调block
 */
+ (void)POST:(NSString *)URLString
  parameters:(id)parameters
     success:(void (^)(id responseObject))success
     failure:(void (^)(NSError *error))failure;

@end
