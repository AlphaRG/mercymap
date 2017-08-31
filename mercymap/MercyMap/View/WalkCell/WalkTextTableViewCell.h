//
//  WalkTextTableViewCell.h
//  MercyMap
//
//  Created by sunshaoxun on 16/9/16.
//  Copyright © 2016年 Wispeed. All rights reserved.
//

#import "ZZBaseTableViewCell.h"

@interface WalkTextTableViewCell : ZZBaseTableViewCell
@property(nonatomic,strong)UILabel  *number;
@property(nonatomic,strong)UIButton *head;
@property(nonatomic,strong)UILabel  *name;
@property(nonatomic,strong)UILabel  *time;
@property(nonatomic,strong)UIView   *cellView;
@property(nonatomic,strong)UILabel  *ligtenNum;
@property(nonatomic,strong)UIButton  *ligtenImg;
@end
