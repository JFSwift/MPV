//
//  UILabel+InitLabel.h
//  Saipote
//
//  Created by JoFox on 2018/1/5.
//  Copyright © 2018年 com.saipote.saipote. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (InitLabel)
+ (UILabel *)jf_creatUILabel:(UIFont *)font andTextColor:(UIColor *)textColor andTextAlignment:(NSTextAlignment)alignment;
@end
@interface UIButton (InitButton)
+ (UIButton *)jf_creatUIButton:(UIFont *)font andNormalTextColor:(UIColor *)color;
- (void)jf_setNormalText:(NSString *)text;
- (void)jf_setSelectText:(NSString *)text;
- (void)jf_setNormalTextColor:(UIColor *)color;
- (void)jf_setSelectTextColor:(UIColor *)color;
- (void)jf_setNormalImage:(NSString *)imageName;
- (void)jf_setSelectImage:(NSString *)imageName;
- (void)jf_setNormalBackImage:(NSString *)imageName;
- (void)jf_setSelectBackImage:(NSString *)imageName;
@end
@interface UITableView (InitTableView)
+ (UITableView *)jf_creatUITableView:(id)delegate;
- (void)jf_registerClassCell:(NSString *)cellName, ...NS_REQUIRES_NIL_TERMINATION;
- (void)jf_registerClassHeaderFooterView:(NSString *)headerfooterviewName, ...NS_REQUIRES_NIL_TERMINATION;
/**
 *  添加上拉加载
 */
-(void)addTableViewRequestFoot:(MJRefreshComponentRefreshingBlock)refreshingBlock;
/**
 添加下拉刷新
 */
- (void)addTableViewRequestHead:(MJRefreshComponentRefreshingBlock)refreshingBlock;

/**
 移除上拉
 */
- (void)removeRequestFoot;
@end
@interface UICollectionView (InitCollectionView)
+ (UICollectionView *)jf_creatUICollectionView:(id)delegate;
- (void)jf_registerClassCell:(NSString *)cellName, ...NS_REQUIRES_NIL_TERMINATION;
@end
@interface UIView (AddBottomLine)
- (void)jf_reloadLineLabel:(UIEdgeInsets)insets;
- (void)jf_addLineLabel:(UIEdgeInsets)insets;
@end
@interface UITextView (placeholder)
@property (nonatomic, strong) NSString* placeholder;
@property (nonatomic, strong) UILabel * placeholderLabel;
@property (nonatomic, strong) NSString* textValue;
@end
