//
//  LightBaseInfoCell.m
//  MercyMap
//
//  Created by sunshaoxun on 16/9/21.
//  Copyright © 2016年 Wispeed. All rights reserved.
//

#import "LightBaseInfoCell.h"
#import "Masonry.h"
#import "UIButton+WebCache.h"
@implementation LightBaseInfoCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.headImage];
        [self.contentView addSubview:self.imageN];
        [self.contentView addSubview:self.name];
        [self.contentView addSubview:self.dianzan];
        [self.contentView addSubview:self.dianzanN];
        [self.contentView addSubview:self.comment];
        [self.contentView addSubview:self.commentN];
        [self.contentView addSubview:self.category];        
        [self setNeedsUpdateConstraints];
    }
    return self;
}

-(void)configData:(id)data{
    NSString *str =[NSString stringWithFormat:@"%@img/%@",URLM,data[@"ShopMainImg"]];
    NSString *imgS =[str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    NSURL *URL =[NSURL URLWithString:imgS];
    [self.headImage  sd_setImageWithURL:URL forState:UIControlStateNormal];
    self.name.text = data[@"ShopName"];
    self.dianzanN.text =[NSString stringWithFormat:@"%d",[data[@"LikedCount"]intValue]];
    self.commentN.text  = [NSString stringWithFormat:@"%d",[data[@"CommentCount"]intValue]];
    int cID = [data[@"ShopFlag"] intValue];
    switch (cID) {
        case 1:
             self.category.text = @"小吃";
            break;
       case 2:
            self.category.text = @"甜点";
            break;
        case 3:
            self.category.text = @"主食";
            break;
        case 4:
            self.category.text = @"其他";
            break;
        default:
            break;
    }
}

-(void)updateConstraints{
  [super updateConstraints];
  [self.headImage mas_makeConstraints:^(MASConstraintMaker *make) {
      make.left.mas_equalTo (self.contentView ).offset(15);
      make.top.mas_equalTo(self.contentView).offset(10);
      make.size.mas_equalTo(CGSizeMake(90,70));
  }];
  [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
      make.top.mas_equalTo(self.contentView).offset(10);
      make.height.mas_equalTo(20);
      make.left.mas_equalTo(self.headImage.mas_right).offset(10);
  }];
   [self.dianzan mas_makeConstraints:^(MASConstraintMaker *make) {
       make.top.mas_equalTo(self.name.mas_bottom).offset(10);
       make.left.mas_equalTo(self.headImage.mas_right).offset(10);
       make.size.mas_equalTo(CGSizeMake(20, 20));
   }];
    [self.category mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView).offset(65);
        make.left.mas_equalTo(self.headImage.mas_right).offset(10);
        make.size.mas_equalTo(CGSizeMake(80, 20));
    }];
    [self.dianzanN mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.dianzan.mas_right).offset(10);
        make.centerY.mas_equalTo(self.dianzan.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    [self.comment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.dianzanN.mas_right).offset(10);
        make.centerY.mas_equalTo(self.dianzanN.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    [self.commentN mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.comment.mas_right).offset(10);
        make.centerY.mas_equalTo(self.comment.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    [self.imageN mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.contentView).offset(15);
        make.top.mas_equalTo(self.contentView).offset(45);
        make.height.mas_equalTo(20);
        make.right.mas_equalTo(self.category).offset(15);
    }];
}

- (void)buttonClickAction:(UIButton *)button {
    if ([self.delegate respondsToSelector:@selector(cell:InteractionEvent:)]) {
        [self.delegate cell:self InteractionEvent:@(button.tag)];
    }
}

-(UIButton *)headImage{
    if (_headImage ==nil) {
        _headImage = [[UIButton alloc]init];
        _headImage.clipsToBounds =YES;
        _headImage.tag = 2;
        [_headImage addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _headImage;
}

-(UILabel *)imageN{
    if (_imageN == nil) {
        _imageN = [[UILabel alloc]init];
        _imageN.textColor = [UIColor whiteColor];
        _imageN.backgroundColor = [UIColor colorWithRed:38/255.0 green:34/255.0 blue:45/255.0 alpha:1.0];
        _imageN.textAlignment = NSTextAlignmentCenter;
        _imageN.clipsToBounds = YES;
        _imageN.layer.cornerRadius = 5;
        _imageN.font = [UIFont systemFontOfSize:10];
    }
    return _imageN;
}

-(UILabel *)name{
    if (_name == nil) {
        _name = [[UILabel alloc]init];
        _name.font =[UIFont systemFontOfSize:17];
    }
    return _name;
}

-(UIButton *)dianzan{
    if (_dianzan ==nil) {
        _dianzan  = [UIButton buttonWithType:0];
        _dianzan.tag = 2;
        [_dianzan setImage:[UIImage imageNamed:@"dianzan1.png"] forState:UIControlStateNormal];
    }
    return _dianzan;
}

-(UILabel *)dianzanN{
    if (_dianzanN ==nil) {
        _dianzanN = [[UILabel alloc]init];
        _dianzanN.textColor = [UIColor lightGrayColor];
        _dianzanN.font = [UIFont systemFontOfSize:14];
    }
    return _dianzanN;
}

-(UIButton *)comment{
    if (_comment ==nil) {
        _comment = [UIButton buttonWithType:0];
        _comment.tag = 3;
        [_comment setImage:[UIImage imageNamed:@"comment.png"] forState:UIControlStateNormal];
   }
    return _comment;
}

-(UILabel *)commentN{
    if (_commentN == nil) {
        _commentN = [[UILabel alloc]init];
        _commentN.textColor = [UIColor lightGrayColor];
        _commentN.font = [UIFont systemFontOfSize:14];
    }
    return _commentN;
}

-(UILabel *)category{
    if (_category == nil) {
        _category = [[UILabel alloc]init];
        _category.textColor = [UIColor lightGrayColor];
        _category.font = [UIFont systemFontOfSize:14];
    }
    return _category;
}
@end
