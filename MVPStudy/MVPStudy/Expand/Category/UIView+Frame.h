//
//  UIView+Frame.h
//  CommondDemo
//
//  Created by JF on 2018/6/14.
//  Copyright © 2018年 JF. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Frame)
@property (nonatomic) CGFloat jf_left;

/**
 * Shortcut for frame.origin.y
 *
 * Sets frame.origin.y = top
 */
@property (nonatomic) CGFloat jf_top;

/**
 * Shortcut for frame.origin.x + frame.size.width
 *
 * Sets frame.origin.x = right - frame.size.width
 */
@property (nonatomic) CGFloat jf_right;

/**
 * Shortcut for frame.origin.y + frame.size.height
 *
 * Sets frame.origin.y = bottom - frame.size.height
 */
@property (nonatomic) CGFloat jf_bottom;

/**
 * Shortcut for frame.size.width
 *
 * Sets frame.size.width = width
 */
@property (nonatomic) CGFloat jf_width;

/**
 * Shortcut for frame.size.height
 *
 * Sets frame.size.height = height
 */
@property (nonatomic) CGFloat jf_height;

/**
 * Shortcut for center.x
 *
 * Sets center.x = centerX
 */
@property (nonatomic) CGFloat jf_centerX;

/**
 * Shortcut for center.y
 *
 * Sets center.y = centerY
 */
@property (nonatomic) CGFloat jf_centerY;
/**
 * Shortcut for frame.origin
 */
@property (nonatomic) CGPoint jf_origin;

/**
 * Shortcut for frame.size
 */
@property (nonatomic) CGSize jf_size;

//找到自己的vc
- (UIViewController *)jf_viewController;

/**
 执行控制器的方法

 @param sel 方法
 @param obj 传值
 */
- (void)jf_executionViewControllerMeth:(SEL)sel andObj:(id)obj;

+ (UIView *)n_loadFromNibName:(NSString *)nibName;
+ (UIView *)n_loadFromNib;

@end
