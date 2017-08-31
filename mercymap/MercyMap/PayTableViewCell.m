//
//  PayTableViewCell.m
//  MercyMap
//
//  Created by RainGu on 16/11/25.
//  Copyright © 2016年 Wispeed. All rights reserved.
//

#import "PayTableViewCell.h"

@implementation PayTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.payHeadImage.clipsToBounds  =YES;
    self.payHeadImage.layer.cornerRadius = 40;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
- (IBAction)PayClick:(id)sender {
    if ([self.delegate respondsToSelector:@selector(submitPayInfo)]) {
        [self.delegate submitPayInfo];
    }
}
@end
