//
//  ZZBaseTableViewCell.h
//  Ours
//
//  Created by iMac on 16/7/14.
//  Copyright © 2016年 Eric. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZZBaseTableViewCell;

@protocol ZZBaseTableViewCellDelegate <NSObject>

- (void)cell:(ZZBaseTableViewCell *)cell InteractionEvent:(id)clickInfo;
-(void)sendImgs:(NSMutableArray *)imageArray;

@end

@interface ZZBaseTableViewCell : UITableViewCell

@property (nonatomic, weak) id<ZZBaseTableViewCellDelegate>delegate;


- (void)configData:(id)data;


@end
