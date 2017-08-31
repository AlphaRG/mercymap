//
//  MM_UnbildViewController.m
//  MercyMap
//
//  Created by RainGu on 17/1/23.
//  Copyright © 2017年 Wispeed. All rights reserved.
//

#import "MM_UnbildViewController.h"
#import <SMS_SDK/SMSSDK.h>
#import "ButtonAdd.h"
#import "LoginService.h"
#import "Single.h"
@interface MM_UnbildViewController ()<UITextFieldDelegate,UIAlertViewDelegate>
{
    NSTimer *time;
    int i;
    ButtonAdd    *_checkTextFiled ;
    LoginService *_services;
    Single       *_single;
}
@end

@implementation MM_UnbildViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    i = 60;
    _checkTextFiled = [[ButtonAdd alloc]init];
    _services       = [[LoginService alloc]init];
    _single         = [Single Send];
    self.commintBtn.layer.masksToBounds = YES;
    self.commintBtn.layer.cornerRadius  = 10;
    
    self.title = @"绑定与解绑";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"navBackBtn@2x"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ]style:UIBarButtonItemStylePlain target:self action:@selector(navleftBtnClick)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


-(void)navleftBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)changeTime{
    if (i==0){
        i=60;
        [time invalidate];
        self.codeBtn.enabled = YES;
        self.codeBtn.titleLabel.text =[NSString stringWithFormat:@"重新发送"];
        [self.codeBtn setTitleColor:[UIColor colorWithRed:77/250.0 green:142/250.0 blue:249/250.0 alpha:1.0]forState:UIControlStateNormal];
    }
    else{
        i--;
        [self.codeBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        self.codeBtn.titleLabel.text =[NSString stringWithFormat:@"重新发送(%d)",i];
        if (i==0){
            [self.codeBtn setTitle:[NSString stringWithFormat:@"重新发送"] forState:UIControlStateNormal];
        }
        else{
            [self.codeBtn setTitle:[NSString stringWithFormat:@"重新发送(%d)",i] forState:UIControlStateNormal];
        }
    }
}


- (IBAction)codeBtnClick:(id)sender {
    if ([_checkTextFiled checkInput:self.mobileTextField.text]) {
        [CommoneTools alertOnView:self.view content:@"请填写完整"];
    }else{
        
    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:self.mobileTextField.text zone: @"86" customIdentifier: nil result:^(NSError *error){
        if (!error) {
            self.codeBtn.enabled = NO;
            time = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(changeTime) userInfo:nil repeats:YES];
        }
        else{
            [CommoneTools alertOnView:self.view content:@"发送失败"];
        }
    }];
    }
}

- (IBAction)commitBtnClick:(id)sender {
    if ([_checkTextFiled checkInput:self.mobileTextField.text]||[_checkTextFiled checkInput:self.passwordTextField.text ]||[_checkTextFiled checkInput:self.codeTextField.text]) {
        [CommoneTools alertOnView:self.view content:@"请填写完整"];
    }else{
        NSString *url = [NSString stringWithFormat:@"%@api/Bind/BindMobileNum",USERURL];
        NSNumber *uid = [NSNumber numberWithInt:_single.ID];
        NSDictionary *dic = @{
                              @"MobileNum":self.mobileTextField.text,
                              @"Zon":@"86",
                              @"Password":self.passwordTextField.text,
                              @"Code":self.codeTextField.text,
                              @"Token":_single.Token,
                              @"UID":uid,
                              @"FormPlatform":@100,
                              @"ClientType":@10
                              };
        
    [_services getDicData:url Dic:dic Title:nil SuccessBlock:^(NSMutableDictionary *dic) {
        if ([dic[@"Flag"]isEqualToString:@"S"]) {
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [self alterViewContrllerBind:dic];
        }
    } FailuerBlock:^(NSString *str) {
        
    }];
     }
}

-(void)alterViewContrllerBind:(NSDictionary *)dic{
    UIAlertView *okView = [[UIAlertView alloc]initWithTitle:@"是否解绑" message:@"该账号已经被绑定是否解绑" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [okView show];
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:
            [self.navigationController popViewControllerAnimated:YES];
            break;
        case 1:
            [self unbindTird];
            break;
        default:
            break;
    }
}

-(void)unbindTird{
    NSString *url = [NSString stringWithFormat:@"%@api/Bind/UnBindMobileNum",USERURL];
    NSNumber *uid = [NSNumber numberWithInt:_single.ID];
    NSDictionary *dic = @{
             @"MobileNum":self.mobileTextField.text,
             @"Zon":@"86",
             @"Code":self.codeTextField.text,
             @"Token":_single.Token,
             @"UID":uid,
             @"FormPlatform":@100,
             @"ClientType":@10
             };
    [_services getDicData:url Dic:dic Title:nil SuccessBlock:^(NSMutableDictionary *dic) {
        if ([dic[@"Flag"] isEqualToString:@"S"]) {
            [CommoneTools alertOnView:self.view content:@"解绑成功"];
        }else if ([dic[@"Flag"] isEqualToString:@"F"]){
            [CommoneTools alertOnView:self.view content:@"解绑失败"];
      }
    } FailuerBlock:^(NSString *str) {
        
    }];
}
@end
