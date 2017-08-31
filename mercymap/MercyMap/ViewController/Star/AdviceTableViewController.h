//
//  AdviceTableViewController.h
//  MercyMap
//
//  Created by sunshaoxun on 16/8/19.
//  Copyright © 2016年 Wispeed. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>
@interface AdviceTableViewController : UITableViewController
@property(nonatomic,strong)NSMutableArray *lightImgs;
@property(nonatomic,strong)NSMutableArray<PHAsset *>*dataImgs;

@end
