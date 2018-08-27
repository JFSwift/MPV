//
//  NetWorkRequestManager.m
//  JFCarGuide
//
//  Created by JF on 2018/6/16.
//  Copyright © 2018年 JF. All rights reserved.
//

#import "NetWorkRequestManager.h"
#import "NSDictionary+Category.h"
#import "UIDevice+System.h"

@implementation NetWorkRequestManager

+(NetWorkRequestManager *)shareManager{
    static NetWorkRequestManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc]initWithBaseURL:[NSURL URLWithString:API_Main_URL]];
    });
    return manager;
}
-(instancetype)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    if (self) {
        // 请求超时设定
        self.requestSerializer.timeoutInterval = 30;
        // 支持HTTPS
        self.securityPolicy.validatesDomainName = NO;
        self.securityPolicy.allowInvalidCertificates = YES;
        self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/hal+json",@"text/html",@"image/jpeg", @"text/json", @"text/javascript",@"text/xml",@"text/plain",@"application/json", nil];
    }
    return self;
}
/**
 *  设置请求头部
 *
 */
-(void)setAFNetworkingHTTPHeaderField:(NSDictionary *)parameters andSign:(BOOL)isSign {
    if (![AccountTool isLogin]) {
        AccountModel *accountModel = [AccountTool account];
        [self.requestSerializer setValue:accountModel.server_token forHTTPHeaderField:@"token"];
    }
}
-(void)requestWithURL:(NSString *)url parameters:(NSDictionary *)parameters requestType:(HTTPResponseType)requestType success:(void (^)(id json))success failure:(void (^)(NSError *error))failure{
    [self setAFNetworkingHTTPHeaderField:parameters andSign:(requestType != HTTPResponseTypePOSTIMAGE)];
    NSURLSessionDataTask *task;
    switch (requestType) {
        case HTTPResponseTypeHEAD: {
            
            break;
        }
        case HTTPResponseTypeGET: {
            
            task = [self GET:url parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSLog(@"GET请求地址=%@ responseObject=%@",url,responseObject);
                if (success) {
                    success (responseObject);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (failure) {
                    failure(error);
                }
            }];
            break;
        }
        case HTTPResponseTypePOST: {
            
            task = [self POST:url parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  responseObject) {
                NSLog(@"POST_请求地址=%@ responseObject=%@",url,responseObject);
                if (success) {
                    success (responseObject);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (failure) {
                    failure(error);
                }
            }];
            break;
        }
        case HTTPResponseTypePOSTIMAGE: {
            NSMutableDictionary *mutableDic = [NSMutableDictionary dictionaryWithDictionary:parameters];
            NSMutableArray *imageArr = mutableDic[@"imageArr"];
            if (!imageArr.count) {
                if (failure) {
                    failure(nil);
                }
                return;
            }
            [mutableDic removeObjectForKey:@"imageArr"];
            task = [self POST:url parameters:mutableDic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                if (imageArr&&imageArr.count) {
                    NSInteger index = 0;
                    for (UIImage *image in imageArr) {
                        NSString * name = [NSString stringWithFormat:@"%@%zi", @"image", index+1];
                        if ([url isEqualToString:Host_Live_SendOffer_URL]) {
                            name = @"productFile";
                        }
                        // 上传filename
                        NSString * fileName = [NSString stringWithFormat:@"%@.jpg", @"image"];
                        [formData appendPartWithFileData:UIImageJPEGRepresentation(image, .5) name:name fileName:fileName mimeType:@"image/jpg"];
                        index ++;
                    }
                }
            } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSLog(@"POSTIMG_请求地址=%@ responseObject=%@",url,responseObject);
                if (success) {
                    success (responseObject);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (failure) {
                    failure(error);
                }
            }];
            break;
        }
        case HTTPResponseTypeDELETE: {
            break;
        }
        case HTTPResponseTypePATCH: {
            [self PATCH:url parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSLog(@"PATCH_请求地址=%@ responseObject=%@",url,responseObject);
                if (success) {
                    success (responseObject);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (failure) {
                    failure(error);
                }
            }];
            break;
        }
    }
}
@end
