//
//  JFCommonTableData.h
//  CommondDemo
//
//  Created by JF on 2018/6/14.
//  Copyright © 2018年 JF. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JFCommonTableData.h"

static NSInteger const SepLineLeft = 15; //分割线距左边距离

//section key
static NSString *const HeadOrFooterTitle = @"headOrFooterTitle";
static NSString *const HeadOrFooterClassName = @"headOrFooterClassName";
static NSString *const HeadOrFooterActionName = @"headOrFooterActionName";
static NSString *const IsHeader = @"isHeader";
static NSString *const RowContent = @"row";
static NSString *const HeadOrFooterHeight = @"headOrFooterHeight";

//row key
static NSString *const Title = @"title";
static NSString *const DetailTitle = @"detailTitle";
static NSString *const CellClass = @"cellClass";
static NSString *const CellAction = @"action";
static NSString *const ExtraInfo = @"extraInfo";
static NSString *const RowHeight = @"rowHeight";
static NSString *const SepLeftEdge = @"leftEdge";


//common key
static NSString *const Disable = @"disable";      //cell不可见
static NSString *const ShowAccessory = @"accessory";    //cell显示>箭头
static NSString *const ForbidSelect = @"forbidSelect"; //cell不响应select事件

@interface JFCommonLocalTableSection : NSObject <JFCommonTableData>

@property (nonatomic,copy)   NSString *headOrFooterTitle;

@property (nonatomic,copy  ) NSString *headOrFooterClassName;

@property (nonatomic,copy  ) NSString *headOrFooterActionName;

@property (nonatomic,assign) BOOL isHeader;

@property (nonatomic,copy)   NSArray *rows;

@property (nonatomic,assign) CGFloat  headOrFooterHeight;


- (instancetype) initWithDict:(NSDictionary *)dict;

+ (NSArray *)sectionsWithData:(NSArray *)data;

@end




@interface JFCommonLocalTableRow : NSObject <JFCommonTableData>

@property (nonatomic,strong) NSString *title;

@property (nonatomic,copy  ) NSString *detailTitle;

@property (nonatomic,copy  ) NSString *cellClassName;

@property (nonatomic,copy  ) NSString *cellActionName;

@property (nonatomic,assign) CGFloat  uiRowHeight;

@property (nonatomic,assign) CGFloat  sepLeftEdge;

@property (nonatomic,assign) BOOL     showAccessory;

@property (nonatomic,assign) BOOL     forbidSelect;

@property (nonatomic,strong) id extraInfo;

- (instancetype) initWithDict:(NSDictionary *)dict;

+ (NSArray *)rowsWithData:(NSArray *)data;

@end
