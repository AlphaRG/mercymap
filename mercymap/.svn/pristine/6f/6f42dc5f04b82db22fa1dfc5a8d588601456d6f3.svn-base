//
//  ZZTableViewController.h
//  Ours
//
//  Created by iMac on 16/7/14.
//  Copyright © 2016年 Eric. All rights reserved.
//


#import "ZZBaseTableViewCell.h"
#import <UIKit/UIKit.h>

@interface ZZTableViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,ZZBaseTableViewCellDelegate>

@property(nonatomic,strong)NSMutableDictionary *headCommentDic;
@property(nonatomic,assign)NSInteger shopID;
@property(nonatomic,assign)int parentID;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UITableView *tableView;

/**
 *  返回cell重用标识符
 *
 *  @param indexPath
 *
 *  @return 默认返回 类名+Cell 重写应该直接覆盖
 */
- (NSString *)cellIdentifyAtIndexPath:(NSIndexPath *)indexPath;
/**
 *  返回注册的cell
 *
 *  @return
 */
- (NSArray<NSString *> *)registerCell;
/**
 *  返回表头或者表尾
 *
 *  @return 默认返回view 重写应该直接覆盖
 */
- (UIView *)tableViewFooterView;
- (UIView *)tableViewHeaderView;


/**
 *  处理cell上的一些交互事件
 *
 *  @param clickInfo 事件信息
 */
- (void)cell:(ZZBaseTableViewCell *)cell InteractionEvent:(id)clickInfo;

@end
