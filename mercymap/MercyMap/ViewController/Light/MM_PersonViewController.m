//
//  MM_PersonViewController.m
//  MercyMap
//
//  Created by RainGu on 17/2/16.
//  Copyright © 2017年 Wispeed. All rights reserved.
//

#import "MM_PersonViewController.h"
#import "MM_PersonChooseCell.h"
@interface MM_PersonViewController ()
{
    NSArray *_personArray;
}
@end
@implementation MM_PersonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"谁可以看";
    _personArray = @[@{@"title":@"全部",@"explain":@"所有人都可以看见"},@{@"title":@"私密",@"explain":@"仅自己可以看见"},@{@"title":@"好友",@"explain":@"自己的好友可见"}];
    [self.dataArray addObject:_personArray];
    [self.tableView registerClass:@[@"MM_PersonChooseCell"]];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"navBackBtn@2x"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ]style:UIBarButtonItemStylePlain target:self action:@selector(naveLeftBtnClick)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(naveRightBtnClick)];
}

-(void)naveLeftBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)naveRightBtnClick{
     self.sendPersontag(self.selectedIndexPath.row);
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 62;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell ;
    MM_PersonChooseCell *choosecell = [tableView dequeueReusableCellWithIdentifier:@"MM_PersonChooseCell" forIndexPath:indexPath];
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        self.selectedIndexPath =indexPath;
    });
    
    if ([self.selectedIndexPath isEqual:indexPath]) {
        choosecell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else{
        choosecell.accessoryType = UITableViewCellAccessoryNone;
    }
    cell = choosecell;
    [choosecell configData:_personArray[indexPath.row]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell ;
    if ([self.selectedIndexPath isEqual:indexPath]) {
    }else{
        cell =[tableView cellForRowAtIndexPath:indexPath];
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        cell = [tableView cellForRowAtIndexPath:self.selectedIndexPath];
        cell.accessoryType = UITableViewCellAccessoryNone;
        self.selectedIndexPath = indexPath;
    }
}
@end
