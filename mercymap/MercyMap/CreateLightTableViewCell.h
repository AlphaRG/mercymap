//
//  CreateLightTableViewCell.h
//  MercyMap
//
//  Created by sunshaoxun on 16/8/24.
//  Copyright © 2016年 Wispeed. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol LocationDelegate <NSObject>
-(void)sendLocationView;
@end

@interface CreateLightTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lightInfoName;
@property (weak, nonatomic) IBOutlet UILabel *vertical;
@property (weak, nonatomic) IBOutlet UIButton *locationBtn;
@property (weak, nonatomic) IBOutlet UITextField *lightInfoTextfield;
- (IBAction)locationBtnClick:(id)sender;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lightInfoTextfieldTrailing;
-(void)createCell:(NSString *)cellname tag:(int)tag;

@property(nonatomic,weak)id<LocationDelegate>delegate;
@end
