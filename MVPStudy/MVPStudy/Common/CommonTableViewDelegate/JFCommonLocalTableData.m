//
//  JFCommonTableData.m
//  CommondDemo
//
//  Created by JF on 2018/6/14.
//  Copyright © 2018年 JF. All rights reserved.
//

#import "JFCommonLocalTableData.h"

#define DefaultUIRowHeight  50.f
#define DefaultUIHeaderHeight  0.1f

@implementation JFCommonLocalTableSection

- (id)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}
- (instancetype) initWithDict:(NSDictionary *)dict{
    if ([dict[Disable] boolValue]) {
        return nil;
    }
    self = [super init];
    if (self) {
        _headOrFooterTitle = dict[HeadOrFooterTitle];
        _headOrFooterClassName = dict[HeadOrFooterClassName];
        _headOrFooterHeight = [dict[HeadOrFooterHeight] floatValue];
        _headOrFooterHeight = _headOrFooterHeight ? _headOrFooterHeight : DefaultUIHeaderHeight;
        _headOrFooterActionName = dict[HeadOrFooterActionName];
        _isHeader = [dict[IsHeader] boolValue];
        _rows = [JFCommonLocalTableRow rowsWithData:dict[RowContent]];
    }
    return self;
}

+ (NSArray *)sectionsWithData:(NSArray *)data{
    NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:data.count];
    for (NSDictionary *dict in data) {
        if ([dict isKindOfClass:[NSDictionary class]]) {
            JFCommonLocalTableSection * section = [[JFCommonLocalTableSection alloc] initWithDict:dict];
            if (section) {
                [array addObject:section];
            }
        }
    }
    return array;
}


@end



@implementation JFCommonLocalTableRow
- (id)init {
    self = [super init];
    if (self) {        
    }
    return self;
}
- (instancetype) initWithDict:(NSDictionary *)dict{
    if ([dict[Disable] boolValue]) {
        return nil;
    }
    self = [super init];
    if (self) {
        _title          = dict[Title];
        _detailTitle    = dict[DetailTitle];
        _cellClassName  = dict[CellClass];
        _cellActionName = dict[CellAction];
        _uiRowHeight    = dict[RowHeight] ? [dict[RowHeight] floatValue] : DefaultUIRowHeight;
        _extraInfo      = dict[ExtraInfo];
        _sepLeftEdge    = [dict[SepLeftEdge] floatValue];
        _showAccessory  = [dict[ShowAccessory] boolValue];
        _forbidSelect   = [dict[ForbidSelect] boolValue];
    }
    return self;
}

+ (NSArray *)rowsWithData:(NSArray *)data{
    NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:data.count];
    for (NSDictionary *dict in data) {
        if ([dict isKindOfClass:[NSDictionary class]]) {
            JFCommonLocalTableRow * row = [[JFCommonLocalTableRow alloc] initWithDict:dict];
            if (row) {
                [array addObject:row];
            }
        }
    }
    return array;
}


@end
