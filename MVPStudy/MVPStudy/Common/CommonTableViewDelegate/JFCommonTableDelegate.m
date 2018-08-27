//
//  JFCommonTableDelegate.m
//  CommondDemo
//
//  Created by JF on 2018/6/14.
//  Copyright © 2018年 JF. All rights reserved.
//

#import "JFCommonTableDelegate.h"
#import "JFCommonLocalTableData.h"
#import "JFCommonTableViewCell.h"
#import "UIView+Frame.h"

static NSString *DefaultTableCell = @"UITableViewCell";
static NSString *DefaultTableHeader = @"UITableViewHeaderFooterView";

@interface JFCommonTableDelegate()

@property (nonatomic,copy) NSArray *(^dataReceiver)(void);

@end

@implementation JFCommonTableDelegate

- (instancetype) initWithTableData:(NSArray *(^)(void))data{
    self = [super init];
    if (self) {
        self.dataReceiver = data;        
        self.defaultSeparatorLeftEdge = SepLineLeft;
        self.defaultAddLine = YES;
    }
    return self;
}

- (NSArray *)data{
    return self.dataReceiver();
}
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.data.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    JFCommonLocalTableSection *tableSection = self.data[section];
    return tableSection.rows.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JFCommonLocalTableSection *tableSection = self.data[indexPath.section];
    JFCommonLocalTableRow     *tableRow     = tableSection.rows[indexPath.row];
    NSString *identity = tableRow.cellClassName.length ? tableRow.cellClassName : DefaultTableCell;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identity];
    if (!cell) {
        Class clazz = NSClassFromString(identity);
        cell = [[clazz alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identity];
        self.defaultAddLine?[cell jf_addLineLabel:UIEdgeInsetsMake(0, 0, 0, 0)]:nil;
        cell.textLabel.font = FONT_15;
        cell.textLabel.textColor = Main_Normal_TextColor;
        cell.detailTextLabel.font = FONT_14;
        cell.detailTextLabel.textColor = Main_Normal_SubtitleTextColor;
    }
    if (self.defaultAddLine) {
        if (tableRow.sepLeftEdge) {
            [cell jf_reloadLineLabel:UIEdgeInsetsMake(0, tableRow.sepLeftEdge, 0, 0)];
        }else{
            JFCommonLocalTableSection *section = self.data[indexPath.section];
            if (indexPath.row == section.rows.count - 1) {
                if (self.lastLineZore) {
                    [cell jf_reloadLineLabel:UIEdgeInsetsMake(0, 0, 0, 0)];
                }else{
                    [cell jf_reloadLineLabel:UIEdgeInsetsMake(0, self.defaultSeparatorLeftEdge, 0, 0)];
                }
            }else{
                [cell jf_reloadLineLabel:UIEdgeInsetsMake(0, self.defaultSeparatorLeftEdge, 0, 0)];
            }
        }        
    }
    if (tableRow.forbidSelect) {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }else {
        cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    }
    if ([cell respondsToSelector:@selector(refreshData:)]) {
        [(id<JFCommonTableViewCell>)cell refreshData:tableRow];
    }else{
        [self refreshData:tableRow cell:cell];
    }
    cell.accessoryType = tableRow.showAccessory ? UITableViewCellAccessoryDisclosureIndicator : UITableViewCellAccessoryNone;
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    JFCommonLocalTableSection *tableSection = self.data[indexPath.section];
    JFCommonLocalTableRow     *tableRow     = tableSection.rows[indexPath.row];
    return tableRow.uiRowHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    JFCommonLocalTableSection *tableSection = self.data[indexPath.section];
    JFCommonLocalTableRow     *tableRow     = tableSection.rows[indexPath.row];
    if (!tableRow.forbidSelect) {
        UIViewController *vc = tableView.jf_viewController;
        NSString *actionName = tableRow.cellActionName;
        if (actionName.length) {
            SEL sel = NSSelectorFromString(actionName);
            if ([vc respondsToSelector:sel]) {
                SuppressPerformSelectorLeakWarning([vc performSelector:sel withObject:tableRow]);
            }
        }
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    JFCommonLocalTableSection *tableSection = self.data[section];
    BOOL isHeader = tableSection.isHeader;
    if (!isHeader) {
        return tableSection.headOrFooterHeight;
    }
    return 0.1f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    JFCommonLocalTableSection *tableSection = self.data[section];
    BOOL isHeader = tableSection.isHeader;
    if (isHeader) {
        return tableSection.headOrFooterHeight;
    }
    return 0.1f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    JFCommonLocalTableSection *tableSection = self.data[section];
    if (tableSection.isHeader) {
        NSString *identity = tableSection.headOrFooterClassName.length ? tableSection.headOrFooterClassName : DefaultTableHeader;
        UITableViewHeaderFooterView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:identity];
        if (!view) {
            Class clazz = NSClassFromString(identity);
            view = [[clazz alloc] initWithReuseIdentifier:identity];
            view.contentView.backgroundColor = Main_Normal_BackColor;
            view.textLabel.font = FONT_15;
            view.textLabel.textColor = Main_Normal_SubtitleTextColor;
        }
        view.textLabel.text = [NSString isEmptyString:tableSection.headOrFooterTitle];
        if ([view respondsToSelector:@selector(refreshData:)]) {
            [(id<JFCommonTableViewHeaderFooter>)view refreshData:tableSection];
        }
        return view;
    }
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    JFCommonLocalTableSection *tableSection = self.data[section];
    if (!tableSection.isHeader) {
        NSString *identity = tableSection.headOrFooterClassName.length ? tableSection.headOrFooterClassName : DefaultTableHeader;
        UITableViewHeaderFooterView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:identity];
        if (!view) {
            Class clazz = NSClassFromString(identity);
            view = [[clazz alloc] initWithReuseIdentifier:identity];
            view.contentView.backgroundColor = Main_Normal_BackColor;
            view.textLabel.font = FONT_15;
            view.textLabel.textColor = Main_Normal_SubtitleTextColor;
        }
        view.textLabel.text = [NSString isEmptyString:tableSection.headOrFooterTitle];
        if ([view respondsToSelector:@selector(refreshData:)]) {
            [(id<JFCommonTableViewHeaderFooter>)view refreshData:tableSection];
        }
        return view;
    }
    return nil;
}
#pragma mark - Private
- (void)refreshData:(JFCommonLocalTableRow *)rowData cell:(UITableViewCell *)cell{
    cell.textLabel.text = rowData.title;
    cell.textLabel.font = FONT_15;
    cell.textLabel.textColor = Main_Normal_TextColor;
    cell.detailTextLabel.text = rowData.detailTitle;
    cell.detailTextLabel.font = FONT_14;
    cell.detailTextLabel.textColor = Main_Normal_SubtitleTextColor;
}
@end
