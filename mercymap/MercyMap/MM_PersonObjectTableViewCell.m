//
//  MM_PersonObjectTableViewCell.m
//  MercyMap
//
//  Created by RainGu on 17/2/16.
//  Copyright © 2017年 Wispeed. All rights reserved.
//

#import "MM_PersonObjectTableViewCell.h"
#import "Masonry.h"
@implementation MM_PersonObjectTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview: self.personobjectLable];
        [self.contentView setNeedsUpdateConstraints];
    }
    return self;
}

-(void)configData:(id)data{
    self.personobjectLable.text = data;
}

-(void)updateConstraints{
    [super updateConstraints];
    [self.personobjectLable  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView).offset(10);
        make.left.mas_equalTo(self.contentView).offset(15);
        make.height.mas_equalTo(24);
    }];
 }

-(UILabel *)personobjectLable{
    if (_personobjectLable == nil) {
        _personobjectLable = [[UILabel alloc]init];
        _personobjectLable.textColor = [UIColor lightGrayColor];
        _personobjectLable.font = [UIFont systemFontOfSize:17.0];
    }
    return _personobjectLable;
}
@end
