//
//  JFCommonTableViewCell.m
//  CommondDemo
//
//  Created by JF on 2018/6/14.
//  Copyright © 2018年 JF. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JFCommonTableData.h"
@class JFEventModel;

@protocol JFCommonTableViewCell <NSObject>
@required
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@optional
/**
 刷新页面

 @param rowData 数据
 */
- (void)refreshData:(id <JFCommonTableData>)rowData;
/**
 进行赋值

 @param rowData 数据
 @param ext 扩展
 */
- (void)refreshData:(id <JFCommonTableData>)rowData andExt:(NSDictionary *)ext;

@end
@protocol JFCommonTableViewHeaderFooter <NSObject>
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier;

@optional
/**
 刷新页面
 
 @param rowData 数据
 */
- (void)refreshData:(id <JFCommonTableData>)rowData;
/**
 进行赋值
 
 @param rowData 数据
 @param ext 扩展
 */
- (void)refreshData:(id <JFCommonTableData>)rowData andExt:(NSDictionary *)ext;

@end
