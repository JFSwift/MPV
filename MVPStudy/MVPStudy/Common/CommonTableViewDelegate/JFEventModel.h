//
//  JFEventModel.h
//  9BaoCustomer
//
//  Created by JF on 2018/6/29.
//  Copyright © 2018年 JF. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JFCommonTableData.h"

@interface JFEventModel : NSObject
/**
 事件类型名
 */
@property (nonatomic,copy) NSString *eventName;

/**
 事件传递参数
 */
@property (nonatomic,strong) id <JFCommonTableData> eventModel;

/**
 扩展类型
 */
@property (nonatomic,strong) id extData;

@end
