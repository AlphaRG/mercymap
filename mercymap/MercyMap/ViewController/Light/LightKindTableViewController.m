//
//  LightKindTableViewController.m
//  MercyMap
//
//  Created by sunshaoxun on 16/4/11.
//  Copyright © 2016年 Wispeed. All rights reserved.
//

#import "LightKindTableViewController.h"
#import "LoginService.h"
#import "LightListKindTableViewCell.h"
#import "LightListTableViewController.h"
#import "MJRefresh.h"
#import "Single.h"
#import "LightDetailsViewController.h"
@interface LightKindTableViewController ()
{
    LoginService *SerVice;
    int pageNum;
    NSMutableArray *finallyArray;
}
@end

@implementation LightKindTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    SerVice = [[LoginService alloc]init];
    self.tableView.showsVerticalScrollIndicator = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    finallyArray = [[NSMutableArray alloc]initWithCapacity:0];
    pageNum =0;
    [self kindChooseMore];
    self.tableView.footer =[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self performSelector:@selector(kindChooseMore) withObject:self afterDelay:1];
    }];
   self.tableView.header =[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        pageNum =0;
       [self kindChooseMore];
    }];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"navBackBtn@2x"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(navLeftBtnClick)];
}

-(void)navLeftBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)kindChooseMore{
    if (_fag1 ==0) {
        Single *single =[Single Send];
        self.title =@"我的关注";
        
        [SerVice CollectionInfo:single.ID FocusType:1 Token:single.Token PageSize:20 PageIndex:pageNum SuccesBlock:^(NSArray *modelArray) {
            if (pageNum ==0) {
                [finallyArray removeAllObjects];
            }
            pageNum ++;
            [finallyArray addObjectsFromArray:modelArray];
            [self.tableView reloadData];
            [self.tableView.footer endRefreshing];
            [self.tableView.header endRefreshing];
            if (modelArray.count==0) {
                [self.tableView.footer endRefreshingWithNoMoreData];
            }
         } FailuerBlock:^(NSString *error) {
            [MBProgressHUD hideAllHUDsForView:self.tableView animated:YES];
        }];
    }
    else{
        switch (_fag1) {
            case  1:self.title =@"甜点";
                break;
            case 2:self.title =@"主食";
                break;
            case 3:self.title=@"小吃";
                break;
            case 4:self.title= @"其他";
                break;
            default:
                break;
        }
     [SerVice getLightKindInfornation:self.fag1 PageIndex:pageNum PageSize:20 successBlock:^(NSArray *modelArray){
        if (pageNum ==0) {
            [finallyArray removeAllObjects];
        }
        pageNum ++;
        [finallyArray addObjectsFromArray:modelArray];
        [self.tableView reloadData];
        [self.tableView.footer endRefreshing];
        [self.tableView.header endRefreshing];
        if (modelArray.count==0) {
            [self.tableView.footer endRefreshingWithNoMoreData];
        }
  }
  Failuer:^(NSString *error){
        [MBProgressHUD hideAllHUDsForView:self.tableView animated:YES];
         }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return finallyArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LightListKindTableViewCell *ListCell = [tableView dequeueReusableCellWithIdentifier:@"LightCell"forIndexPath:indexPath];
    ListCell.LightNameLable.text =finallyArray[indexPath.row][@"ShopName"];
    ListCell.LightIntroduceLable.text =finallyArray[indexPath.row][@"ShopStory"];
    ListCell.dianzanLable.text =[NSString stringWithFormat:@"%d",[finallyArray[indexPath.row][@"LikedCount"] intValue]];
    ListCell.pinglunLable.text =[NSString stringWithFormat:@"%d",[finallyArray[indexPath.row][@"CommentCount"]intValue]];
    NSString *str =[NSString stringWithFormat:@"%@",finallyArray[indexPath.row][@"ShopMainImg"]];
    NSString *Imgstr =[str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@img/%@",URLM,Imgstr]];
    [ListCell.LightHeadImageLable sd_setImageWithURL:url];
    return ListCell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    LightDetailsViewController *detailsVC = [[LightDetailsViewController alloc]init];
    [detailsVC setHidesBottomBarWhenPushed:YES];
    if (_fag1==0) {
        detailsVC.ID =[finallyArray[indexPath.row][@"ShopID"]intValue];
    }else{
        detailsVC.ID =[finallyArray[indexPath.row][@"ID"]intValue];
    }
    [self.navigationController pushViewController:detailsVC animated:YES];
}
@end
