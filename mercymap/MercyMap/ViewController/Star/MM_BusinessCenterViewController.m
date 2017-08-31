//
//  MM_BusinessCenterViewController.m
//  MercyMap
//
//  Created by RainGu on 17/2/22.
//  Copyright © 2017年 Wispeed. All rights reserved.
//

#import "MM_BusinessCenterViewController.h"
#import "LightAddreCell.h"
#import "MM_BusinessInfoViewController.h"
@interface MM_BusinessCenterViewController ()

@end

@implementation MM_BusinessCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"商家中心";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"navBackBtn@2x"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ]style:UIBarButtonItemStylePlain target:self action:@selector(navleftBtnClick)];
    [self.tableView registerClass:@[@"LightAddreCell"]];
    NSArray *array = @[@{@"title":@"我的商家",@"image":@"myshop_center"}];
    [self.dataArray addObject:array];
}

-(void)navleftBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell;
    LightAddreCell *addrecell = [tableView dequeueReusableCellWithIdentifier:@"LightAddreCell" forIndexPath:indexPath];
    addrecell.delegate =self;
    addrecell.cellSepter.hidden = YES;
    addrecell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [addrecell configData:self.dataArray[indexPath.section][indexPath.row]];
    addrecell.noOryes.hidden =YES;
    cell = addrecell;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MM_BusinessInfoViewController *VC = [[MM_BusinessInfoViewController alloc]init];
    [self.navigationController pushViewController:VC animated:YES];
}

@end
