//
//  NSObject+BOOLBanAllExpressions.h
//  9baoLive
//
//  Created by 久宝直播 on 2017/8/1.
//  Copyright © 2017年 孙伟男. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (BOOLBanAllExpressions)

/**
 判断是不是九宫格
 @param string  输入的字符
 @return YES(是九宫格拼音键盘)
 */
-(BOOL)isNineKeyBoard:(NSString *)string;

- (BOOL)hasEmoji:(NSString*)string;

- (BOOL)stringContainsEmoji:(NSString *)string;
/**
 限制输入长度
 
 @param textField textField description
 @param count 数量
 */
- (void)textFieldLimitInput:(UITextField *)textField andLimitCount:(NSInteger)count;
- (void)textViewLimitInput:(UITextView *)textView andLimitCount:(NSInteger)count;
/**
 只能是数字 字母 拼音
 
 @param str str description
 @return return value description
 */
- (BOOL)isInputRuleNotBlank:(NSString *)str;
/**
 只能是数字

 @param string string description
 @return return value description
 */
- (BOOL)isInputRuleAllNubmer:(NSString *)string;
/**
 数字 2位小数点
 
 @param string string description
 @return return value description
 */
- (BOOL)isInputNumberForTwoDecimal:(NSString *)content andString:(NSString *)string;
@end
