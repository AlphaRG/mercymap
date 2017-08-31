//
//  LightListSecondTableViewCell.m
//  MercyMap
//
//  Created by sunshaoxun on 16/4/26.
//  Copyright © 2016年 Wispeed. All rights reserved.
//

#import "LightListSecondTableViewCell.h"

@implementation LightListSecondTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.HeadBtn.layer.cornerRadius = 20;
    self.HeadBtn.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:NO  animated:NO];
}

@end
