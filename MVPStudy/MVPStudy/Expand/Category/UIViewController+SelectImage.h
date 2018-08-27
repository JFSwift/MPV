//
//  UIViewController+SelectImage.h
//  9BaoCustomer
//
//  Created by JF on 2018/6/29.
//  Copyright © 2018年 JF. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (SelectImage) <UINavigationControllerDelegate, UIImagePickerControllerDelegate>
- (void)getCameraOrLibrary:(UIImagePickerControllerSourceType)type andEdit:(BOOL)edit andBlock:(void(^)(UIImage *image))uploadImageBlock;
@end
