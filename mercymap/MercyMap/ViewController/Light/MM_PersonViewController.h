//
//  MM_PersonViewController.h
//  MercyMap
//
//  Created by RainGu on 17/2/16.
//  Copyright © 2017年 Wispeed. All rights reserved.
//

#import "ZZTableViewController.h"

@interface MM_PersonViewController : ZZTableViewController
@property (nonatomic, retain) NSIndexPath *selectedIndexPath;
@property (nonatomic, copy) void(^sendPersontag)(NSInteger tag);
@end
