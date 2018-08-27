//
//  JFMacro.h
//  JFCarGuide
//
//  Created by JF on 2018/6/15.
//  Copyright © 2018年 JF. All rights reserved.
//

#ifndef JFMacro_h
#define JFMacro_h

#define JF_Dispatch_Sync_Main(block)\
if ([NSThread isMainThread]) {\
block();\
} else {\
dispatch_sync(dispatch_get_main_queue(), block);\
}

#define JF_Dispatch_Async_Main(block)\
if ([NSThread isMainThread]) {\
block();\
} else {\
dispatch_async(dispatch_get_main_queue(), block);\
}

/* weak reference */
#define JF_WEAK_SELF(weakSelf) __weak __typeof(&*self) weakSelf = self;
#define JF_STRONG_SELF(strongSelf) __strong __typeof(&*weakSelf) strongSelf = weakSelf;

#define SuppressPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)

#ifdef DEBUG
#define NSLog(format, ...) printf("[%s] %s [第%d行] %s\n", __TIME__, __FUNCTION__, __LINE__, [[NSString stringWithFormat:format, ## __VA_ARGS__] UTF8String]);
#else
#define NSLog(format, ...)
#endif

#define JFSharedAppDelegate ((AppDelegate *)[UIApplication sharedApplication].delegate)
#define JFHiddenKeyBoard [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder)to:nil from:nil forEvent:nil]

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define pixw(p)  SCREEN_WIDTH/375.0*p
#define pixh(p)  SCREEN_HEIGHT/667.0*p
#define kStatusBarHeights [[UIApplication sharedApplication] statusBarFrame].size.height
#define kNavBarHeight 44.0
#define kTabBarHeight ([[UIApplication sharedApplication] statusBarFrame].size.height>20?83:49)
#define kTopHeight (kStatusBarHeights + kNavBarHeight)
#define kSafeAreaBottomHeight (SCREEN_HEIGHT == 812.0 ? 34 : 0)

// 计算文本长度高度
#define CalculateFontSize(str,with,height,fontSize) [str boundingRectWithSize:CGSizeMake(with, height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} context:nil].size

// 判断字符串是否为空
#define StringIsEmpty(string) ((![string isKindOfClass:[NSString class]])||[string isEqualToString:@""] || (string == nil) || [string isEqualToString:@""] || [string isKindOfClass:[NSNull class]]||[[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0)

//字体类
#define FONT_14 [UIFont systemFontOfSize:14]
#define FONT_15 [UIFont systemFontOfSize:15]
#define FONT_16 [UIFont systemFontOfSize:16]
#define FONT_17 [UIFont systemFontOfSize:17]
#define FONT_18 [UIFont systemFontOfSize:18]
#define FONT_19 [UIFont systemFontOfSize:19]
#define FONT_20 [UIFont systemFontOfSize:20]
#define FONT(I) [UIFont systemFontOfSize:I]

// 颜色类
#define Main_Normal_TextColor [UIColor colorWithHexString:@"#333333"]
#define Main_Normal_SubtitleTextColor [UIColor colorWithHexString:@"#666666"]
#define Main_Disabled_TextColor [UIColor colorWithHexString:@"#999999"]
#define Main_Select_TextColor [UIColor colorWithHexString:@"#e13a3a"]
#define Main_Tip_TextColor [UIColor colorWithHexString:@"#EE8A00"]
#define Main_Normal_BackColor [UIColor colorWithHexString:@"#f5f5f5"]
#define Main_Tint_BackColor [UIColor colorWithHexString:@"#01AE3B"]
#define CellLineBgColor [UIColor colorWithRed:0.784f green:0.780f blue:0.800f alpha:1.00f]
// 图片
#define PlaceholderImage [UIImage jf_imageNamed:@"Placeholder_Image.jpg"]
#endif /* JFMacro_h */
