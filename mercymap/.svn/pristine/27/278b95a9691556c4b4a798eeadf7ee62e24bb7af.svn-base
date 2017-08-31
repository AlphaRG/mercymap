//
//  MM_2DbarcodePictureCell.m
//  MercyMap
//
//  Created by RainGu on 17/2/17.
//  Copyright © 2017年 Wispeed. All rights reserved.
//

#import "MM_2DbarcodePictureCell.h"
#import "Masonry.h"
@implementation MM_2DbarcodePictureCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor colorWithRed:67/255.0 green:131/255.0 blue:81/255.0 alpha:1.0];
        
        [self.contentView addSubview:self.scanView];
        [self.scanView addSubview:self.scanPicture];
        [self.contentView addSubview:self.wechatView];
        [self.scanView addSubview:self.alipayView];
//        [self.wechatView addSubview:self.wechatpayBtn];
        [self.wechatView addSubview:self.wechatText];
        [self.alipayView addSubview:self.aplipayBtn];
        [self.alipayView addSubview:self.alipayText];
        [self.contentView setNeedsUpdateConstraints];
    }
    return self;
}

-(void)configData:(id)data{
    NSData *data1   = [[NSData alloc] initWithBase64EncodedString:data[0][@"scanImage"] options:NSDataBase64DecodingIgnoreUnknownCharacters];
    self.scanPicture.image  = [UIImage imageWithData:data1];
}

-(void)updateConstraints{
    [super updateConstraints];
    
    [self.scanView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView).offset(15);
        make.left.mas_equalTo(self.contentView).offset(15);
        make.right.mas_equalTo(self.contentView).offset(-15);
        make.height.mas_equalTo(kSCREENWIDTH+60);
    }];
    
    [self.scanPicture mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.scanView).offset(60);
        make.left.mas_equalTo(self.scanView).offset(20);
        make.right.mas_equalTo(self.scanView).offset(-20);
        make.height.mas_equalTo(kSCREENWIDTH);
      }];
    
     [self.wechatView mas_makeConstraints:^(MASConstraintMaker *make) {
         make.top.mas_equalTo(self.scanPicture.mas_bottom).offset(10);
         make.left.mas_equalTo(self.contentView).offset(20);
         make.right.mas_equalTo(self.contentView).offset(-20);
         make.height.mas_equalTo(44);
     }];
    
    [self.alipayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.scanView.mas_top).offset(10);
        make.left.mas_equalTo(self.scanView).offset(15);
        make.right.mas_equalTo(self.scanView).offset(-20);
        make.height.mas_equalTo(44);
    }];
    
    [self.wechatText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.wechatView).offset(7);
        make.center.mas_equalTo(self.wechatView);
        make.size.mas_equalTo(CGSizeMake(200, 30));
    }];
  
    [self.aplipayBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.alipayView).offset(7);
        make.left.mas_equalTo(self.alipayView).offset(15);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    
    [self.alipayText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.alipayView).offset(7);
        make.left.mas_equalTo(self.aplipayBtn.mas_right).offset(5);
        make.size.mas_equalTo(CGSizeMake(200, 30));
    }];

}

-(void)buttonClickAction:(id)btn{
    NSInteger tag;
    if ([btn isKindOfClass:[UIButton class]]) {
        UIButton *Btn = (UIButton *)btn;
        tag = Btn.tag;
    }else{
        UITapGestureRecognizer *tap  =(UITapGestureRecognizer *)btn;
        tag = tap.self.view.tag;
    }
    if ([self.delegate respondsToSelector:@selector(cell:InteractionEvent:)]) {
        [self.delegate cell:self InteractionEvent:@(tag)];
    }
}

-(UIImageView *)scanPicture{
    if (_scanPicture ==nil) {
        _scanPicture = [[UIImageView alloc]init];
    }
    return _scanPicture;
}

-(UIButton *)wechatpayBtn{
    if (_wechatpayBtn == nil) {
        _wechatpayBtn = [UIButton buttonWithType:0];
        _wechatpayBtn.tag =1;
         [_wechatpayBtn addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
        [_wechatpayBtn setImage:[UIImage imageNamed:@"wechat"] forState:UIControlStateNormal];
    }
    return _wechatpayBtn;
}

-(UIButton *)aplipayBtn{
    if (_aplipayBtn == nil) {
        _aplipayBtn = [UIButton buttonWithType:0];
        _aplipayBtn.tag =2 ;
        [_aplipayBtn setImage:[UIImage imageNamed:@"scan"] forState:UIControlStateNormal];
    }
    return _aplipayBtn;
}

-(UIView *)wechatView{
    if (_wechatView == nil) {
        _wechatView = [[UIView alloc]init];
        _wechatView.backgroundColor = [UIColor whiteColor];
        _wechatView.tag = 3;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(buttonClickAction:)];
        [_wechatView addGestureRecognizer:tap];
        _wechatView.layer.masksToBounds =YES;
        _wechatView.layer.cornerRadius = 10 ;
    }
    return _wechatView;
}

-(UIView *)alipayView{
    if (_alipayView == nil) {
        _alipayView = [[UIView alloc]init];
        _alipayView.backgroundColor = [UIColor whiteColor];
        _alipayView.tag = 4;
//         UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(buttonClickAction:)];
//        [_alipayView addGestureRecognizer:tap];
        _alipayView.layer.masksToBounds = YES;
        _alipayView.layer.cornerRadius = 10;
    }
    return _alipayView;
}

-(UILabel *)wechatText{
    if (_wechatText == nil) {
        _wechatText = [[UILabel alloc]init];
        _wechatText.font = [UIFont systemFontOfSize:14.0];
        _wechatText.textAlignment = NSTextAlignmentCenter;
        _wechatText.text =@"收款方式选择";
    }
    return _wechatText;
}

-(UILabel *)alipayText{
    if (_alipayText == nil) {
        _alipayText = [[UILabel alloc]init];
        _alipayText.font = [UIFont systemFontOfSize:14.0];
        _alipayText.textAlignment = NSTextAlignmentLeft;
        _alipayText.textColor = [UIColor colorWithRed:67/255.0 green:131/255.0 blue:81/255.0 alpha:1.0];
        _alipayText.text = @"向用户收款";
    }
    return _alipayText;
}

-(UIView *)scanView{
    if (_scanView == nil) {
        _scanView = [[UIView alloc]init];
        _scanView.backgroundColor = [UIColor whiteColor];
        _scanView.layer.masksToBounds = YES;
        _scanView.layer.cornerRadius  = 10;
    }
    return _scanView;
}
@end
