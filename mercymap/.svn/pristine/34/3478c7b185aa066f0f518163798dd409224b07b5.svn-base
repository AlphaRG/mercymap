//
//  ThirdAccountRegisterTableViewCell.m
//  MercyMap
//
//  Created by RainGu on 17/1/4.
//  Copyright © 2017年 Wispeed. All rights reserved.
//

#import "ThirdAccountRegisterTableViewCell.h"
#import "Masonry.h"
@implementation ThirdAccountRegisterTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        [self.contentView addSubview:self.thirdImage];
        [self.contentView addSubview:self.thirdName];
        [self.contentView addSubview:self.noOryes];
        [self.contentView setNeedsUpdateConstraints];
    }
    return self;
}

-(void)updateConstraints{
    [super updateConstraints];
    [self.thirdImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView).offset(10);
        make.left.mas_equalTo(self.contentView).offset(20);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    [self.thirdName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo (self.contentView).offset(10);
        make.size.mas_equalTo(CGSizeMake(100, 20));
        make.left.mas_equalTo(self.thirdImage).offset(40);
    }];
    [self.noOryes mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView).offset(10);
        make.size.mas_equalTo(CGSizeMake(80, 20));
        make.right.mas_equalTo(self.contentView).offset(-10);
    }];
}

-(void)setdatainfo:(id)data{
    for (NSDictionary *dic in self.bindlistArray) {
        NSString *bindlistS = [NSString stringWithFormat:@"%@",dic[@"BindType"]];
        if ([bindlistS isEqualToString:data[@"BindType"]]) {
           self.noOryes.text               =@"绑定";
           self.noOryes.textColor = [UIColor grayColor];
         }
    }
   [self.thirdImage setImage:[UIImage imageNamed:data[@"image"]] forState:UIControlStateNormal];
   self.thirdName.text             = data[@"name"];
}
-(void)setpaydata:(id)data{
    if (_bindDic.count == 0) {
    }else{
    if ([data[@"tag"] intValue]==0) {
        if (![_bindDic[@"weixinPayer"]isKindOfClass:[NSNull class]]) {
            if ([_bindDic[@"weixinPayer"] rangeOfString:@"HTTP"].length>0) {
                self.noOryes.text               =@"绑定";
                self.noOryes.textColor = [UIColor grayColor];
            }
        }
    }else{
        if (![_bindDic[@"alipayer"]isKindOfClass:[NSNull class]]) {
            if ([_bindDic[@"alipayer"] rangeOfString:@"HTTP"].length>0) {
                self.noOryes.text               =@"绑定";
                self.noOryes.textColor = [UIColor grayColor];
            }
          }
       }
    }
    [self.thirdImage setImage:[UIImage imageNamed:data[@"image"]] forState:UIControlStateNormal];
    self.thirdName.text             = data[@"name"];
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

-(UIButton *)thirdImage{
    if (_thirdImage==nil) {
        _thirdImage = [UIButton buttonWithType:0];
    }
    return _thirdImage;
}

-(UILabel *)thirdName{
    if (_thirdName==nil) {
        _thirdName = [[UILabel alloc]init];
        _thirdName.font = [UIFont systemFontOfSize:14];
    }
    return _thirdName;
}

-(UILabel *)noOryes{
    if (_noOryes==nil) {
        _noOryes = [[UILabel alloc]init];
        _noOryes.textColor = [UIColor colorWithRed:0.0 green:0.0 blue:1.0 alpha:0.6];
        _noOryes.textAlignment = NSTextAlignmentRight;
        _noOryes.font = [UIFont systemFontOfSize:14];
        _noOryes.text = @"未绑定";
    }
    return _noOryes;
}
@end
