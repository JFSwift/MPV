//
//  AccountModel.m
//  9BaoCustomer
//
//  Created by JF on 2018/6/27.
//  Copyright © 2018年 JF. All rights reserved.
//

#import "AccountTool.h"

#import <objc/runtime.h>

#define UserData_Path [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:@"person.data"]

FOUNDATION_EXPORT NSArray<NSString *> *NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory directory, NSSearchPathDomainMask domainMask, BOOL expandTilde);

@implementation AccountTool
/**
 是否需要登录
 */
+(BOOL)isLogin {
    AccountModel *account = [AccountTool account];
    return !(account&&(account.uId.length>0));
}
+(BOOL)isCurrentToLogin {
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"Login_isCurrentToLogin_Type"];
}
/**
 设置是否含有登录状态
 
 @param isLogin isLogin description
 */
+ (void)setIsCurrentToLogin:(BOOL)isLogin {
    [[NSUserDefaults standardUserDefaults]setBool:isLogin forKey:@"Login_isCurrentToLogin_Type"];
}
/**
 清除用户信息
 */
+(void)clearAccountData{
    [AccountTool saveAccount:[[AccountModel alloc]init]];
}
/**
 获取历史登录账号
 
 @return 账号
 */
+(NSString *)getHistoryLogintAccount{
    return [[NSUserDefaults standardUserDefaults] stringForKey:@"Login_History_Login_Account"];
}
/**
 设置历史登录账号
 
 @param account 账号
 */
+(void)setUpHistoryLogintAccount:(NSString *)account{
    [[NSUserDefaults standardUserDefaults] setValue:account forKey:@"Login_History_Login_Account"];
}
/**
 获取当前用户uid
 
 @return uid
 */
+ (NSString *)getCurrentUid {
    AccountModel *account = [AccountTool account];
    return [NSString isEmptyString:account.uId];
}
+ (void)saveAccount:(AccountModel *)account{
    [NSKeyedArchiver archiveRootObject:account toFile:UserData_Path];
}
+ (AccountModel *)account{
    
    return [NSKeyedUnarchiver unarchiveObjectWithFile:UserData_Path];
    
}
@end

@implementation AccountModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"server_token":@"tokenId"
             };
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    unsigned int outCount = 0;
    Ivar *vars = class_copyIvarList([self class], &outCount);
    
    for (int i = 0; i < outCount; i ++) {
        Ivar var = vars[i];
        const char *name = ivar_getName(var);
        NSString *key = [NSString stringWithUTF8String:name];
        id value = [self valueForKey:key];
        [aCoder encodeObject:value forKey:key];
    }
}
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        unsigned int outCount = 0;
        Ivar *vars = class_copyIvarList([self class], &outCount);
        
        for (int i = 0; i < outCount; i ++) {
            Ivar var = vars[i];
            const char *name = ivar_getName(var);
            NSString *key = [NSString stringWithUTF8String:name];
            id value = [aDecoder decodeObjectForKey:key];
            [self setValue:value forKey:key];
        }
    }
    return self;
}

@end
