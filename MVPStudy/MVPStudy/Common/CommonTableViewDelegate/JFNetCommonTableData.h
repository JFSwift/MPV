//
//  JFNetCommonTableData.h
//  JFCarGuide
//
//  Created by JF on 2018/6/16.
//  Copyright © 2018年 JF. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JFCommonTableData.h"

@interface JFNetCommonTableData : NSObject <JFCommonTableData>

@property (nonatomic,copy  ) NSString *cellClassName;

@property (nonatomic,copy  ) NSString *cellActionName;

@property (nonatomic,assign) CGFloat  uiRowHeight;

@end
