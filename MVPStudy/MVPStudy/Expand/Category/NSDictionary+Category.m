//
//  NSDictionary+Category.m
//  JFCarGuide
//
//  Created by JF on 2018/6/16.
//  Copyright © 2018年 JF. All rights reserved.
//

#import "NSDictionary+Category.h"
#import <sys/sysctl.h>
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCrypto.h>

static NSString *const DESKey = @"012345670123456701234567";
static NSString *const DESIv = @"01234567";


@implementation NSDictionary (Category)
/**
 后台返回结果有问题
 */
+ (void)returnResultDataError:(NSString *)error {
    [MBProgressHUD showErrorWithStatus:error];
}
/**
 处理后台返回结果
 
 @param jsonResultData 结果
 @return 返回得到结果
 */
+ (NSDictionary *)handlingNetResultData:(id)jsonResultData {
    if (![jsonResultData isKindOfClass:[NSDictionary class]]) {
        [NSDictionary returnResultDataError:@"接口返回结构有误"];
        return nil;
    }else{
        if ([jsonResultData[@"resultCode"] integerValue] == 0) {
            NSDictionary *resultData = jsonResultData[@"resultData"];
            if (resultData && [resultData isKindOfClass:[NSDictionary class]]) {
                if ([resultData[@"dataCode"] integerValue]==0) {
                    return resultData;
                }else{
                    NSString *msg = jsonResultData[@"resultData"][@"dataMsg"];
                    [NSDictionary returnResultDataError:StringIsEmpty(msg)?@"接口请求失败":msg];
                    return nil;
                }
            }else{
                [NSDictionary returnResultDataError:@"接口返回内容为空"];
                return nil;
            }
        }else{
            NSString *msg = jsonResultData[@"msg"];
            [NSDictionary returnResultDataError:StringIsEmpty(msg)?@"接口请求失败":msg];
            return nil;
        }
    }
}
@end
@implementation NSString (Category)
// 字典转Json
+ (NSString*)dictionaryToJson:(NSDictionary *)dic
{
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}
// 数组转json
+ (NSString *)objectToJson:(id)objc {//转json
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:objc options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString;
    if (jsonData){
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    NSRange range = {0,jsonString.length};
    //去掉字符串中的空格
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    NSRange range2 = {0,mutStr.length};
    //去掉字符串中的换行符
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    if (StringIsEmpty(mutStr)) {
        mutStr = @"";
    }
    return mutStr;
}

- (NSString *)base64EncodedString;
{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    return [data base64EncodedStringWithOptions:0];
}

- (NSString *)base64DecodedString
{
    NSData *data = [[NSData alloc]initWithBase64EncodedString:self options:0];
    return [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
}
+ (NSString *)isEmptyString:(NSString *)string {
    return StringIsEmpty(string)?@"":string;
}
/**
 拼接图片地址
  @return return value description
 */
- (NSURL *)jf_togetherImageURL:(CGSize)size {
    if ([self containsString:@"http"]) {
        return [NSURL URLWithString:self];
    }
    return [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",API_Main_Image_URL,[NSString stringWithFormat:@"%@?w=%f&h=%f",self,size.width*1.5,size.height*1.5]]];
}
@end
