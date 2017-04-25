//
//  TsyHTTPManager.m
//  Faxin
//
//  Created by lv on 2016-4-14.
//  Copyright © 2016年 lv. All rights reserved.
//

#import "TsyHTTPManager.h"

//
#import "AFNetworking.h"

@implementation TsyHTTPManager

/**
 *  取消所有 请求
 *
 */
+ (void)cancelAllRequest {
    // 初始化afManager
    AFHTTPRequestOperationManager *afManager = [AFHTTPRequestOperationManager manager];
    
    [afManager.operationQueue cancelAllOperations];
}

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
    failure:(void (^)(NSError *error))failure {
    
    // 初始化afManager
    AFHTTPRequestOperationManager *afManager = [AFHTTPRequestOperationManager manager];
    
    afManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/plain", @"text/html", nil];
    
    //
    afManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    afManager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    // 执行请求
    [afManager GET:URLString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        // 成功时回调外层代码
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // 失败时回调外层代码
        if (failure) {
            failure(error);
        }
    }];
}

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
     failure:(void (^)(NSError *error))failure {
    // 初始化afManager
    AFHTTPRequestOperationManager *afManager = [AFHTTPRequestOperationManager manager];
    
    afManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/plain", @"text/html", nil];
    
    // 执行请求
    [afManager POST:URLString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        // 获取输入参数，判断是否有NSData类型参数，有了，就设置一下
        NSDictionary *params = (NSDictionary *)parameters;
        
        NSEnumerator *enumerator = [params keyEnumerator];
        id key;
        while ((key = [enumerator nextObject])) {
            NSObject *data = [params objectForKey:key];
            
            if ([data isKindOfClass:[NSData class]]) {
                [formData appendPartWithFileData:(NSData *)data name:@"avatar" fileName:@"avatar.jpg" mimeType:@"image/jpeg"];
            }
        }
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        // 成功时回调外层代码
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // 失败时回调外层代码
        if (failure) {
            failure(error);
        }
    }];
}

@end
