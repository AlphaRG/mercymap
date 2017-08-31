//
//  LightKindTableViewCell.m
//  MercyMap
//
//  Created by sunshaoxun on 16/4/8.
//  Copyright © 2016年 Wispeed. All rights reserved.
//

#import "LightKindTableViewCell.h"
#import "LightKindTableViewController.h"
@implementation LightKindTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:NO animated:NO];

    // Configure the view for the selected state
}

- (IBAction)foodBtnClick:(id)sender {
    if ([self.delegate respondsToSelector:@selector(sendFag:)]) {
        int fag =2;
        [self.delegate sendFag:fag];
    }
}

- (IBAction)snackBtnClick:(id)sender {
    if ( [self.delegate respondsToSelector:@selector(sendFag:)]) {
        int fag =3;
        [self.delegate sendFag: fag];
    }
}

- (IBAction)dessertBtnClick:(id)sender {
    if ( [self.delegate respondsToSelector:@selector(sendFag:)]) {
        int fag =1;
        [self.delegate sendFag: fag];
    }
}

- (IBAction)otherBtnClick:(id)sender {
    if ( [self.delegate respondsToSelector:@selector(sendFag:)]) {
        int fag =4;
        [self.delegate sendFag: fag];
    }
}
@end
