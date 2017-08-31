//
//  UITableView+Common.m
//  CKCaknow
//
//  Created by zhangshupeng on 16/6/23.
//  Copyright © 2016年 CAKNOW. All rights reserved.
//

#import "UITableView+Common.h"

@implementation UITableView (Common)

- (void)SeparatorLine {
    if ([self respondsToSelector:@selector(setSeparatorInset:)]) {
        [self setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }
    
    if ([self respondsToSelector:@selector(setLayoutMargins:)]) {
        [self setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    }
}

- (void)SeparatorLineNone {
    if ([self respondsToSelector:@selector(setSeparatorInset:)]) {
        [self setSeparatorInset:UIEdgeInsetsMake(0,kSCREENWIDTH,0,0)];
    }
    
    if ([self respondsToSelector:@selector(setLayoutMargins:)]) {
        [self setLayoutMargins:UIEdgeInsetsMake(0,kSCREENWIDTH,0,0)];
    }
}

@end
