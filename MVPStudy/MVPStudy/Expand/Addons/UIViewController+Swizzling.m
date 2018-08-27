//
//  UIViewController+Swizzling.m
//  NIM
//
//  Created by chris on 15/6/15.
//  Copyright (c) 2015年 Netease. All rights reserved.
//

#import "UIViewController+Swizzling.h"
#import "MBProgressHUD.H"
#import "SwizzlingDefine.h"
#import "UIResponder+FirstResponder.h"
#import "UIView+Frame.h"

@implementation UIViewController (Swizzling)

+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        swizzling_exchangeMethod([UIViewController class] ,@selector(viewWillAppear:), @selector(swizzling_viewWillAppear:));
        swizzling_exchangeMethod([UIViewController class] ,@selector(viewDidAppear:), @selector(swizzling_viewDidAppear:));
        swizzling_exchangeMethod([UIViewController class] ,@selector(viewWillDisappear:), @selector(swizzling_viewWillDisappear:));
        swizzling_exchangeMethod([UIViewController class] ,@selector(viewDidLoad),    @selector(swizzling_viewDidLoad));
        swizzling_exchangeMethod([UIViewController class], @selector(initWithNibName:bundle:), @selector(swizzling_initWithNibName:bundle:));
    });
}
- (void)swizzling_dealloc {
    NSLog(@"%@ swizzling_dealloc",NSStringFromClass(self.class));
}
#pragma mark - ViewDidLoad
- (void)swizzling_viewDidLoad{
    if (self.navigationController) {
        UIImage *buttonNormal = [[UIImage jf_imageNamed:@"navigationBarBackItemImage"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [self.navigationController.navigationBar setBackIndicatorImage:buttonNormal];
        self.navigationController.navigationBar.tintColor = Main_Normal_TextColor;
        [self.navigationController.navigationBar setBackIndicatorTransitionMaskImage:buttonNormal];
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
        self.navigationItem.backBarButtonItem = backItem;
        // 判断是否是当前的view 继承父类会有影响
        // 主要是处理系统相册偏移问题
//        if ([NSStringFromClass(self.superclass) isEqualToString:@"UITableViewController"] || [NSStringFromClass(self.superclass) isEqualToString:@"UIViewController"]) {
//            if (@available(ios 11.0,*)) {
//                UIScrollView.appearance.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
//                UITableView.appearance.estimatedRowHeight = 0;
//                UITableView.appearance.estimatedSectionFooterHeight = 0;
//                UITableView.appearance.estimatedSectionHeaderHeight = 0;
//            }else{
//                self.automaticallyAdjustsScrollViewInsets = NO;
//            }
//        }else{
//            if (@available(ios 11.0,*)) {
//                UIScrollView.appearance.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAutomatic;
//                UITableView.appearance.estimatedRowHeight = 0;
//                UITableView.appearance.estimatedSectionFooterHeight = 0;
//                UITableView.appearance.estimatedSectionHeaderHeight = 0;
//            }else{
//                self.automaticallyAdjustsScrollViewInsets = YES;
//            }
//        }
    }
    [self swizzling_viewDidLoad];
}


#pragma mark - InitWithNibName:bundle:
//如果希望vchidesBottomBarWhenPushed为NO的话，请在vc init方法之后调用vc.hidesBottomBarWhenPushed = NO;
- (instancetype)swizzling_initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    id instance = [self swizzling_initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (instance) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return instance;
}

#pragma mark - ViewWillAppear
static char UIFirstResponderViewAddress;

- (void)swizzling_viewWillAppear:(BOOL)animated{
    [self swizzling_viewWillAppear:animated];
    if (self.parentViewController == self.navigationController)
    {
        if ([self swizzling_isUseClearBar] && self.navigationController)
        {
            [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
            [self.navigationController.navigationBar setShadowImage:[UIImage new]];
        }
        else
        {
            [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
            [self.navigationController.navigationBar setShadowImage:nil];
        }
    }
}

#pragma mark - ViewDidAppear
- (void)swizzling_viewDidAppear:(BOOL)animated{
    [self swizzling_viewDidAppear:animated];
    UIView *view = objc_getAssociatedObject(self, &UIFirstResponderViewAddress);
    [view becomeFirstResponder];
}


#pragma mark - ViewWillDisappear

- (void)swizzling_viewWillDisappear:(BOOL)animated{
    [self swizzling_viewWillDisappear:animated];
    UIView *view = (UIView *)[UIResponder currentFirstResponder];
    if ([view isKindOfClass:[UIView class]] && view.jf_viewController == self) {
        objc_setAssociatedObject(self, &UIFirstResponderViewAddress, view, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [view resignFirstResponder];
    }else{
        objc_setAssociatedObject(self, &UIFirstResponderViewAddress, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

#pragma mark - Private
- (BOOL)swizzling_isUseClearBar
{
    SEL  sel = NSSelectorFromString(@"useClearBar");
    BOOL use = NO;
    if ([self respondsToSelector:sel]) {
        SuppressPerformSelectorLeakWarning(use = (BOOL)[self performSelector:sel]);
    }
    return use;
}


@end
