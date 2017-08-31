//
//  StarTableViewCell.m
//  MercyMap
//
//  Created by sunshaoxun on 16/4/12.
//  Copyright © 2016年 Wispeed. All rights reserved.
//

#import "StarTableViewCell.h"

@implementation StarTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.headImageView.clipsToBounds  =YES;
    self.headImageView.layer.cornerRadius = 30;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
