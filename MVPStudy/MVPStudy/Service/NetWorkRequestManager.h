//
//  NetWorkRequestManager.h
//  JFCarGuide
//
//  Created by JF on 2018/6/16.
//  Copyright © 2018年 JF. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

typedef NS_ENUM(NSUInteger, HTTPResponseType) {
    HTTPResponseTypeHEAD,
    HTTPResponseTypeGET,
    HTTPResponseTypePOST,
    HTTPResponseTypePOSTIMAGE,
    HTTPResponseTypeDELETE,
    HTTPResponseTypePATCH
};
@interface NetWorkRequestManager : AFHTTPSessionManager
+(NetWorkRequestManager *)shareManager;
/**
 *  请求数据
 *
 *  @param url         地址
 *  @param parameters  请求参数
 *  @param requestType 请求类型
 *
 */
-(void)requestWithURL:(NSString *)url parameters:(NSDictionary *)parameters requestType:(HTTPResponseType)requestType success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;
@end

