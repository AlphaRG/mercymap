//
//  WalkTextTableViewCell.m
//  MercyMap
//
//  Created by sunshaoxun on 16/9/16.
//  Copyright © 2016年 Wispeed. All rights reserved.
//

#import "WalkTextTableViewCell.h"
#import "Masonry.h"
#import "UIButton+WebCache.h"
@implementation WalkTextTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.cellView addSubview: self.head];
        [self.cellView addSubview:self.name];
        [self.cellView addSubview:self.time];
        [self.cellView addSubview:self.number];
        [self.cellView addSubview:self.ligtenImg];
        [self.cellView addSubview:self.ligtenNum];
        [self.contentView addSubview:self.cellView];
        [self setNeedsUpdateConstraints];
    }
    return self;
}

-(void)updateConstraints{
    [super updateConstraints];
    [self.cellView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).offset(0);
        make.right.mas_equalTo(self.contentView).offset(0);
        make.top.mas_equalTo(self.contentView).offset(0);
        make.bottom.mas_equalTo(self.contentView).offset(0);
    }];
    [self.number mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.cellView).offset(15);
        make.size.mas_equalTo(CGSizeMake(30, 30));
        make.top.mas_equalTo(self.cellView).offset(20);
    }];
    [self.head mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 40));
        make.left.mas_equalTo(self.number.mas_right).offset(5);
        make.centerY.mas_equalTo(self.number.mas_centerY);
    }];
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.head.mas_centerY);
        make.left.mas_equalTo(self.head.mas_right).offset(10);
        make.height.mas_equalTo(30);
    }];
    [self.ligtenNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.cellView).offset(-20);
        make.height.mas_equalTo(20);
        make.top .mas_equalTo(self.cellView).offset(15);
    }];
    [self.ligtenImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.ligtenNum.mas_centerX);
        make.top.mas_equalTo(self.ligtenNum.mas_bottom).offset(5);
        make.size.mas_equalTo(CGSizeMake(20,20));
    }];
    [self.time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.ligtenImg.mas_left).offset(-5);
        make.centerY.mas_equalTo(self.ligtenImg.mas_centerY);
        make.height.mas_equalTo(40);
        
    }];
}

-(void)configData:(id)data{
    NSString *imagestr = [NSString stringWithFormat:@"%@uploadfiles/%@",URLM,data[@"ShopHeadImg"]];
    NSString *Imgstr =[imagestr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    NSURL *url = [NSURL URLWithString:Imgstr];
    [_head sd_setImageWithURL:url forState:UIControlStateNormal];
    _name.text = data[@"ShopName"];
    _time.text = data[@"LastSignInTime"];
    _ligtenNum.text = [NSString stringWithFormat:@"%d",[data[@"SignInCount"] intValue]];
}

-(UIButton *)head{
    if (_head==nil) {
        _head = [[UIButton alloc]init];
        _head = [UIButton buttonWithType:0];
        _head.clipsToBounds = YES;
        _head.layer.cornerRadius = 20;
        _head.backgroundColor = [UIColor redColor];
    }
    return _head;
}

-(UILabel *)time{
    if (_time==nil) {
        _time = [[UILabel alloc]init];
        _time.font = [UIFont systemFontOfSize:9.0];
        _time.text =@"2016-09-20 9:45";
        _time.textColor = [UIColor colorWithRed:25/255.0 green:187/255.0 blue:27/255.0 alpha:1.0];
    }
    return  _time;
}

-(UILabel *)number{
    if (_number ==nil) {
        _number = [[UILabel alloc]init];
        _number.font = [UIFont systemFontOfSize:14.0];
        _number.text =@"1";
        _number.textAlignment = NSTextAlignmentCenter;
    }
    return _number;
}

-(UILabel*)name{
    if (_name ==nil) {
        _name = [[UILabel alloc]init];
        _name.font = [UIFont systemFontOfSize:14];
        _name.text =@"234567890";
    }
    return _name;
}
-(UIView *)cellView{
    if (_cellView == nil) {
        _cellView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kSCREENWIDTH, 70)];
        _cellView.backgroundColor = [UIColor whiteColor];
    }
    return _cellView;
}
-(UILabel *)ligtenNum{
    if (_ligtenNum == nil) {
        _ligtenNum = [[UILabel alloc]init];
        _ligtenNum.font = [UIFont systemFontOfSize:12];
        _ligtenNum.textColor = [UIColor grayColor];
        _ligtenNum.text =@"12345";
        _ligtenNum.textAlignment = NSTextAlignmentRight;
    }
    return _ligtenNum;
}
-(UIButton *)ligtenImg{
    if (_ligtenImg ==nil) {
        _ligtenImg =[[UIButton alloc]init];
        [_ligtenImg setImage:[UIImage imageNamed:@"heart.png"] forState:UIControlStateNormal];
    }
    return  _ligtenImg;
}
@end
