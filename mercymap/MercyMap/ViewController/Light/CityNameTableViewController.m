//
//  CityNameTableViewController.m
//  MercyMap
//
//  Created by sunshaoxun on 16/7/18.
//  Copyright © 2016年 Wispeed. All rights reserved.

#import "CityNameTableViewController.h"
#import "CityTableViewCell.h"
#import "Single.h"
#import "LoginService.h"
@interface CityNameTableViewController (){
    NSDictionary *dataDic;
    NSArray *dataArray;
}
@end

@implementation CityNameTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *path =[[NSBundle mainBundle]pathForResource:@"cityData" ofType:@"plist"];
    self.tableView.showsVerticalScrollIndicator = NO;
    self.title =@"城市选择";
    dataDic =[[NSDictionary alloc]initWithContentsOfFile:path];
    dataArray = [dataDic objectForKey:_ProvincesName];
    self.edgesForExtendedLayout = UIRectEdgeNone ;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"navBackBtn@2x"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ]style:UIBarButtonItemStylePlain target:self action:@selector(navLeftBtnClick)];
    [self.tableView registerNib:@[@"CityTableViewCell"]];
}

-(void)navLeftBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CityTableViewCell" forIndexPath:indexPath];
    cell.citiesNameLable.hidden = YES;
    cell.cityNameLable.text     = dataArray[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_fag ==1){
        
      [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"CityName"];
      [[NSUserDefaults standardUserDefaults]setObject:dataArray[indexPath.row] forKey:@"CityName"];
      [self.navigationController popToRootViewControllerAnimated:YES];
    }else{
        
        LoginService *service = [[LoginService alloc]init];
        Single *single = [Single Send];
//        [service fixUserCity:single.ID Token:single.Token Province:_ProvincesName City:dataArray[indexPath.row] successBlock:^(NSDictionary *model) {
//            
//                if ([model[@"Flag"]isEqualToString:@"S"]){
//                        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
//                    }
//                    
//                } Failuer:^(NSString *error) {
//                    
//                }];
        
        NSDictionary *dic =@{
                             @"Province":_ProvincesName,
                             @"City":dataArray[indexPath.row]
                                 };
        NSNumber *uid = [NSNumber numberWithInt:single.ID];
        NSDictionary *lastdic =@{
                                 @"_Members":dic,
                                 @"Token":single.Token,
                                 @"UID":uid,
                                 @"FormPlatform":@100,
                                 @"ClientType":@10
                                 };
        NSString *url = [NSString stringWithFormat:@"%@api/Account/MemberUpdate",USERURL];
  [service getDicData:url Dic:lastdic Title:nil SuccessBlock:^(NSMutableDictionary *dic) {
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
        } FailuerBlock:^(NSString *str) {
            
        }];
    }
}
@end
