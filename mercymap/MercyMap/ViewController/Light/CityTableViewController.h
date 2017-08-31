//
//  CityTableViewController.h
//  MercyMap
//
//  Created by sunshaoxun on 16/4/28.
//  Copyright © 2016年 Wispeed. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^ReturnCityBlock)(NSString *Cstr);
@interface CityTableViewController : UITableViewController
@property(nonatomic,assign)int fag;
@property(nonatomic,copy)ReturnCityBlock ReturnBlock;
@end
