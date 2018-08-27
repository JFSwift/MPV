//
//  AccountModel.h
//  9BaoCustomer
//
//  Created by JF on 2018/6/27.
//  Copyright © 2018年 JF. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AccountModel;
@interface AccountTool : NSObject
/**
 保存用户模型
 
 @param account 用户信息
 */
+ (void)saveAccount:(AccountModel *)account;
/**
 获取当前用户uid
 
 @return uid
 */
+ (NSString *)getCurrentUid;
/**
 获取用户信息
 
 @return 用户信息
 */
+ (AccountModel *)account;
/**
 是否需要登录
 */
+(BOOL)isLogin;
/**
 是否是前往登录
 
 @return YES or NO
 */
+(BOOL)isCurrentToLogin;
/**
 设置是否含有登录状态
 
 @param isLogin isLogin description
 */
+ (void)setIsCurrentToLogin:(BOOL)isLogin;
/**
 清除用户信息
 */
+(void)clearAccountData;
/**
 获取历史登录账号
 
 @return 账号
 */
+(NSString *)getHistoryLogintAccount;

/**
 设置历史登录账号
 
 @param account 账号
 */
+(void)setUpHistoryLogintAccount:(NSString *)account;
/**
 获取appStore版本
 
 @return 版本
 */
+ (NSString *)getAppStoreVersion;

/**
 设置App Store的版本
 
 @param version 版本号
 */
+ (void)setAppStoreVersion:(NSString *)version;
@end
@interface AccountModel : NSObject
@property (nonatomic, copy) NSString * accid; //kh2bbb382a5ea135a1b9e07919f911;
@property (nonatomic, copy) NSString * acctoken; //aac2412a58bca10b9feadda5b3a8412b;
@property (nonatomic, copy) NSString * archivePath; //"group1/M00/00/1A/wKgAvVj6sSGAVWd5AABxXzaXr4U850.png";
@property (nonatomic, copy) NSString * nickName;
@property (nonatomic, copy) NSString * phoneNo;
@property (nonatomic, copy) NSString * server_token; //kh2bbb382a5ea135a1b9e07919f911;
@property (nonatomic, copy) NSString * uId; //kh2bbb382a5ea135a1b9e07919f911;
@property (nonatomic, copy) NSString * shopUid;
@property (nonatomic, assign) NSInteger userAccess; // 用户权限
@end
