//
//  NSObject+SystemPermissions.h
//  OneCarSales
//
//  Created by JoFox on 2017/10/20.
//  Copyright © 2017年 com.guangyao. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    systemAuthorityCamera,
    systemAuthorityPhotoLibrary,
    systemAuthorityNotifacation,
    systemAuthorityNetwork,
    systemAuthorityAudio,
    systemAuthorityLocation,
    systemAuthorityAddressBook,
    systemAuthorityCalendar,
    systemAuthorityReminder,    
} systemAuthorityType;

@interface NSObject (SystemPermissions)
/**
 相机权限开关
 @return YES／NO
 */
- (BOOL)CameraAuthority;
/**
 相册权限开关
 @return YES／NO
 */
- (BOOL)PhotoLibraryAuthority;
/**
 推送权限开关
 @return YES/NO
 */
- (BOOL)notificationAuthority;
/**
 连网权限开关
 @return YES/NO
 */
- (BOOL)netWorkAuthority;
/**
 麦克风权限开关
 @return YES/NO
 */
- (BOOL)audioAuthority;
/**
 定位权限开关
 @return YES/NO
 */
- (BOOL)locationAuthority;
/**
 通讯录权限开关
 @return YES/NO
 */
- (BOOL)addressBookAuthority;
/**
 日历权限开关
 @return YES/NO
 */
- (BOOL)calendarAuthority;
/**
 备忘录权限开关
 @return YES/NO
 */
- (BOOL)reminderAuthority;

@end

