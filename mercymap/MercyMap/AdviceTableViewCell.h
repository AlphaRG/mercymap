//
//  AdviceTableViewCell.h
//  MercyMap
//
//  Created by sunshaoxun on 16/8/19.
//  Copyright © 2016年 Wispeed. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol sendInfoDelegate <NSObject>
-(void)sendInfo:(int)fag;
@end

@interface AdviceTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *textViewCount;
@property (weak, nonatomic) IBOutlet UITextView *textViewContent;
@property (weak, nonatomic) IBOutlet UILabel *textViewPacehoder;
@property (weak, nonatomic) IBOutlet UILabel *pictureCount;
- (IBAction)addimageBtnClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *addimageBtn;
@property (weak, nonatomic) IBOutlet UITextField *telephoneNumber;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftConstraint;
- (IBAction)CommitBtnClick:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *pictureView;
@property (weak, nonatomic) IBOutlet UILabel *questiontitle;
@property (weak, nonatomic) IBOutlet UIView *phoneView;
@property (weak, nonatomic) IBOutlet UILabel *phonetitle;
@property(nonatomic,weak)id <sendInfoDelegate> delegate;
@end
