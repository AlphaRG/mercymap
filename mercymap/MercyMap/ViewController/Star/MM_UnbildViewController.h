//
//  MM_UnbildViewController.h
//  MercyMap
//
//  Created by RainGu on 17/1/23.
//  Copyright © 2017年 Wispeed. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MM_UnbildViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *codeTextField;
@property (weak, nonatomic) IBOutlet UITextField *mobileTextField;

@property (weak, nonatomic) IBOutlet UIButton *codeBtn;
- (IBAction)codeBtnClick:(id)sender;
- (IBAction)commitBtnClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *commintBtn;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@end
