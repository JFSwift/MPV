//
//  CommonTableViewCell.m
//  OneCarSales
//
//  Created by JoFox on 2017/10/20.
//  Copyright © 2017年 com.guangyao. All rights reserved.
//

#import "CommonTableViewCell.h"

@implementation CommonTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupSubViews];
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupSubViews];
}
- (void)setupSubViews {
    [self addSubview:self.lineLabel];
}
- (UILabel *)lineLabel {
    if (!_lineLabel) {
        _lineLabel = [[UILabel alloc]init];
        _lineLabel.backgroundColor = CellLineBgColor;
    }
    return _lineLabel;
}
@end
