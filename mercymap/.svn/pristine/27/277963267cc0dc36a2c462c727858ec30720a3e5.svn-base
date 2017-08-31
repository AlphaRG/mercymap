//
//  CityTableViewController.m
//  MercyMap
//
//  Created by sunshaoxun on 16/4/28.
//  Copyright © 2016年 Wispeed. All rights reserved.
//

#import "CityTableViewController.h"
#import "CityTableViewCell.h"
#import "StarInfornationTableViewController.h"
#import "LoginService.h"
#import "Single.h"
#import "CityNameTableViewController.h"

@interface CityTableViewController ()
{
    NSDictionary *dataDic;
    NSArray *dataArray;
    LoginService *service;
    Single *single;
    NSString *Citystr;
    
    int _openSection;//当前展开的区
}
@end

@implementation CityTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *path =[[NSBundle mainBundle]pathForResource:@"cityData" ofType:@"plist"];
    self.tableView.showsVerticalScrollIndicator = NO;
    self.title =@"省份选择";
    
    dataDic =[[NSDictionary alloc]initWithContentsOfFile:path];
    dataArray =[dataDic allKeys];
    
    UINib *nib = [UINib nibWithNibName:@"CityTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"CityID"];
    
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"navBackBtn@2x"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(navLeftBtnClick)];

    service =[[LoginService alloc]init];
    single  =[Single Send];
    
    self.edgesForExtendedLayout  = UIRectEdgeNone;
    
}
-(void)navLeftBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//    return dataDic.count+1;
    return 1;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return 2;
    }
    
    return 20;
}

//- (NSString* )tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    NSString *string ;
//    NSLog(@"%ld",(long)section);
//    if (section==0)
//    {
//        string =@"";
//    }
//    else
//    {
//        
//        NSString *str = [dataArray objectAtIndex:section-1];
//        string =str;
//    }
//    
//    return string;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    NSInteger CC;
//    if (section==0)
//    {
//        CC=1;
//    }
//    else
//    {
//        
//        NSString *str = [dataArray objectAtIndex:section-1];
//        NSLog(@"%@",str);
//        
//        NSArray *dateArray =[dataDic objectForKey:str];
//        
//        CC =dateArray.count;
//    }
//    
//    return CC;
//    return dataDic.count +1;
    return dataArray.count;
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell =nil;
    
    CityTableViewCell *cityVC =[tableView dequeueReusableCellWithIdentifier:@"CityID" forIndexPath:indexPath];
    
//    if (indexPath.section==0)
//    {
//        cityVC.cityNameLable.text=@"当前位置";
//        cityVC.citiesNameLable.hidden =YES;
//        cell=cityVC;
//    }
//    else
//    {
//        NSArray *dateArray=[dataDic objectForKey:[NSString stringWithFormat:@"%@",dataArray[indexPath.section-1]]];
        NSString *str = [dataArray objectAtIndex:indexPath.row];
        
        cityVC.citiesNameLable.hidden =YES;
        cityVC.cityNameLable.text=str;
        cell= cityVC;
        
//    }
//    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CityNameTableViewController *CVC = [[CityNameTableViewController  alloc]initWithNibName:@"CityTableViewController" bundle:nil];
    CVC.ProvincesName                = [dataArray objectAtIndex:indexPath.row];
    CVC.fag = self.fag;
    
     [self.navigationController pushViewController:CVC animated:YES];
    
//    if (_fag==1)
//    {
//       [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"CityName"];
//        NSString *str1 =dataArray[indexPath.section-1];
//
//        NSArray *dateArray=[dataDic objectForKey:[NSString stringWithFormat:@"%@",str1]];
//        
//        NSString *str =[dateArray objectAtIndex:indexPath.row];
//
//        NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
//        [defaults setObject:str forKey:@"CityName"];
//        Citystr = str;
//        
//        self.ReturnBlock(Citystr);
//        [self.navigationController popViewControllerAnimated:YES];
//    }
//    
//   else if (_fag==2)
//    {
//       
//        NSString *str1 =dataArray[indexPath.section-1];
//        
//        NSArray *dateArray=[dataDic objectForKey:[NSString stringWithFormat:@"%@",str1]];
//        
//        NSString *str =[dateArray objectAtIndex:indexPath.row];
//        Citystr = str;
//        
//        self.ReturnBlock(Citystr);
//        [self.navigationController popViewControllerAnimated:YES];
//        
//    }
//   
//    else
//    {
//      
//    
//    NSArray *dateArray=[dataDic objectForKey:[NSString stringWithFormat:@"%@",dataArray[indexPath.section-1]]];
//    
//    NSString *str1 =dataArray[indexPath.section-1];
//    NSString *str =[dateArray objectAtIndex:indexPath.row];
//    NSString *cityStr =[NSString stringWithFormat:@"%@ %@",str1,str];
//   
//    
//    [service fixUserCity:single.ID Token:single.Token Province:str1 City:str successBlock:^(NSDictionary *model) {
//        
//    if ([model[@"Flag"]isEqualToString:@"S"])
//        {
//            self.ReturnBlock(cityStr);
//            
//            [self.navigationController popViewControllerAnimated:YES];
//            
//        }
//
//        
//        
//    } Failuer:^(NSString *error) {
//        
//    }];
//    
//  }
    
    
    
}

@end
