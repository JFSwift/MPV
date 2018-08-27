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

#import "UIViewController+HUD.h"
#import <MBProgressHUD.h>
#import <objc/runtime.h>

static const void *HttpRequestHUDKey = &HttpRequestHUDKey;

@implementation UIViewController (HUD)

- (MBProgressHUD *)HUD{
    return objc_getAssociatedObject(self, HttpRequestHUDKey);
}

- (void)setHUD:(MBProgressHUD *)HUD{
    objc_setAssociatedObject(self, HttpRequestHUDKey, HUD, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)showHudInView:(UIView *)view hint:(NSString *)hint{
    MBProgressHUD *HUD = [self HUD];
    if (!HUD) {
        HUD = [[MBProgressHUD alloc] initWithView:view];
    }
    HUD.mode = MBProgressHUDModeIndeterminate;
    HUD.bezelView.color = [UIColor blackColor];
    HUD.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    HUD.bezelView.color = [[UIColor blackColor] colorWithAlphaComponent:0.8];
    HUD.contentColor = [UIColor whiteColor];
    HUD.label.text = hint;
    [view addSubview:HUD];
    [HUD showAnimated:YES];
    [self setHUD:HUD];
}
- (void)showCustomHudInView:(UIView *)view {
    MBProgressHUD *HUD = [self HUD];
    if (!HUD) {
        HUD = [[MBProgressHUD alloc] initWithView:view];
    }
    HUD.mode = MBProgressHUDModeCustomView;
    HUD.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    HUD.bezelView.color = [UIColor clearColor];
    CAReplicatorLayer *replicatorLayer = [CAReplicatorLayer layer];
    replicatorLayer.bounds = CGRectMake(0.0,0.0,pixw(90),pixw(80));
    replicatorLayer.cornerRadius = 10.0;
    /** 视图相对于父视图的重心位置*/
    replicatorLayer.position = HUD.center;
    [HUD.layer addSublayer:replicatorLayer];
    CALayer *dot = [CALayer layer];
    dot.bounds = CGRectMake(0, 0, pixw(10), pixw(10));
    dot.position = CGPointMake(pixw(50), pixw(20));
    dot.backgroundColor = Main_Normal_TextColor.CGColor;
    dot.cornerRadius = pixw(5);
    dot.masksToBounds = YES;
    [replicatorLayer addSublayer:dot];
    CGFloat count = 8.0;
    replicatorLayer.instanceCount = count; //小圆圈的个数
    CGFloat nrDots = 2 * M_PI/count;
    replicatorLayer.instanceTransform = CATransform3DMakeRotation(nrDots, 0, 0, 1); //每次旋转的角度等于2π/ 10
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.duration = 1; //1秒的延迟动画。在到原来的点上做缩放变化
    animation.fromValue = @(1);
    animation.toValue = @(0.1);
    animation.repeatCount = MAXFLOAT;
    [dot addAnimation:animation forKey:nil];
    replicatorLayer.instanceDelay = 1.0/count; //使动画动起来的秘诀就是给出一点延迟到每一个副本
    dot.transform = CATransform3DMakeScale(0.01, 0.01, 0.01); //解决旋转衔接效果
    
    [view addSubview:HUD];
    [HUD showAnimated:YES];
    [self setHUD:HUD];
}

- (void)showHint:(NSString *)hint
{
    //显示提示信息
    UIView *view = [[UIApplication sharedApplication].delegate window];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.bezelView.color = [UIColor blackColor];
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.color = [[UIColor blackColor] colorWithAlphaComponent:0.8];
    hud.contentColor = [UIColor whiteColor];
    hud.userInteractionEnabled = NO;
    // Configure for text only and offset down
    hud.mode = MBProgressHUDModeText;
    hud.label.text = hint;
    hud.margin = 10.f;
//    hud.yOffset = IS_IPHONE_5?200.f:150.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hideAnimated:YES afterDelay:3];
}

- (void)showHint:(NSString *)hint yOffset:(float)yOffset {
    //显示提示信息
    UIView *view = [[UIApplication sharedApplication].delegate window];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.bezelView.color = [UIColor blackColor];
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.color = [[UIColor blackColor] colorWithAlphaComponent:0.8];
    hud.contentColor = [UIColor whiteColor];
    hud.userInteractionEnabled = NO;
    // Configure for text only and offset down
    hud.mode = MBProgressHUDModeText;
    hud.label.text = hint;
    hud.margin = 10.f;
    [hud setOffset:CGPointMake(0, hud.offset.y+yOffset)];
    hud.removeFromSuperViewOnHide = YES;
    [hud hideAnimated:YES afterDelay:3];
}
-(void)showHudInView:(UIView *)view hintNotMessage:(NSString *)hint
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    hud.bezelView.color = [UIColor blackColor];
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.color = [[UIColor blackColor] colorWithAlphaComponent:0.8];
    hud.contentColor = [UIColor whiteColor];
    // Configure for text only and offset down
    hud.mode = MBProgressHUDModeText;
    hud.label.text = hint;
//    hud.margin = 10.f;
    hud.removeFromSuperViewOnHide = YES;
    
    [hud hideAnimated:YES afterDelay:3];

}
- (void)hideHud{
    [[self HUD] hideAnimated:YES];
}
@end
@implementation NSObject (HUD)
- (void)showImageWithImageName:(NSString *)imageName andStatus:(NSString *)status andCurrentWindow:(UIWindow *)window {
    if (!window) {
        window = JFSharedAppDelegate.window;
    }
    //显示提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:window animated:YES];
    hud.customView = [[UIImageView alloc]initWithImage:[UIImage jf_imageNamed:imageName]];
    hud.bezelView.color = [UIColor blackColor];
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.color = [[UIColor blackColor] colorWithAlphaComponent:0.8];
//    hud.contentColor = [UIColor whiteColor];
//    hud.userInteractionEnabled = NO;
    // Configure for text only and offset down
    hud.mode = MBProgressHUDModeCustomView;
    hud.label.text = status;
    hud.label.textColor = UIColor.whiteColor;
    hud.margin = 10.f;
    //    hud.yOffset = IS_IPHONE_5?200.f:150.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hideAnimated:YES afterDelay:3];
}
- (void)showInfoWithStatus:(NSString *)status {
    [self showImageWithImageName:@"MBProgressTip" andStatus:status andCurrentWindow:nil];
}
- (void)showErrorWithStatus:(NSString *)status {
    [self showImageWithImageName:@"MBProgressError" andStatus:status andCurrentWindow:nil];
}
- (void)showSuccessWithStatus:(NSString *)status {
    [self showImageWithImageName:@"MBProgressSuccess" andStatus:status andCurrentWindow:nil];
}
- (void)showInfoWithStatus:(NSString *)status andCurrentWindow:(UIWindow *)window {
    [self showImageWithImageName:@"MBProgressTip" andStatus:status andCurrentWindow:window];
}
- (void)showErrorWithStatus:(NSString *)status andCurrentWindow:(UIWindow *)window {
    [self showImageWithImageName:@"MBProgressError" andStatus:status andCurrentWindow:window];
}
- (void)showSuccessWithStatus:(NSString *)status andCurrentWindow:(UIWindow *)window {
    [self showImageWithImageName:@"MBProgressSuccess" andStatus:status andCurrentWindow:window];
}
@end
