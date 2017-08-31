//
//  TabBarView.m
//  MercyMap
//
//  Created by sunshaoxun on 16/9/26.
//  Copyright © 2016年 Wispeed. All rights reserved.
//

#import "TabBarView.h"

@implementation TabBarView

- (IBAction)dianzanClick:(id)sender {
    
    if ([self.delegate respondsToSelector:@selector(tabBarBtnClick:)]) {
        [self.delegate tabBarBtnClick:@(_dianzanBtn.tag)];
        }
}

- (IBAction)signinClick:(id)sender {
    if ([self.delegate respondsToSelector:@selector(tabBarBtnClick:)]) {
        [self.delegate tabBarBtnClick:@(_signinBtn.tag)];
    }
}

- (IBAction)commentClick:(id)sender {
    if ([self.delegate respondsToSelector:@selector(tabBarBtnClick:)]) {
        [self.delegate tabBarBtnClick:@(_commentBtn.tag)];
    }
}

- (IBAction)uploadClick:(id)sender {
    if ([self.delegate respondsToSelector:@selector(tabBarBtnClick:)]) {
        [self.delegate tabBarBtnClick:@(_uploadBtn.tag)];
    }
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self =[super initWithFrame:frame]) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"TabBarView" owner:self options:nil] firstObject];
        self.frame =frame;
    }
    return self;
}
@end
