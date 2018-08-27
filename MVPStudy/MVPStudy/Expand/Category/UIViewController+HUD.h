/************************************************************
  *  * EaseMob CONFIDENTIAL 
  * __________________ 
  * Copyright (C) 2013-2014 EaseMob Technologies. All rights reserved. 
  *  
  * NOTICE: All information contained herein is, and remains 
  * the property of EaseMob Technologies.
  * Dissemination of this information or reproduction of this material 
  * is strictly forbidden unless prior written permission is obtained
  * from EaseMob Technologies.
  */

#import <UIKit/UIKit.h>

@interface UIViewController (HUD)

- (void)showCustomHudInView:(UIView *)view;

- (void)showHudInView:(UIView *)view hint:(NSString *)hint;

- (void)hideHud;

- (void)showHint:(NSString *)hint;

// 从默认(showHint:)显示的位置再往上(下)yOffset
- (void)showHint:(NSString *)hint yOffset:(float)yOffset;
-(void)showHudInView:(UIView *)view hintNotMessage:(NSString *)hint;
@end
@interface NSObject (HUD)
- (void)showInfoWithStatus:(NSString *)status;
- (void)showErrorWithStatus:(NSString *)status;
- (void)showSuccessWithStatus:(NSString *)status;
- (void)showInfoWithStatus:(NSString *)status andCurrentWindow:(UIWindow *)window;
- (void)showErrorWithStatus:(NSString *)status andCurrentWindow:(UIWindow *)window;
- (void)showSuccessWithStatus:(NSString *)status andCurrentWindow:(UIWindow *)window;
@end
