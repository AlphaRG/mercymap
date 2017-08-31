//
//  MM_BusinessTableViewCell.m
//  MercyMap
//
//  Created by RainGu on 17/2/21.
//  Copyright © 2017年 Wispeed. All rights reserved.
//

#import "MM_BusinessTableViewCell.h"
#import "Masonry.h"
@implementation MM_BusinessTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.usernameTextField];
        [self.contentView setNeedsUpdateConstraints];
    }
    return self;
}

-(void)updateConstraints{
    [super updateConstraints];
    [self.usernameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top .mas_equalTo(self.contentView).offset(44);
        make.left.mas_equalTo(self.contentView).offset(20);
        make.right.mas_equalTo(self.contentView).offset(-20);
        make.size.mas_equalTo(CGSizeMake(180, 44));
    }];
}

-(UITextField *)usernameTextField{
    if (_usernameTextField == nil) {
        _usernameTextField  = [[UITextField alloc]init];
        _usernameTextField.font = [UIFont systemFontOfSize:17.0];
        _usernameTextField.borderStyle = UITextBorderStyleRoundedRect;
        _usernameTextField.placeholder = @"请输入下一个管理者的用户名";
    }
    return _usernameTextField;
}
@end
