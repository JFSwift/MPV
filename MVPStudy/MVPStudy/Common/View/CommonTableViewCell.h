//
//  CommonTableViewCell.h
//  OneCarSales
//
//  Created by JoFox on 2017/10/20.
//  Copyright © 2017年 com.guangyao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommonTableViewCell : UITableViewCell
@property (nonatomic, strong) UILabel *lineLabel;

- (void)setupSubViews;
@end
