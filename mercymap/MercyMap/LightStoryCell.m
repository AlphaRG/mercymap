//
//  LightStoryCell.m
//  MercyMap
//
//  Created by sunshaoxun on 16/9/21.
//  Copyright © 2016年 Wispeed. All rights reserved.
//

#import "LightStoryCell.h"
#import "Masonry.h"
@implementation LightStoryCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self =[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.storyText];
        [self.contentView  addSubview:self.storyName];
        [self setNeedsUpdateConstraints];
    }
    return self;
}
-(void)updateConstraints{
    [super updateConstraints];
     self.storyText.preferredMaxLayoutWidth = kSCREENWIDTH - 85;
    [self.storyName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo (self.contentView).offset(10);
        make.left.mas_equalTo(self.contentView).offset(15);
        make.size.mas_equalTo(CGSizeMake(100, 21));
    }];
    [self.storyText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.storyName.mas_bottom).offset(2);
        make.left.mas_equalTo(self.storyName.mas_left);
        make.right.mas_equalTo(self.contentView).offset(-15);
        make.bottom.mas_equalTo(self.contentView).offset(-10);
    }];
}

-(void)configData:(id)data{
     self.storyText.text = data[@"ShopStory"];
    [self.storyText sizeToFit];
    [self.storyName sizeToFit];
}

-(UILabel *)storyName{
    if (_storyName == nil) {
        _storyName = [[UILabel alloc]init];
        _storyName.text = @"故事简介：";
        _storyName.font =[UIFont systemFontOfSize:17.0];
        _storyName.textAlignment = NSTextAlignmentLeft;
    }
    return _storyName;
}
-(UILabel *)storyText{
    if (_storyText ==nil) {
        _storyText = [[UILabel alloc]init];
        _storyText.numberOfLines = 0;
        _storyText.font = [UIFont systemFontOfSize:14];
    }
    return _storyText;
}
@end
