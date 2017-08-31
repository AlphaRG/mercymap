//
//  LightListInfoTableViewCell.h
//  MercyMap
//
//  Created by sunshaoxun on 16/4/26.
//  Copyright © 2016年 Wispeed. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZLSelectPhotoModel.h"
@protocol dianzanDelegate<NSObject>
-(void)sendDianzanDelegaet:(int)fag;
-(void)sendBigImage:(NSMutableArray<NSURL *> *)imagesArray imagetag:(int)tag;
@end

@interface LightListInfoTableViewCell : UITableViewCell

{
    NSMutableArray<NSURL *> *arrImage;
//    UIImageView *imgView;
}
@property(nonatomic,weak)id<dianzanDelegate>Ddelegaet;

@property (weak, nonatomic) IBOutlet UILabel *LightNameLable;
@property (weak, nonatomic) IBOutlet UILabel *LightdistanceLable;
@property (weak, nonatomic) IBOutlet UIImageView *LightHeadImageView;
@property (weak, nonatomic) IBOutlet UILabel *LightHomeLable;

@property (weak, nonatomic) IBOutlet UILabel *LightworkTimeLable;
@property (weak, nonatomic) IBOutlet UILabel *LightstoryLable;
@property (weak, nonatomic) IBOutlet UIView *LightPhotoView;
@property (weak, nonatomic) IBOutlet UIButton *LightenjoyBtn;
- (IBAction)LightenjoyBtnClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *LightdianzanBtn;
@property (weak, nonatomic) IBOutlet UIButton *LightPinglunBtn;
- (IBAction)LightdianzanBtnClick:(id)sender;
- (IBAction)LightpinglunBtnClick:(id)sender;
- (IBAction)commentBtnClick:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *commentNum;
@property (weak, nonatomic) IBOutlet UIButton *shoucangBtn;
@property (weak, nonatomic) IBOutlet UILabel *dianzanNum;
- (IBAction)shoucangBtnClick:(id)sender;
-(void)setCellInfo:(NSDictionary *)dic fag:(int)fag Collectionfag:(int)collectFag;
@end
