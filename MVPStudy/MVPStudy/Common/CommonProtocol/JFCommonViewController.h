//
//  JFCommonViewController.h
//  JFCarGuide
//
//  Created by JF on 2018/6/16.
//  Copyright © 2018年 JF. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol JFCommonViewController <NSObject>
@optional;
/**
 发起网络请求
 */
- (void)initiatingNetworkRequests;
@end
