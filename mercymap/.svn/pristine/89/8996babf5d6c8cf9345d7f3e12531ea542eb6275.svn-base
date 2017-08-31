//
//  UITableView+RegiesterCell.m
//  MercyMap
//
//  Created by zhangshupeng on 16/7/5.
//  Copyright © 2016年 Wispeed. All rights reserved.
//

#import "UITableView+RegiesterCell.h"

@implementation UITableView (RegiesterCell)

- (void)registerClass:(NSArray *)cls {
    for (NSString *cell in cls) {
        [self registerClass:NSClassFromString(cell) forCellReuseIdentifier:cell];
    }
}
- (void)registerNib:(NSArray *)nibs {
    for (NSString *cell in nibs) {
        [self registerNib:[UINib nibWithNibName:cell bundle:nil] forCellReuseIdentifier:cell];
    }
}




@end
