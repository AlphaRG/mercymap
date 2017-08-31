//
//  MM_BusinessInfoViewController.m
//  MercyMap
//
//  Created by RainGu on 17/3/7.
//  Copyright © 2017年 Wispeed. All rights reserved.
//

#import "MM_BusinessInfoViewController.h"
#import "LoginService.h"
#import "Single.h"
#import "MJRefresh.h"
#import "MM_BusinessViewController.h"
#import "MM_BusinnessInfoCell.h"
@interface MM_BusinessInfoViewController ()
{
    LoginService *_servince;
    Single *_single;
    int i;
    
}
@end

@implementation MM_BusinessInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _servince = [[LoginService alloc]init];
    _single = [Single Send];
    self.title = @"商家列表";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"navBackBtn@2x"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ]style:UIBarButtonItemStylePlain target:self action:@selector(navleftBtnClick)];
    self.tableView.footer=[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self getnfo];
        }];
    
    self.tableView.header =[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        i=0;
        [self getnfo];
    }];
    [self.tableView registerClass:@[@"MM_BusinnessInfoCell"]];
}

-(void)navleftBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)getnfo{
    NSNumber *uid = [NSNumber numberWithInt:_single.ID];
    NSDictionary *dic = @{
                          @"PageIndex":[NSNumber numberWithInt:i],
                          @"PageSize":@40,
                          @"Token":_single.Token,
                          @"UID":uid,
                          @"FormPlatform":@100,
                          @"ClientType":@10
                         };
    NSString *url = [NSString stringWithFormat:@"%@api/Account/UserShopList",URLM];
    [_servince getDicData:url Dic:dic Title:nil SuccessBlock:^(NSMutableDictionary *dic) {
        if ([dic[@"OMsg"][@"Flag"] isEqualToString:@"S"]) {
            if (i==0) {
                [self.dataArray removeAllObjects];
            }
            [self.dataArray addObject:dic[@"ShopOwner"]];
        }else{
            [CommoneTools alertOnView:self.view content:dic[@"OMsg"][@"Msg"]];
        }
        i++;
        [self.tableView.footer endRefreshing];
        [self.tableView.header endRefreshing];
        [self.tableView reloadData];
    } FailuerBlock:^(NSString *str) {
        [CommoneTools alertOnView:self.view content:str];
        [self.tableView.footer endRefreshing];
        [self.tableView.header endRefreshing];
    }];
}

-(void)viewWillAppear:(BOOL)animated{
    i=0;
    [self getnfo];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell;
    MM_BusinnessInfoCell *infocell = [tableView dequeueReusableCellWithIdentifier:@"MM_BusinnessInfoCell" forIndexPath:indexPath];
    [infocell configData:self.dataArray[indexPath.section][indexPath.row]];
    cell = infocell ;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MM_BusinessViewController *VC = [[MM_BusinessViewController alloc]init];
    VC.shopID = [self.dataArray[indexPath.section][indexPath.row][@"ShopID"] intValue];
    [self.navigationController pushViewController:VC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
