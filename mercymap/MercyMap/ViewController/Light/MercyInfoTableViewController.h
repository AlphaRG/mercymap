//
//  MercyInfoTableViewController.h
//  MercyMap
//
//  Created by sunshaoxun on 16/7/4.
//  Copyright © 2016年 Wispeed. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MercyInfoTableViewController : UITableViewController
@property(nonatomic,assign)int Mfag;
-(void)getMercyInfo:(int)fag;
@end
