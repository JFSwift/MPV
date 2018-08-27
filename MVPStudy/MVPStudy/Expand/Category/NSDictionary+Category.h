//
//  NSDictionary+Category.h
//  JFCarGuide
//
//  Created by JF on 2018/6/16.
//  Copyright © 2018年 JF. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Category)
/**
 处理后台返回结果
 
 @param jsonResultData 结果
 @return 返回得到结果
 */
+ (NSDictionary *)handlingNetResultData:(id)jsonResultData;
/**
 对字典(Key-Value)排序 不区分大小写
 */
- (NSDictionary *)sortedDictionarybyLowercaseString;
@end

@interface NSString (Category)
// 字典转Json
+ (NSString*)dictionaryToJson:(NSDictionary *)dic;
// 数组转json
+ (NSString *)objectToJson:(id)objc;
+ (NSString *)isEmptyString:(NSString *)string;
/**
 拼接图片地址
 */
- (NSURL *)jf_togetherImageURL:(CGSize)size;
@end
