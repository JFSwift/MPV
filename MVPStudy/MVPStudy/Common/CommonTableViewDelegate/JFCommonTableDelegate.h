//
//  JFCommonTableDelegate.h
//  CommondDemo
//
//  Created by JF on 2018/6/14.
//  Copyright © 2018年 JF. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JFCommonTableDelegate : NSObject<UITableViewDataSource,UITableViewDelegate>

- (instancetype) initWithTableData:(NSArray *(^)(void))data;

/**
 设置默认左边间距
 */
@property (nonatomic,assign) CGFloat defaultSeparatorLeftEdge;
/**
 最后一行是否顶头
 */
@property (nonatomic,assign) BOOL lastLineZore;
/**
 是否添加线条
 */
@property (nonatomic,assign) BOOL defaultAddLine;

@end
