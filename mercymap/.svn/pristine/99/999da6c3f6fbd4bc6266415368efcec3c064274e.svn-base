//
//  MM_BusinessViewController.m
//  MercyMap
//
//  Created by RainGu on 17/2/21.
//  Copyright © 2017年 Wispeed. All rights reserved.
//

#import "MM_BusinessViewController.h"
#import "MM_BusinessTableViewCell.h"
#import "LoginService.h"
#import "Single.h"
@interface MM_BusinessViewController ()<UITextFieldDelegate>
{
    LoginService *_service;
    Single       *_single;
    NSNumber     *_shopOwnerID;
}
@end

@implementation MM_BusinessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"店家转移";
    _single = [Single Send];
    NSArray *array =  @[@"1"];
    [self.dataArray addObject:array];
    [self.tableView registerClass:@[@"MM_BusinessTableViewCell"]];
     self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"navBackBtn@2x"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ]style:UIBarButtonItemStylePlain target:self action:@selector(navleftBtnClick)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(navrightBtnClick)];
    _service = [[LoginService alloc]init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)navleftBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)navrightBtnClick{
    if (_shopOwnerID == nil) {
        [CommoneTools alertOnView:self.view content:@"请填写正确的用户"];
    } else{
    NSString *url = [NSString stringWithFormat:@"%@api/Shop/ShopTransfer",URLM];
    NSDictionary *dic1 =@{
                            @"UserID":_shopOwnerID,
                            @"ShopID":[NSNumber numberWithLong:self.shopID],
                            @"FormUserID":[NSNumber numberWithLong:_single.ID],
                         };
        
    NSDictionary *dic=@{
                         @"Token":_single.Token,
                         @"UID":[NSNumber numberWithInt:_single.ID],
                         @"FormPlatform":@100,
                         @"ClientType":@10,
                         @"IShopOwner":dic1
                       };
        
    [_service getDicData:url Dic:dic Title:nil SuccessBlock:^(NSMutableDictionary *dic) {
        if ([dic[@"Flag"]isEqualToString:@"S"]) {
            [CommoneTools alertOnView: self.view content:dic[@"Msg"]];
   //       [self.navigationController popViewControllerAnimated:YES];
        }else{
            [CommoneTools alertOnView: self.view content:dic[@"Msg"]];
        }
    } FailuerBlock:^(NSString *str) {
        [CommoneTools alertOnView: self.view content:str];
    }];
  }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height;
    height = kSCREENHEIGTH;
    return height;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell ;
    MM_BusinessTableViewCell *bcell = [tableView dequeueReusableCellWithIdentifier:@"MM_BusinessTableViewCell" forIndexPath:indexPath];
    bcell.usernameTextField.delegate = self;
    cell = bcell;
    return cell;
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    NSString *url = [NSString stringWithFormat:@"%@api/Account/MemberIdForUserName",USERURL];
    NSDictionary *dic =@{
                         @"UserName":textField.text,
                         @"FormPlatform":@100,
                         @"ClientType":@10
                         };
    [_service getDicData:url Dic:dic Title:nil   SuccessBlock:^(NSMutableDictionary *dic) {
        if ([dic[@"OMsg"][@"Flag"] isEqualToString:@"S"]) {
            _shopOwnerID = [NSNumber numberWithLong:[dic[@"UID"] longValue]];
        }else{
            _shopOwnerID = nil;
            [CommoneTools alertOnView:self.view content:dic[@"OMsg"][@"Msg"]];
        }
    } FailuerBlock:^(NSString *str) {
        [CommoneTools alertOnView:self.view content:str];
    }];
}
@end
