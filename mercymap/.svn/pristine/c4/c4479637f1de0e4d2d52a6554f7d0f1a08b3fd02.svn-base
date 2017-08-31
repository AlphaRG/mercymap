//
//  RegViewController.m
//  MercyMap
//
//  Created by sunshaoxun on 16/4/12.
//  Copyright © 2016年 Wispeed. All rights reserved.
//

#import "RegViewController.h"
#import "LoginService.h"
#import "VerificationViewController.h"
#import "ButtonAdd.h"
#import "AppDelegate.h"
#import "PasswordViewController.h"
@interface RegViewController ()<UITextFieldDelegate>
{
    LoginService *loginService;
    ButtonAdd *checklength;
}
@end
@implementation RegViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    checklength = [[ButtonAdd alloc]init];
    self.title =@"填写手机号";
    self.telPhoneTextfile.delegate =self;
    self.NextBtn.layer.masksToBounds =YES;
    self.NextBtn.layer.cornerRadius=10;
    self.NextBtn.backgroundColor=[UIColor colorWithRed:246/250.0 green:246/250.0 blue:246/250.0 alpha:1.0];
    
    loginService = [[LoginService alloc]init];
    [_telPhoneTextfile becomeFirstResponder];
    _telPhoneTextfile.keyboardType =UIKeyboardTypeNumberPad;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"navBackBtn@2x"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(navLeftBtnClick)];
    _NextBtn.backgroundColor =[UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1.0];
    self.NextBtn.layer.masksToBounds =YES;
    self.NextBtn.layer.cornerRadius=10;
}

-(void)navLeftBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)NextClick:(id)sender {
    if (![checklength checkInput:self.telPhoneTextfile.text] ){
        if ([self.telPhoneTextfile.text length]==11) {
            [loginService judegeMoibleExict:self.telPhoneTextfile.text SuccessBlock:^(NSString *success){
              if ([success isEqualToString:@"false"]) {
                  PasswordViewController *passVC = [[PasswordViewController alloc]initWithNibName:@"PasswordViewController" bundle:nil];
                  passVC.telNum = self.telPhoneTextfile.text;
                  [self.navigationController pushViewController:passVC animated:YES];
                }
                else{
                    [CommoneTools alertOnView:self.view content:@"手机已注册"];
                }
            }
            FailuerBlock:^(NSString *error) {
                [CommoneTools alertOnView:self.view content:@"网络有问题"];
         }];
        }
        else{
            [CommoneTools alertOnView:self.view content:@"手机号输入错误"];
        }
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if ([checklength checkInput:string]){
        if([self.telPhoneTextfile.text length]==1){
           _NextBtn.backgroundColor =[UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1.0];
           self.NextBtn.layer.masksToBounds =YES;
           self.NextBtn.layer.cornerRadius=10;
          }
          else{
              self.NextBtn.backgroundColor =[UIColor colorWithRed:34/255.0 green:139/255.0 blue:255/255.0 alpha:1.0];
              self.NextBtn.layer.masksToBounds =YES;
              self.NextBtn.layer.cornerRadius=10;
         }
    }
  else{
       self.NextBtn.backgroundColor =[UIColor colorWithRed:61/255.0 green:185/255.0 blue:253/255.0 alpha:1.0];
        self.NextBtn.layer.masksToBounds =YES;
        self.NextBtn.layer.cornerRadius=10;
    }
    return YES;
}
@end
