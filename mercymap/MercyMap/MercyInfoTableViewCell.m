//
//  MercyInfoTableViewCell.m
//  MercyMap
//
//  Created by sunshaoxun on 16/7/4.
//  Copyright © 2016年 Wispeed. All rights reserved.
//

#import "MercyInfoTableViewCell.h"

@implementation MercyInfoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:NO  animated:NO];

    // Configure the view for the selected state
}

-(void)setcontentLable:(NSMutableArray *)dataArray
{
    self.mercyInfoLable.text = [NSString stringWithFormat:@"%@",dataArray[0]];
}
@end
