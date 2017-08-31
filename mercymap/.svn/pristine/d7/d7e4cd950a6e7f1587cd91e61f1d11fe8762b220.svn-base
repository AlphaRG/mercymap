//
//  StarFirstViewController.m
//  MercyMap
//
//  Created by sunshaoxun on 16/4/21.
//  Copyright © 2016年 Wispeed. All rights reserved.
//

#import "StarFirstViewController.h"
#import "LoginService.h"
#import "Single.h"
#import "StarInfornationTableViewController.h"
@interface StarFirstViewController ()<UITextFieldDelegate>
{
    UIButton *rightBtn;
    LoginService *service;
    Single *single;
}

@end

@implementation StarFirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_EditTextFile becomeFirstResponder];
    _EditTextFile.delegate =self;
    service = [[LoginService alloc]init];
    single = [Single Send];
    [self setTextLable];
    self.title =_titlename;
    
    rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    [rightBtn setImage:[UIImage imageNamed:@"over2"] forState:UIControlStateNormal];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem =rightItem;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"navBackBtn@2x"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(navLeftBtnClick)];

}

-(void)navLeftBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)setTextLable{
    if (_tag==1) {
        
        if ([_textfiledname isKindOfClass:[NSNull class]]) {
          _EditTextFile.placeholder =@"请输入你的宣言";
        }
        else{
            _EditTextFile.text =_textfiledname;
        }
        _introduceLable.text =[NSString stringWithFormat:@"写下你的个人信条"];
    }else if (_tag ==2){
        if ([_textfiledname isKindOfClass:[NSNull class]]) {
            _EditTextFile.placeholder =@"请修改您的用户名";
        }
        else{
            _EditTextFile.text =_textfiledname;
        }
        _introduceLable.text =[NSString stringWithFormat:@"用户名长度为4～15个字符,必须由字母开头、数字0～9、点、减号或下划线组成"];
    }
    else{
        if ([_textfiledname isKindOfClass:[NSNull class]]) {
            _EditTextFile.placeholder =@"你的昵称";
            }
        else{
            _EditTextFile.text =_textfiledname;
            }
    }
}



-(void)Over{
    NSDictionary *dic,*lastdic;
    NSNumber *uid = [NSNumber numberWithInt:single.ID];
    NSString *url = [NSString stringWithFormat:@"%@api/Account/MemberUpdate",USERURL];
    switch (_tag) {
        case 0:
             dic=@{@"NickName":self.EditTextFile.text};
             lastdic =@{
                       @"_Members":dic,
                       @"Token":single.Token,
                       @"UID":uid,
                       @"FormPlatform":@100,
                       @"ClientType":@10
                       };
            break;
        case 1:
            dic=@{@"Idiograph":self.EditTextFile.text};
            lastdic =@{
                       @"_Members":dic,
                       @"Token":single.Token,
                       @"UID":uid,
                       @"FormPlatform":@100,
                       @"ClientType":@10
                       };
            break;
            
        case 2:
            url= [NSString stringWithFormat:@"%@api/Account/MemberUpdateForUserName",USERURL];
            lastdic =@{
                       @"ChangeUserName":self.EditTextFile.text,
                       @"Token":single.Token,
                       @"UID":uid,
                       @"FormPlatform":@100,
                       @"ClientType":@10
                       };
            break;
        default:
            break;
    }
       [service getDicData:url Dic:lastdic Title:nil SuccessBlock:^(NSMutableDictionary *dic) {
        if ([dic[@"Flag"]isEqualToString:@"S"]) {
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [CommoneTools alertOnView:self.view content:dic[@"Msg"]];
        }
    } FailuerBlock:^(NSString *str) {
        
    }];    
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    [rightBtn setEnabled:YES];
    [rightBtn setImage:[UIImage imageNamed:@"over"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(Over) forControlEvents:UIControlEventTouchUpInside];
    return YES;
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    [rightBtn setImage:[UIImage imageNamed:@"over2"] forState:UIControlStateNormal];
    [rightBtn setEnabled:NO];
    return YES;
}

@end
