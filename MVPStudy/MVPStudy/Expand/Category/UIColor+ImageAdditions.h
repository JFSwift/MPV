//
//  UIColor+ImageAdditions.h
//  Saipote
//
//  Created by JoFox on 2018/1/5.
//  Copyright © 2018年 com.saipote.saipote. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (ImageAdditions)
- (UIImage *)jf_imageSized:(CGSize)size;
@end
@interface UIImage (AddCornerWithRadius)
- (UIImage *)jf_imageAddCornerWithRadius:(CGFloat)radius andSize:(CGSize)size;
+ (UIImage *)jf_imageAddCornerWithRadius:(CGFloat)radius andSize:(CGSize)size andColor:(UIColor *)color;
+ (UIImage *)jf_imageNamed:(NSString *)name;
@end
