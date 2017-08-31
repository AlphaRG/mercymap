//
//  PayTableViewCell.h
//  MercyMap
//
//  Created by RainGu on 16/11/25.
//  Copyright © 2016年 Wispeed. All rights reserved.
//

#import "ZZBaseTableViewCell.h"
@protocol submitPayInfoDelegate <NSObject>
-(void)submitPayInfo;
@end
@interface PayTableViewCell : UITableViewCell
@property(nonatomic,strong)UIButton *wechatImag;
@property(nonatomic,strong)UIButton *alipayImg;
@property(nonatomic,weak) id <submitPayInfoDelegate> delegate;
- (IBAction)PayClick:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *payHeadName;
@property (weak, nonatomic) IBOutlet UITextField *payNum;
@property (weak, nonatomic) IBOutlet UIButton *payWayalipay;
@property (weak, nonatomic) IBOutlet UIButton *payBtn;
@property (weak, nonatomic) IBOutlet UIImageView *payHeadImage;
@property (weak, nonatomic) IBOutlet UIView *wechatView;
@property (weak, nonatomic) IBOutlet UIView *alipayView;
@property (weak, nonatomic) IBOutlet UIButton *unionpayway;
@property (weak, nonatomic) IBOutlet UIView *unionpayView;
@property (weak, nonatomic) IBOutlet UIButton *payWay;



@end
