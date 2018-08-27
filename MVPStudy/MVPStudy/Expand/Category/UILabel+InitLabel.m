//
//  UILabel+InitLabel.m
//  Saipote
//
//  Created by JoFox on 2018/1/5.
//  Copyright © 2018年 com.saipote.saipote. All rights reserved.
//

#import "UILabel+InitLabel.h"
#import <objc/runtime.h>
#define UI_PLACEHOLDER_TEXT_COLOR [UIColor colorWithRed:170.0/255.0 green:170.0/255.0 blue:170.0/255.0 alpha:1.0]
@implementation UILabel (InitLabel)
+ (UILabel *)jf_creatUILabel:(UIFont *)font andTextColor:(UIColor *)textColor andTextAlignment:(NSTextAlignment)alignment {
    UILabel *label = [[UILabel alloc]init];
    label.font = font;
    label.textColor = textColor;
    label.textAlignment = alignment;
    return label;
}
@end
@implementation UITableView (InitTableView)
+ (UITableView *)jf_creatUITableView:(id)delegate {
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;            
    tableView.delegate = delegate;
    tableView.dataSource = delegate;
    return tableView;
}
- (void)jf_registerClassCell:(NSString *)cellName, ...NS_REQUIRES_NIL_TERMINATION {
    NSAssert(cellName != nil, @"the first controller must not be nil!");
    NSString *name;
    va_list argumentList;
    if (cellName) {
        [self registerClass:NSClassFromString(cellName) forCellReuseIdentifier:cellName];
        va_start(argumentList, cellName);
        while ((name = va_arg(argumentList, id))) {
            [self registerClass:NSClassFromString(name) forCellReuseIdentifier:name];
        }
        va_end(argumentList);
    }
}

- (void)jf_registerClassHeaderFooterView:(NSString *)headerfooterviewName, ...NS_REQUIRES_NIL_TERMINATION {
    NSAssert(headerfooterviewName != nil, @"the first controller must not be nil!");
    NSString *name;
    va_list argumentList;
    if (headerfooterviewName) {
        [self registerClass:NSClassFromString(headerfooterviewName) forHeaderFooterViewReuseIdentifier:headerfooterviewName];
        va_start(argumentList, headerfooterviewName);
        while ((name = va_arg(argumentList, id))) {
            [self registerClass:NSClassFromString(name) forHeaderFooterViewReuseIdentifier:name];
        }
        va_end(argumentList);
    }
}

/**
 *  添加上拉加载
 */
-(void)addTableViewRequestFoot:(MJRefreshComponentRefreshingBlock)refreshingBlock{
    if (!self.mj_footer) {
        MJRefreshAutoNormalFooter *foot = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:refreshingBlock];
        self.mj_footer = foot;
    }
}
/**
 添加下拉刷新
 */
- (void)addTableViewRequestHead:(MJRefreshComponentRefreshingBlock)refreshingBlock{
    self.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:refreshingBlock];
}
/**
 移除上拉
 */
- (void)removeRequestFoot {
    self.mj_footer = nil;
}
@end
@implementation UICollectionView (InitCollectionView)
+ (UICollectionView *)jf_creatUICollectionView:(id)delegate {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    collectionView.dataSource = delegate;
    collectionView.delegate = delegate;
    return collectionView;
}
- (void)jf_registerClassCell:(NSString *)cellName, ...NS_REQUIRES_NIL_TERMINATION {
    NSAssert(cellName != nil, @"the first controller must not be nil!");
    NSString *name;
    va_list argumentList;
    if (cellName) {
        [self registerClass:NSClassFromString(cellName) forCellWithReuseIdentifier:cellName];
        va_start(argumentList, cellName);
        while ((name = va_arg(argumentList, id))) {
            [self registerClass:NSClassFromString(name) forCellWithReuseIdentifier:name];
        }
        va_end(argumentList);
    }
}
@end

@implementation UIButton (InitButton)
+ (UIButton *)jf_creatUIButton:(UIFont *)font andNormalTextColor:(UIColor *)color {
    UIButton *button = [[UIButton alloc]init];
    button.titleLabel.font = font;
    [button setTitleColor:color forState:UIControlStateNormal];
    return button;
}
- (void)jf_setNormalText:(NSString *)text {
    [self setTitle:text forState:UIControlStateNormal];
}
- (void)jf_setSelectText:(NSString *)text {
    [self setTitle:text forState:UIControlStateSelected];
}
- (void)jf_setNormalTextColor:(UIColor *)color {
    [self setTitleColor:color forState:UIControlStateNormal];
}
- (void)jf_setSelectTextColor:(UIColor *)color {
    [self setTitleColor:color forState:UIControlStateSelected];
}
- (void)jf_setNormalImage:(NSString *)imageName {
    [self setImage:[UIImage jf_imageNamed:imageName] forState:UIControlStateNormal];
}
- (void)jf_setSelectImage:(NSString *)imageName {
    [self setImage:[UIImage jf_imageNamed:imageName] forState:UIControlStateSelected];
}
- (void)jf_setNormalBackImage:(NSString *)imageName {
    [self setBackgroundImage:[UIImage jf_imageNamed:imageName] forState:UIControlStateNormal];
}
- (void)jf_setSelectBackImage:(NSString *)imageName{
    [self setBackgroundImage:[UIImage jf_imageNamed:imageName] forState:UIControlStateSelected];
}

@end
static const void *tableViewCellBottomKey = &tableViewCellBottomKey;

@implementation UIView (AddBottomLine)
- (UILabel *)LineLabel{
    return objc_getAssociatedObject(self, tableViewCellBottomKey);
}

- (void)setLineLabel:(UILabel *)LineLabel{
    objc_setAssociatedObject(self, tableViewCellBottomKey, LineLabel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)addBottomLine{
    UILabel *lineLable =  [self LineLabel];
    if (!lineLable) {
        lineLable = [[UILabel alloc] init];
        lineLable.backgroundColor = CellLineBgColor;
        [self addSubview:lineLable];
    }
    [self setLineLabel:lineLable];
}
- (void)jf_reloadLineLabel:(UIEdgeInsets)insets {
    UILabel *lineLable = [self LineLabel];
    [lineLable mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.offset(insets.left);
        make.right.offset(-insets.right);
        make.bottom.offset(-insets.bottom);
        make.height.offset(0.5);
    }];
    [self layoutIfNeeded];
}
- (void)jf_addLineLabel:(UIEdgeInsets)insets {
    [self addBottomLine];
    UILabel *lineLable = [self LineLabel];
    [lineLable mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(insets.left);
        make.right.offset(-insets.right);
        make.bottom.offset(-insets.bottom);
        make.height.offset(0.5);
    }];    
}
@end
@implementation UITextView (placeholder)
-(void)setTextValue:(NSString *)textValue
{
    //  Change the text of our UITextView, and check whether we need to display the placeholder.
    self.text = textValue;
    [self checkIfNeedToDisplayPlaceholder];
}
-(NSString*)textValue
{
    return self.text;
}

-(void)checkIfNeedToDisplayPlaceholder
{
    //  If our UITextView is empty, display our Placeholder label (if we have one)
    if (self.placeholderLabel == nil)
        return;
    
    self.placeholderLabel.hidden = (![self.text isEqualToString:@""]);
}

-(void)onTap
{
    //  When the user taps in our UITextView, we'll see if we need to remove the placeholder text.
    [self checkIfNeedToDisplayPlaceholder];
    
    //  Make the onscreen keyboard appear.
    [self becomeFirstResponder];
}

-(void)keyPressed:(NSNotification*)notification
{
    //  The user has just typed a character in our UITextView (or pressed the delete key).
    //  Do we need to display our Placeholder label ?
    [self checkIfNeedToDisplayPlaceholder];
}

#pragma mark - Add a "placeHolder" string to the UITextView class

NSString const *kKeyPlaceHolder = @"kKeyPlaceHolder";
-(void)setPlaceholder:(NSString *)_placeholder
{
    //  Sets our "placeholder" text string, creates a new UILabel to contain it, and modifies our UITextView to cope with
    //  showing/hiding the UILabel when needed.
    objc_setAssociatedObject(self, &kKeyPlaceHolder, (id)_placeholder, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    self.placeholderLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, 8, 0, 0)];
    self.placeholderLabel.numberOfLines = 1;
    self.placeholderLabel.text = _placeholder;
    self.placeholderLabel.textColor = UI_PLACEHOLDER_TEXT_COLOR;
    self.placeholderLabel.backgroundColor = [UIColor clearColor];
    self.placeholderLabel.userInteractionEnabled = true;
    self.placeholderLabel.font = self.font;
    [self addSubview:self.placeholderLabel];
    
    [self.placeholderLabel sizeToFit];
    
    //  Whenever the user taps within the UITextView, we'll give the textview the focus, and hide the placeholder if necessary.
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTap)]];
    
    //  Whenever the user types something in the UITextView, we'll see if we need to hide/show the placeholder label.
    [[NSNotificationCenter defaultCenter] addObserver:self selector: @selector(keyPressed:) name:UITextViewTextDidChangeNotification object:nil];
    
    [self checkIfNeedToDisplayPlaceholder];
}
-(NSString*)placeholder
{
    //  Returns our "placeholder" text string
    return objc_getAssociatedObject(self, &kKeyPlaceHolder);
}

#pragma mark - Add a "UILabel" to this UITextView class

NSString const *kKeyLabel = @"kKeyLabel";
-(void)setPlaceholderLabel:(UILabel *)placeholderLabel
{
    //  Stores our new UILabel (which contains our placeholder string)
    objc_setAssociatedObject(self, &kKeyLabel, (id)placeholderLabel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector: @selector(keyPressed:) name:UITextViewTextDidChangeNotification object:nil];
    
    [self checkIfNeedToDisplayPlaceholder];
}
-(UILabel*)placeholderLabel
{
    //  Returns our new UILabel
    return objc_getAssociatedObject(self, &kKeyLabel);
}
@end
