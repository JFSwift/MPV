//
//  JFCommonViewModel.h
//  JFCarGuide
//
//  Created by JF on 2018/6/16.
//  Copyright © 2018年 JF. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol JFCommonViewModel <NSObject>

@optional;

/**
 是否增加请求下标
 
 @param increase 增加 或 设为默认
 */
- (void)setupIncreaseCurrenPage:(BOOL)increase;
/**
 网络请求
 @param block block description
 */
- (void)requestToNetSuccessBlock:(void(^)(BOOL success,BOOL isLast))block;

@end
