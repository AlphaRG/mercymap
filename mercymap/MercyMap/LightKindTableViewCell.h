//
//  LightKindTableViewCell.h
//  MercyMap
//
//  Created by sunshaoxun on 16/4/8.
//  Copyright © 2016年 Wispeed. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol sendDelegate <NSObject>
-(void)sendFag:(int)fag1;
@end

@interface LightKindTableViewCell : UITableViewCell
@property (nonatomic , assign) id<sendDelegate>delegate;
- (IBAction)foodBtnClick:(id)sender;
- (IBAction)snackBtnClick:(id)sender;
- (IBAction)dessertBtnClick:(id)sender;
- (IBAction)otherBtnClick:(id)sender;

@end
