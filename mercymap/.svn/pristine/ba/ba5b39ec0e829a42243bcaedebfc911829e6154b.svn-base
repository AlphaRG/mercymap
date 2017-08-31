//
//  MM_PersonChooseCell.m
//  MercyMap
//
//  Created by RainGu on 17/2/16.
//  Copyright © 2017年 Wispeed. All rights reserved.
//

#import "MM_PersonChooseCell.h"
#import "Masonry.h"
@implementation MM_PersonChooseCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self =[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.pKind];
        [self.contentView addSubview:self.Pexplin];
        [self.contentView setNeedsUpdateConstraints];
    }
    return self;
}

-(void)configData:(id)data{
    self.pKind.text   = data[@"title"];
    self.Pexplin.text = data[@"explain"];
}

-(void)updateConstraints{
    [super updateConstraints];
    [self.pKind mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView).offset(11);
        make.left.mas_equalTo(self.contentView).offset(20);
        make.height.mas_equalTo(22);
    }];
    [self.Pexplin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.pKind.mas_bottom).offset(2);
        make.left.mas_equalTo(self.contentView).offset(20);
        make.height.mas_equalTo(16);
    }];
}

-(UILabel *)pKind{
    if (_pKind ==nil) {
        _pKind = [[UILabel alloc]init];
        _pKind.font = [UIFont systemFontOfSize:17.0];
    }
    return _pKind;
}

-(UILabel *)Pexplin{
    if (_Pexplin ==nil) {
        _Pexplin = [[UILabel alloc]init];
        _Pexplin.font = [UIFont systemFontOfSize:14.0];
        _Pexplin.textColor =[UIColor lightGrayColor];
    }
    return _Pexplin;
}
@end
