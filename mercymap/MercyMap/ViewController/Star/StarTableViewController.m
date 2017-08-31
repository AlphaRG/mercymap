//
//  StarTableViewController.m
//  MercyMap
//
//  Created by sunshaoxun on 16/4/8.
//  Copyright © 2016年 Wispeed. All rights reserved.
//

#import "StarTableViewController.h"
#import "StarTableViewCell.h"
#import "StarSecondTableViewCell.h"
#import "StarInfornationTableViewController.h"
#import "WalkRouteTableViewController.h"
#import "LightKindTableViewController.h"
#import "LogViewController.h"
#import "LoginService.h"
#import "AppDelegate.h"
#import "ButtonAdd.h"
#import "Single.h"
#import "YCXMenu.h"
#import "AboutUSViewController.h"
#import "MercyInfoTableViewController.h"
#import "AdviceTableViewController.h"
#import "LightListTableViewController.h"
#import "RGshareView.h"
#import "MM_BusinessViewController.h"
#import "MM_BusinessCenterViewController.h"
@interface StarTableViewController ()
{
    LoginService *Service;
    Single *single;
    NSMutableDictionary *dic;
}
@property (nonatomic,strong) NSMutableArray *items;

@end

@implementation StarTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    Service =[[LoginService alloc]init];
    dic=[[NSMutableDictionary alloc]initWithCapacity:0];
    single =[Single Send];
     self.navigationController.navigationBar.barTintColor=[UIColor colorWithRed:120/255.0 green:120/255.0 blue:120/255.0 alpha:0.5];
     [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    UIView *rightView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 80, 30)];
    rightView.backgroundColor = [UIColor colorWithRed:120/255.0 green:120/255.0 blue:120/255.0 alpha:0.5];
    UIButton *rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(50, 0, 30, 30)];
    [rightBtn addTarget:self action:@selector(addSet) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setImage:[UIImage imageNamed:@"set"] forState:UIControlStateNormal];
    UIButton *shareBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    [shareBtn setImage:[UIImage imageNamed:@"分享.png"] forState:UIControlStateNormal];
    [shareBtn addTarget:self action:@selector(share) forControlEvents:UIControlEventTouchUpInside];
    [rightView addSubview:rightBtn];
    [rightView addSubview:shareBtn];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightView];
    self.navigationItem.rightBarButtonItem =rightItem;
    self.edgesForExtendedLayout =UIRectEdgeNone ;
}

-(NSMutableArray *)items {
    if(!_items) {
        _items = [NSMutableArray array];
        _items = [@[
                    [YCXMenuItem menuItem:@"关于我们"
                                    image:[UIImage imageNamed:@""]
                                      tag:101 fag:1
                                 userInfo:@{@"title":@"Menu"}],
                    [YCXMenuItem menuItem:@"帮助与反馈"
                                    image:[UIImage imageNamed:@""]
                                      tag:102 fag:1
                                 userInfo:@{@"title":@"Menu"}],
                    [YCXMenuItem menuItem:@"最新版本"
                                    image:[UIImage imageNamed:@""]
                                      tag:103 fag:1
                                 userInfo:@{@"title":@"Menu"}],
                    [YCXMenuItem menuItem:@"退出"
                                    image:[UIImage imageNamed:@""]
                                      tag:100 fag:1
                                 userInfo:@{@"title":@"Menu"}],
                    ] mutableCopy];
        }
    return _items;
}

-(void)addSet{
    [YCXMenu setTintColor:[UIColor colorWithRed:124/255.0 green:124/255.0 blue:124/255.0 alpha:0.5]];
    if ([YCXMenu isShow]){
        [YCXMenu dismissMenu];
    } else {
        [YCXMenu showMenuInView:self.view fromRect:CGRectMake(self.view.frame.size.width-20,0,0,0) menuItems:self.items selected:^(NSInteger index, YCXMenuItem *item) {
            if (item.tag == 100) {
                [self jump];
            }
            if(item.tag ==101){
               MercyInfoTableViewController *ABVC =[[MercyInfoTableViewController alloc]initWithNibName:@"MercyInfoTableViewController" bundle:nil];
                ABVC.Mfag =1;
                [self.navigationController pushViewController:ABVC animated:YES];
                }
            if (item.tag ==102) {
                AdviceTableViewController *ABVC =[[AdviceTableViewController alloc]initWithNibName:@"AdviceTableViewController" bundle:nil];
                [self.navigationController pushViewController:ABVC animated:YES];
            }
            if (item.tag==103) {
                MercyInfoTableViewController *ABVC =[[MercyInfoTableViewController alloc]initWithNibName:@"MercyInfoTableViewController" bundle:nil];
                ABVC.Mfag =3;
                [self.navigationController pushViewController:ABVC animated:YES];
            }
            if (item.tag ==104) {
            }
        }];
    }
}

-(void)share{
    NSString *Imgstr = [NSString stringWithFormat:@"https://itunes.apple.com/cn/app/le-shan-de-tu/id1137483629?l=en&mt=8"];
    NSString *Img =[Imgstr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    NSString *content = @"乐善地图是一款公益软件，它通过志愿者之间的宣传与积极行动，让人们可以方便的了解和帮助到在我们身边的那些弱势群体。";
    RGshareView *view = [[RGshareView alloc]init];
    [view shareView:self Title:@"乐善地图" Content:content Image:Img];
}

-(void)jump{
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:@"NickName"];
    LogViewController *logVC =[[LogViewController alloc]initWithNibName:@"LogViewController" bundle:nil];
    [logVC setHidesBottomBarWhenPushed:YES];
    [Service firstLogin];
    [self.navigationController pushViewController:logVC animated:YES];
}

-(void)getInforNation{
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"UserLogin"]boolValue]){
        [Service getUser:single.ID Token:single.Token successBlock:^(NSDictionary *model) {
            [dic setDictionary:model];
            [self.tableView reloadData];
        }
        Failuer:^(NSString *error) {
        }];
    }
    else{
            NSString *str =[NSString stringWithFormat:@"游客%d",single.ID];
            NSString *str1 =[NSString stringWithFormat:@"日行一善"];
            NSDictionary *dic1 =@{@"NickName":str,@"Idiograph":str1,@"HeadImg":[NSNull null]};
            [dic addEntriesFromDictionary:dic1];
    }
    [self.tableView reloadData];
}

-(void)viewWillAppear:(BOOL)animated{
    [self getInforNation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    int section;
    if (single.Token != nil){
        section = 6;
     }
    else{
    section =7;
    }
    return section;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
     if (section ==1) {
        return 1;
    }
    else
        return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
 if (indexPath.section==0) {
        return 90;
    }
    else
        return 60;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell =nil;
    if (indexPath.section ==0){
        
        StarTableViewCell *Starcell = [tableView dequeueReusableCellWithIdentifier:@"Star" forIndexPath:indexPath];
        
        if ([dic[@"NickName"] isKindOfClass:[NSNull class]]){
            Starcell.userNameLable.text = @"用户123";
        }
        
        else{
            Starcell.userNameLable.text =[NSString stringWithFormat:@"%@",dic[@"NickName"]];
        }
        
        if ([dic[@"UserName"]isKindOfClass:[NSNull class]]){
            Starcell.introduceselfLable.text =@"";
        }
        else{
          Starcell.introduceselfLable.text=[NSString stringWithFormat:@"%@",dic[@"UserName"]];
        }
        
        if (![dic[@"HeadImg"]isKindOfClass:[NSNull class]]){
            NSString *Imgstr;
            if ([dic[@"HeadImg"] rangeOfString:@"http"].length>0)  {
                Imgstr=[dic[@"HeadImg"] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
            }else{
                NSString *str = [NSString stringWithFormat:@"%@/%@",IMGURL,dic[@"HeadImg"]];
                Imgstr = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
            }
          NSURL *imageUrl =[NSURL URLWithString:Imgstr];
         [Starcell.headImageView sd_setImageWithURL:imageUrl];
        }
        
        else{
            Starcell.headImageView.image =[UIImage imageNamed:@"mine.png"];
        }
        cell=Starcell;
    }
    
    if (indexPath.section ==1){
         StarSecondTableViewCell *secondCell =[tableView dequeueReusableCellWithIdentifier:@"SecondC"forIndexPath:indexPath];
            secondCell.secondImageView.image =[UIImage imageNamed:@"look"];
            secondCell.secondNameLable.text =[NSString stringWithFormat:@"我的关注"];
            cell = secondCell;
    }
    
    if (indexPath.section ==2){
        StarSecondTableViewCell *secondCell =[tableView dequeueReusableCellWithIdentifier:@"SecondC"forIndexPath:indexPath];
        secondCell.secondImageView.image =[UIImage imageNamed:@"tongzhi"];
        secondCell.secondNameLable.text =[NSString stringWithFormat:@"通知"];
        cell = secondCell;
    }
    
    if ( indexPath.section ==3){
        StarSecondTableViewCell *secondCell =[tableView dequeueReusableCellWithIdentifier:@"SecondC"forIndexPath:indexPath];
        secondCell.secondImageView.image =[UIImage imageNamed:@"walk"];
        secondCell.secondNameLable.text =[NSString stringWithFormat:@"足迹"];
        cell = secondCell;
    }
    
    if (indexPath.section == 4) {
        StarSecondTableViewCell *secondCell =[tableView dequeueReusableCellWithIdentifier:@"SecondC"forIndexPath:indexPath];
        secondCell.secondImageView.image =[UIImage imageNamed:@"personnal_center"];
        secondCell.secondNameLable.text =[NSString stringWithFormat:@"个人中心"];
        cell = secondCell;

    }
    
    if (indexPath.section == 5) {
        StarSecondTableViewCell *secondCell =[tableView dequeueReusableCellWithIdentifier:@"SecondC"forIndexPath:indexPath];
        secondCell.secondImageView.image =[UIImage imageNamed:@"mart_center"];
        secondCell.secondNameLable.text =[NSString stringWithFormat:@"商家中心"];
        cell = secondCell;
    }
    
    if ( indexPath.section ==6){
        StarSecondTableViewCell *secondCell =[tableView dequeueReusableCellWithIdentifier:@"SecondC"forIndexPath:indexPath];
        secondCell.secondImageView.image =[UIImage imageNamed:@"renzheng"];
        secondCell.secondNameLable.text =[NSString stringWithFormat:@"用户登录"];
        cell = secondCell;
    }
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section ==0){
     if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"UserLogin"]boolValue]){
        StarInfornationTableViewController *inforVC = [[StarInfornationTableViewController alloc]initWithNibName:@"StarInfornationTableViewController" bundle:nil];
        inforVC.hidesBottomBarWhenPushed =YES;
        [self.navigationController pushViewController:inforVC animated:YES];
      }
      else{
        [self alterController];
      }
     }
    if ( indexPath.section ==1) {
        if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"UserLogin"]boolValue]){
            LightKindTableViewController *lightVC = [self.storyboard instantiateViewControllerWithIdentifier:@"kindS"];
            lightVC.fag1 = 0;
            lightVC.hidesBottomBarWhenPushed =YES;
            [self.navigationController pushViewController:lightVC animated:YES];
          }
         else{
              [self alterController];
             }
    }
    if (indexPath.section ==2) {
        if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"UserLogin"]boolValue]){
            AboutUSViewController *ABVC =[[AboutUSViewController alloc]initWithNibName:@"AboutUSViewController" bundle:nil];
            ABVC.Mfag =1;
            [self.navigationController pushViewController:ABVC animated:YES];
        }
        else{
            [self alterController];
        }
     }
    
    if(indexPath.section == 3){
        if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"UserLogin"]boolValue]){
            WalkRouteTableViewController *walkVC = [[WalkRouteTableViewController alloc]init];
            walkVC.userID = single.ID;
            walkVC.hidesBottomBarWhenPushed =YES;
            [self.navigationController pushViewController:walkVC animated:YES];
        }
        else{
            [self alterController];
        }

    }
    if (indexPath.section == 5) {
//        MM_BusinessViewController *VC = [[MM_BusinessViewController alloc]init];
        MM_BusinessCenterViewController *VC = [[MM_BusinessCenterViewController alloc]init];
        [self.navigationController pushViewController:VC animated:YES];
    }
    
    if (indexPath.section ==6){
       LogViewController *logVC =[[LogViewController alloc]initWithNibName:@"LogViewController" bundle:nil];
        //隐藏tabbar
        [logVC setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:logVC animated:YES];
    }
}
-(void)alterController{
    UIAlertController *alterController =[UIAlertController alertControllerWithTitle:@"温馨提示" message:@"请先登录" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *OK =[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        LogViewController *logVC =[[LogViewController alloc]initWithNibName:@"LogViewController" bundle:nil];
        [logVC setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:logVC animated:YES];
    }];
    [alterController addAction:OK];
    [self presentViewController:alterController animated:YES completion:nil];
}
@end


