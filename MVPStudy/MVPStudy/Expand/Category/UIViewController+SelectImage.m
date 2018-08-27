//
//  UIViewController+SelectImage.m
//  9BaoCustomer
//
//  Created by JF on 2018/6/29.
//  Copyright © 2018年 JF. All rights reserved.
//

#import "UIViewController+SelectImage.h"
#import "NSObject+SystemPermissions.h"
#import "UIImage+fixOrientation.h"

@implementation UIViewController (SelectImage)
#pragma mark ==================UINavigationControllerDelegate||UIImagePickerControllerDelegate===================

static const void *kimageBlockKey = &kimageBlockKey;

-(void)setImageBlockKey:(void(^)(UIImage *image))imageBlock
{
    objc_setAssociatedObject(self, kimageBlockKey, imageBlock, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(void(^)(UIImage *image))imageBlock
{
    return objc_getAssociatedObject(self, kimageBlockKey);
}
- (void)getCameraOrLibrary:(UIImagePickerControllerSourceType)type andEdit:(BOOL)edit andBlock:(void(^)(UIImage *image))uploadImageBlock {
    [self setImageBlockKey:uploadImageBlock];
    if (type == UIImagePickerControllerSourceTypeCamera) {
        if (![self CameraAuthority]) {
            return;
        }
    }else if(type == UIImagePickerControllerSourceTypePhotoLibrary){
        if (![self PhotoLibraryAuthority]) {
            return;
        }
    }
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    //sourceType——设置图片来源
    imagePicker.sourceType = type;
    imagePicker.delegate = self;
    //是否允许对图片进行编辑
    imagePicker.allowsEditing = edit;
    // 去除毛玻璃使页面偏移正常
    imagePicker.navigationBar.translucent = YES;
    [JFSharedAppDelegate.window.rootViewController presentViewController:imagePicker animated:YES completion:^{
    }];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:^{
//        if (@available(ios 11.0,*)) {
//            UIScrollView.appearance.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
//        }
    }];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    //当选择的类型是图片
    if ([type isEqualToString:@"public.image"])
    {
        NSString *key = nil;
        if (picker.allowsEditing)
        {
            key = UIImagePickerControllerEditedImage;
        }
        else
        {
            key = UIImagePickerControllerOriginalImage;
        }
        UIImage *portraitImg = [[info objectForKey:key] fixOrientation];
        JF_WEAK_SELF(weakSelf);
        [JFSharedAppDelegate.window.rootViewController dismissViewControllerAnimated:YES completion:^{
            [weakSelf imageBlock](portraitImg);
        }];

    }
}
@end
