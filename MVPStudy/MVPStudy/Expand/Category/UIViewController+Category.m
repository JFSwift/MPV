//
//  UIViewController+Category.m
//  9BaoCustomer
//
//  Created by JF on 2018/7/4.
//  Copyright © 2018年 JF. All rights reserved.
//

#import "UIViewController+Category.h"

@implementation UIViewController (Category)

/**
 移除当前控制器
 */
- (void)removeCurrenViewController {
    NSMutableArray *viewControllers = [[NSMutableArray alloc]initWithArray:self.navigationController.viewControllers];
    //遍历控制器，找到索引删除销毁
    for (int index = 0; index < viewControllers.count; index++){
        if ([viewControllers[index] isKindOfClass:self.class]){
            [viewControllers removeObjectAtIndex:index];
            break;
        }
    }
    //从新赋予栈内的控制器
    [self.navigationController setViewControllers:viewControllers];
}
@end
