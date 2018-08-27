//
//  RequestAPI.h
//  9BaoCustomer
//
//  Created by JF on 2018/6/27.
//  Copyright © 2018年 JF. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark ==================send输出的结果集的key===================
// 结果数组的key
static NSString *const Request_result_List_Title_Key = @"Request_result_List_Title_Key";
// 是否是最后一页的key
static NSString *const Request_result_Last_Title_Key = @"Request_result_Last_Title_Key";
// 订单数量的key
static NSString *const Request_OrderListResultNumber_Key = @"Request_OrderListResultNumber_Key";

@interface RequestAPI : NSObject

@end
