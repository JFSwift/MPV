//
//  NSObject+SystemPermissions.m
//  OneCarSales
//
//  Created by JoFox on 2017/10/20.
//  Copyright © 2017年 com.guangyao. All rights reserved.
//

#import "NSObject+SystemPermissions.h"
#import "MMAlertView.h"
#import <AVFoundation/AVFoundation.h>
#import <Photos/Photos.h>
#import <AssetsLibrary/AssetsLibrary.h>
@import CoreTelephony;
#import <UserNotifications/UserNotifications.h>
#import <CoreLocation/CoreLocation.h>
#import <AddressBook/AddressBook.h>
#import <Contacts/Contacts.h>
#import <EventKit/EventKit.h>

@implementation NSObject (SystemPermissions)

//手机系统版本号
#define SYSTEMVERSION [[[UIDevice currentDevice]systemVersion]floatValue]

- (BOOL)CameraAuthority
{
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusDenied || authStatus == AVAuthorizationStatusRestricted) {
        [self showAlertWithType:systemAuthorityCamera];
        return NO;
    }
    return YES;
}


- (BOOL)PhotoLibraryAuthority
{
    if (SYSTEMVERSION >= 8.0) {
        PHAuthorizationStatus authStatus = [PHPhotoLibrary authorizationStatus];
        if(authStatus == PHAuthorizationStatusDenied || authStatus == PHAuthorizationStatusRestricted) {
            // 未授权
            [self showAlertWithType:systemAuthorityPhotoLibrary];
            return NO;
        }
    }
    else if (SYSTEMVERSION >= 6.0 && SYSTEMVERSION < 8.0)
    {
        ALAuthorizationStatus authStatus = [ALAssetsLibrary authorizationStatus];
        if(authStatus == ALAuthorizationStatusDenied || authStatus == ALAuthorizationStatusRestricted) {
            // 未授权
            [self showAlertWithType:systemAuthorityPhotoLibrary];
            return NO;
        }
    }
    return YES;
}

- (BOOL)notificationAuthority
{
    if (SYSTEMVERSION>=8.0f)
    {
        UIUserNotificationSettings *setting = [[UIApplication sharedApplication] currentUserNotificationSettings];
        if (UIUserNotificationTypeNone == setting.types)
        {
            [self showAlertWithType:systemAuthorityNotifacation];
            return NO;
        }
        
    }
    else
    {
        UIRemoteNotificationType type = [[UIApplication sharedApplication] enabledRemoteNotificationTypes];
        if(UIRemoteNotificationTypeNone == type){
            [self showAlertWithType:systemAuthorityNotifacation];
            return NO;
        }
    }
    return YES;
}

- (BOOL)netWorkAuthority
{
    CTCellularData *cellularData = [[CTCellularData alloc]init];
    CTCellularDataRestrictedState state = cellularData.restrictedState;
    if (state == kCTCellularDataRestricted) {
        [self showAlertWithType:systemAuthorityNetwork];
        return NO;
    }
    return YES;
}

- (BOOL)audioAuthority
{
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeAudio];
    if (authStatus == AVAuthorizationStatusDenied || authStatus == AVAuthorizationStatusRestricted) {
        [self showAlertWithType:systemAuthorityAudio];
        return NO;
    }
    return YES;
}

- (BOOL)locationAuthority
{
    BOOL isLocation = [CLLocationManager locationServicesEnabled];
    if (!isLocation) {
        CLAuthorizationStatus CLstatus = [CLLocationManager authorizationStatus];
        if (CLstatus == kCLAuthorizationStatusDenied || CLstatus == kCLAuthorizationStatusDenied) {
            [self showAlertWithType:systemAuthorityLocation];
            return NO;
        }
    }
    return YES;
}

- (BOOL)addressBookAuthority
{
    if (SYSTEMVERSION >= 9.0) {
        CNAuthorizationStatus status = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
        if (status == CNAuthorizationStatusDenied || status == CNAuthorizationStatusRestricted)
        {
            [self showAlertWithType:systemAuthorityAddressBook];
            return NO;
            
        }
    }
    else
    {
        ABAuthorizationStatus ABstatus = ABAddressBookGetAuthorizationStatus();
        if (ABstatus == kABAuthorizationStatusDenied || ABstatus == kABAuthorizationStatusRestricted)
        {
            [self showAlertWithType:systemAuthorityAddressBook];
            return NO;
        }
    }
    return YES;
}

- (BOOL)calendarAuthority
{
    EKAuthorizationStatus EKstatus = [EKEventStore authorizationStatusForEntityType:EKEntityTypeEvent];
    if (EKstatus == EKAuthorizationStatusDenied || EKstatus == EKAuthorizationStatusRestricted)
    {
        [self showAlertWithType:systemAuthorityCalendar];
        return NO;
    }
    return YES;
}

- (BOOL)reminderAuthority
{
    EKAuthorizationStatus EKstatus = [EKEventStore authorizationStatusForEntityType:EKEntityTypeReminder];
    if (EKstatus == EKAuthorizationStatusDenied || EKstatus == EKAuthorizationStatusRestricted)
    {
        [self showAlertWithType:systemAuthorityReminder];
        return NO;
    }
    return YES;
}

- (void)showAlertWithType:(systemAuthorityType)type
{
    NSString *title;
    NSString *msg;
    switch (type) {
        case systemAuthorityCamera:
            title = @"未获得授权使用相机";
            msg = @"请在设备的 设置-隐私-相机 中打开。";
            break;
        case systemAuthorityPhotoLibrary:
            title = @"未获得授权使用相册";
            msg = @"请在设备的 设置-隐私-照片 中打开。";
            break;
        case systemAuthorityNotifacation:
            title = @"未获得授权使用推送";
            msg = @"请在设备的 设置-隐私-推送 中打开。";
            break;
        case systemAuthorityNetwork:
            title = @"未获得授权使用网络";
            msg = @"请在设备的 设置-隐私-网络 中打开。";
            break;
        case systemAuthorityAudio:
            title = @"未获得授权使用麦克风";
            msg = @"请在设备的 设置-隐私-麦克风 中打开。";
            break;
        case systemAuthorityLocation:
            title = @"未获得授权使用定位";
            msg = @"请在设备的 设置-隐私-定位 中打开。";
            break;
        case systemAuthorityAddressBook:
            title = @"未获得授权使用通讯录";
            msg = @"请在设备的 设置-隐私-通讯录 中打开。";
            break;
        case systemAuthorityCalendar:
            title = @"未获得授权使用日历";
            msg = @"请在设备的 设置-隐私-日历 中打开。";
            break;
        case systemAuthorityReminder:
            title = @"未获得授权使用备忘录";
            msg = @"请在设备的 设置-隐私-备忘录 中打开。";
            break;
        default:
            break;
    }
    MMPopupItemHandler block = ^(NSInteger index){
    };
    MMAlertView *alertView = [[MMAlertView alloc] initWithTitle:title detail:msg items:@[MMItemMake(@"确定", MMItemTypeNormal, block)]];
    alertView.attachedView.mm_dimBackgroundBlurEnabled = NO;
    alertView.attachedView.mm_dimBackgroundBlurEffectStyle = UIBlurEffectStyleDark;
    [alertView showWithBlock:nil];
}
@end
