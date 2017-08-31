//
//  UIViewController+SectionHeader.m
//  CKCaknow
//
//  Created by zhangshupeng on 16/6/24.
//  Copyright © 2016年 CAKNOW. All rights reserved.
//

#import "UIViewController+SectionHeader.h"

@implementation UIViewController (SectionHeader)

-  (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat sectionHeaderHeight = 30;
    if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    }
    else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    }
}

@end
