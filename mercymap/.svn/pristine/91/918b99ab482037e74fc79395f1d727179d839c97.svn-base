//  LogViewController.m
//  MercyMap
//  Created by sunshaoxun on 16/4/12.
//  Copyright © 2016年 Wispeed. All rights reserved.
#import "LogViewController.h"
#import "AppDelegate.h"
#import "ButtonAdd.h"
#import "RegViewController.h"
#import "LoginService.h"
#import "PasswordViewController.h"
#import "Single.h"
#import "NSUserDefautSet.h"
#import <UMSocialCore/UMSocialCore.h>
@interface LogViewController (){
    LoginService *loginServic;
    Single *sing;
    NSUserDefautSet *defaultSet;
    AppDelegate *app;
    UIImage * _imagcode;
    NSString    *guidString;
}
@end
@implementation LogViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"登录";
//  self.userImageView.layer.cornerRadius =self.userImageView.frame.size.height/2;
    self.userImageView.layer.cornerRadius =10;
    self.userImageView.clipsToBounds = YES;
    self.userImageView.layer.masksToBounds =YES;
    
    self.regBtn1.layer.masksToBounds =YES;
    self.regBtn1.layer.cornerRadius =YES;
    self.regBtn1.layer.cornerRadius =10;
    
    loginServic = [[LoginService alloc]init];
    defaultSet = [[NSUserDefautSet alloc]init];
    sing = [Single Send];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"navBackBtn@2x"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(navLeftBtnClick)];
     _weixinBtn.hidden = YES;
     _forgetpassWord.hidden = YES;
        [self getImageCode];
}

-(void)navLeftBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)logClick:(id)sender {
    ButtonAdd *length = [[ButtonAdd alloc]init];
    if ([length checkInput:self.telePhoneNumber.text]||[length checkInput:self.passwordText.text]||[length checkInput:self.codeTextFiled.text]) {
         [CommoneTools alertOnView:self.view content:@"请填写完整"];
    }
    else{
          NSDictionary *IVerifyCode = @{
                                      @"TUidOrMail":guidString,
                                      @"ActionPage":@"loginPage",
                                      @"Code":self.codeTextFiled.text
                                      };
       NSString     *url = [NSString stringWithFormat:@"%@%@",USERURL,@"api/Account/MemberMobileLogin"];
       NSDictionary *dic =@{@"mobileNum":self.telePhoneNumber.text,
                            @"password":self.passwordText.text,
                            @"IVerifyCode":IVerifyCode };
       [self loginuser:url dic:dic title:@"Members"];
     }
}

- (IBAction)forgetPasswordBtn:(id)sender {
}

- (IBAction)regBtn:(id)sender {
    RegViewController *RegVC = [[RegViewController alloc]initWithNibName:@"RegViewController" bundle:nil];
    [self.navigationController pushViewController:RegVC animated:YES];
}

- (IBAction)QQLog:(id)sender {
    UMSocialPlatformType platformType = UMSocialPlatformType_Sina;
    [self sendUMeng:platformType ];
}

- (IBAction)weiboLog:(id)sender {
    UMSocialPlatformType platformType = UMSocialPlatformType_WechatSession;
    [self sendUMeng:platformType ];
}

- (IBAction)weixinlog:(id)sender{
    UMSocialPlatformType platformType = UMSocialPlatformType_Linkedin;
    [self sendUMeng:platformType ];
}

-(void)sendUMeng:(UMSocialPlatformType)PlatformType{
    [[UMSocialManager defaultManager] authWithPlatform:PlatformType currentViewController:self completion:^(id result, NSError *error) {
    UMSocialResponse *response = result;

        NSString *message = nil;
        if (error) {
            message = @"登录失败";
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"登录失败"
                                                            message:message
                                                           delegate:nil
                                                  cancelButtonTitle:NSLocalizedString(@"确定",nil)
                                                  otherButtonTitles:nil];
            [alert show];
        }else{
//            [[UMSocialManager defaultManager]cancelAuthWithPlatform:PlatformType completion:^(id result, NSError *error) {
//            }];
            NSString     *url ;
            NSDictionary *dic ;
            switch (PlatformType) {
                case 0:
                    url = [NSString stringWithFormat:@"%@%@",USERURL,@"api/Account/MemberWeiboLogin"];
                    dic = @{
                            @"uid":response.uid,
                            @"access_token":response.accessToken
                            };
                    [self loginuser:url dic:dic title:@"Members"];
                break;
                    
                case 1:
                    url = [NSString stringWithFormat:@"%@%@",USERURL,@"api/Account/MemberWeixinLogin"];
                    dic = @{
                            @"openid":response.openid,
                            @"access_token":response.accessToken
                            };
                   [self loginuser:url dic:dic  title:@"Members"];
                break;
                    
                default:
                    break;

            }
          }
    }];
}

-(void)loginuser:(NSString *)url dic:(NSDictionary *)dic title:(NSString *)title{
    [loginServic login:url dic:dic code:self.codeTextFiled.text title:title successBlock:^(NSMutableDictionary *dic) {
        if ([dic[@"Flag"] isEqualToString:@"S"]) {
            sing.ID = [dic[@"UserID"] intValue];
            sing.Token =dic[@"Token"];
            if([dic[@"weixinPayer"]isKindOfClass:[NSNull class]]){
                sing.wechaturl = @"";
            }else{
                sing.wechaturl = dic[@"weixinPayer"];
            }if ([dic[@"alipayer"] isKindOfClass:[NSNull class]]) {
                sing.alipayurl = @"";
            }else{
                sing.alipayurl = dic[@"alipayer"];
            }
            [self.navigationController popToRootViewControllerAnimated:YES];
            [defaultSet loginDataStorage:sing.ID Token:sing.Token];
        }else{
            [CommoneTools alertOnView: self.view content:dic[@"Msg"]];
            [self getImageCode];
        }
   //登录数据的基本存储
    } failuerBlock:^(NSString *str) {
        
    }];
}

- (IBAction)imageCodeClick:(id)sender {
    [self getImageCode];
}

-(void)getImageCode{
    //获取guid
    CFUUIDRef    uuidObj = CFUUIDCreate(nil);
    guidString = (__bridge_transfer NSString *)CFUUIDCreateString(nil, uuidObj);
    NSString *url = [NSString stringWithFormat:@"%@api/Common/GetCode",USERURL];
    NSDictionary *dic =@{
                         @"TUidOrMail":guidString,
                         @"ActionPage":@"loginPage",
                         @"FormPlatform":@100,
                         @"ClientType":@10
                         };
    
    [loginServic getDicData:url Dic:dic Title:nil SuccessBlock:^(NSMutableDictionary *dic) {
        if ([dic[@"OMsg"][@"Flag"] isEqualToString:@"S"]) {
            NSData *data3   = [[NSData alloc] initWithBase64EncodedString:dic[@"CodeByte"] options:NSDataBase64DecodingIgnoreUnknownCharacters];
//            self.imageCode.backgroundColor = [UIColor grayColor];
            [self.imageCode setImage:[UIImage imageWithData:data3] forState:UIControlStateNormal];
        }
    } FailuerBlock:^(NSString *str) {
        
    }];
    
}
@end
