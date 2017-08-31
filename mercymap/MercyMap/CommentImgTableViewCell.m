//
//  CommentImgTableViewCell.m
//  MercyMap
//
//  Created by RainGu on 16/11/23.
//  Copyright © 2016年 Wispeed. All rights reserved.
//
#import "CommentImgTableViewCell.h"
#import "Masonry.h"
#define IMAGEWIDTH (kSCREENWIDTH-40-15)/4

@implementation CommentImgTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self.contentView addSubview:self.CimageBtn];
        [self.contentView addSubview:self.signalLable];
        [self.contentView setNeedsUpdateConstraints];
    }
    return self;
}

-(void)configData:(id)data{

}

-(void)updateConstraints{
    [super updateConstraints];
    [self.CimageBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView).offset(20);
        make.left.mas_equalTo(self.contentView).offset(20);
        make.size.mas_equalTo(CGSizeMake(IMAGEWIDTH, IMAGEWIDTH));
    }];
    [self.signalLable mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.CimageBtn.mas_centerY);
        make.left.mas_equalTo (self.CimageBtn.mas_right).offset(10);
        make.height.mas_equalTo(20);
    }];
}
-(void)buttonClick:(UIButton *)btn{
    if ([self.delegate respondsToSelector:@selector(cell:InteractionEvent:)]) {
        [self.delegate cell:self InteractionEvent:@(btn.tag)];
    }
}

-(UIButton *)CimageBtn{
    if (_CimageBtn == nil) {
        _CimageBtn = [[UIButton alloc]init];
        _CimageBtn.tag = 1;
        [_CimageBtn setBackgroundImage:[UIImage imageNamed:@"create_addImage.jpg"] forState:UIControlStateNormal];
        [_CimageBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _CimageBtn;
}

-(UILabel  *)signalLable{
    if (_signalLable == nil) {
        _signalLable = [[UILabel alloc]init];
        _signalLable.font = [UIFont systemFontOfSize:14.0];
        _signalLable.textColor = [UIColor lightGrayColor];
        _signalLable.text =@"上传图片(可选)";
    }
    return _signalLable;
}
@end
