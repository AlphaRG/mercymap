//
//  LightHeadTableViewCell.h
//  MercyMap
//
//  Created by sunshaoxun on 16/4/8.
//  Copyright © 2016年 Wispeed. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDCycleScrollView.h"
@protocol singleTapsDelegate<NSObject>
-(void)singleTaps:(int)ID;
//-(void)sendArr:(NSMutableArray *)headArray;
@end

@interface LightHeadTableViewCell : UITableViewCell<UIScrollViewDelegate,SDCycleScrollViewDelegate>
@property (nonatomic ,weak) id<singleTapsDelegate>delegate;
@property (weak, nonatomic) IBOutlet UILabel *introduceLable;
@property (weak, nonatomic) IBOutlet UIScrollView *pageScrollView;
@property (weak, nonatomic) IBOutlet UIView *StoryView;
@property (nonatomic,strong)NSArray *dataArray;
- (void)configData:(NSArray *)data ;
-(void)changePage;

@end
