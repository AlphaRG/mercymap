//
//  UIViewController+TableViewCellSepratorLine.m
//  licaiApp
//
//  Created by zhangshupeng on 16/6/23.
//  Copyright © 2016年 CAKNOW. All rights reserved.
//

#import "UIViewController+TableViewCellSepratorLine.h"

const NSString *edgeName;

@implementation UIViewController (TableViewCellSepratorLine)

- (void)setEdge:(Edge)edge{
    objc_setAssociatedObject(self, &edgeName, edge, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (Edge)edge{
   return objc_getAssociatedObject(self, &edgeName);
}


-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIEdgeInsets edge ;
    if (self.edge) {
        edge = self.edge(indexPath);
    }else
    {
        return;
    }
    
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:edge];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:edge];
    }
}

@end
