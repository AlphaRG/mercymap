//
//  MercyInfoTableViewController.m
//  MercyMap
//
//  Created by sunshaoxun on 16/7/4.
//  Copyright © 2016年 Wispeed. All rights reserved.
//

#import "MercyInfoTableViewController.h"
#import "MercyInfoTableViewCell.h"
#import "BaseHttpRequest.h"
@interface MercyInfoTableViewController ()
{
    NSMutableArray *dataArray;
}

@end

@implementation MercyInfoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    dataArray =[[NSMutableArray alloc]initWithCapacity:0];
    
    UINib *nib = [UINib nibWithNibName:@"MercyInfoTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"Minfocell"];
    [self settitle];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"navBackBtn@2x"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(navLeftBtnClick)];
    self.edgesForExtendedLayout = UIRectEdgeNone;
}

-(void)navLeftBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
    
}
-(void)settitle
{
    if (_Mfag ==1) {
         self.title =@"关于我们";
    }
    else if(_Mfag ==2)
    {
        self.title =@"帮助与反馈";
    }
    else{
        self.title =@"最新版本";
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

-(void)getMercyInfo:(int)fag{
    BaseHttpRequest *serVice  =[[BaseHttpRequest alloc]init];
    NSString *url =[NSString stringWithFormat:@"%@api/Common/MercymapConfig",URLM];
    NSDictionary *dic = @{
                          @"FormPlatform":@100,
                          @"FormPlatform":@10
                          };
    [serVice sendRequestHttp:url parameters:dic Success:^(NSDictionary *dicData) {
        if (fag==1)
        {
            [dataArray addObject: dicData[@"MercyMapConfig"][@"AboutUS"]];
        }
        else if (fag==2)
        {
            [dataArray addObject:dicData[@"MercyMapConfig"][@"DirectionsForuse"]];
        }
        else if (fag==3)
        {
         NSDictionary *dicInfo = [[NSBundle mainBundle]infoDictionary];
         NSString *AppVersion = [dicInfo objectForKey:@"CFBundleShortVersionString"];
         [dataArray addObject: [NSString stringWithFormat:@"当前版本:  %@",AppVersion]];
        }
        [self.tableView reloadData];

    } Failuer:^(NSString *errorInfo) {
        
    }];
    
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   
    return dataArray.count;
}

-(void)viewWillAppear:(BOOL)animated
{
    [self getMercyInfo:self.Mfag];
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat contentHight=0.0f;
    if (![dataArray[indexPath.row] isKindOfClass:[NSNull class]]){
     NSString *contentStr = [NSString stringWithFormat:@"%@",dataArray[indexPath.row]];
        CGSize size1 = [contentStr calculateSize:CGSizeMake(self.view.frame.size.width-10, FLT_MAX) font:[UIFont systemFontOfSize:16]];
    contentHight =size1.height+35;
    }
   return contentHight+20;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    MercyInfoTableViewCell *infocell =[tableView dequeueReusableCellWithIdentifier:@"Minfocell"forIndexPath:indexPath];
     [infocell setcontentLable:dataArray];
     return infocell;
}

-(void)viewWillDisappear:(BOOL)animated{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
@end
