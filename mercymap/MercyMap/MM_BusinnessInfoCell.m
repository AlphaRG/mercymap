//
//  MM_BusinnessInfoCell.m
//  MercyMap
//
//  Created by RainGu on 17/3/7.
//  Copyright © 2017年 Wispeed. All rights reserved.
//

#import "MM_BusinnessInfoCell.h"
#import "Masonry.h"
#import "UIButton+WebCache.h"
@implementation MM_BusinnessInfoCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        [self.contentView addSubview:self.headBtn];
        [self.contentView addSubview:self.shopname];
        [self.contentView setNeedsUpdateConstraints];
    }
    return self;
}

-(void)configData:(id)data{
    NSString *str =[NSString stringWithFormat:@"%@",data[@"ShopHeadImg"]];
    NSString *Imgstr =[str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    NSURL *imageUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@img/%@",URLM,Imgstr]];
    [self.headBtn sd_setBackgroundImageWithURL:imageUrl forState:UIControlStateNormal];
    self.shopname.text =data[@"ShopName"];
}

-(void)updateConstraints{
    [super updateConstraints];
    [self.headBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).offset(20);
        make.top.mas_equalTo(self.contentView).offset(5);
        make.size.mas_equalTo(CGSizeMake(37, 37));
    }];
    [self.shopname mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView).offset(5);
        make.left.mas_equalTo(self.headBtn.mas_right).offset(15);
        make.height.mas_equalTo(37);
    }];
}

-(UIButton *)headBtn{
    if (_headBtn ==nil) {
        _headBtn = [UIButton buttonWithType:0];
        _headBtn.layer.masksToBounds = YES;
        _headBtn.layer.cornerRadius  = 15;
    }
    return _headBtn;
}

-(UILabel *)shopname{
    if (_shopname == nil) {
        _shopname = [[UILabel alloc]init];
        _shopname.font = [UIFont systemFontOfSize:14.0];
    }
    return _shopname;
}
 
@end
