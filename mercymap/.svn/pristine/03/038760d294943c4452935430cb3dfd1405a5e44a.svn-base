//
//  ZZTableViewController.m
//  Ours
//
//  Created by iMac on 16/7/14.
//  Copyright © 2016年 Eric. All rights reserved.
//

#import "ZZTableViewController.h"
#import "UITableView+RegiesterCell.h"
@interface ZZTableViewController ()

@end

@implementation ZZTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.tableFooterView = [self tableViewFooterView];
    self.tableView.tableHeaderView = [self tableViewHeaderView];
}

- (UIView *)tableViewFooterView {
    return [[UIView alloc]init];
}

- (UIView *)tableViewHeaderView {
    return [[UIView alloc]init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataArray[section] count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZZBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[self cellIdentifyAtIndexPath:indexPath] forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.tag = indexPath.section*10000 + indexPath.row;
    cell.delegate = self;
   [cell configData:self.dataArray[indexPath.section][indexPath.row]];
    return cell;
}

- (NSString *)cellIdentifyAtIndexPath:(NSIndexPath *)indexPath {
    return [NSString stringWithFormat:@"%@Cell",NSStringFromClass([self class])];
}

- (NSArray<NSString *> *)registerCell {
    return @[[NSString stringWithFormat:@"%@Cell",NSStringFromClass([self class])]];
}

- (void)cell:(ZZBaseTableViewCell *)cell InteractionEvent:(id)clickInfo {
    
}

-(void)sendImgs:(NSMutableArray *)imageArray{
    
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView  = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        [self.tableView registerClass:[self registerCell]];
    }
    return _tableView;
}

- (NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [[NSMutableArray alloc]initWithCapacity:0];
    }
    return _dataArray;
}

-(NSMutableDictionary *)headCommentArray{
    if (_headCommentDic == nil) {
        _headCommentDic = [NSMutableDictionary dictionaryWithCapacity:0];
    }
    return _headCommentDic;
}
@end
